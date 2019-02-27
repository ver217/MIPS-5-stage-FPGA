module top(
    input clk_native, 
    input reset,
    input _go,
	input show_clock_count,
	input show_unconditional_branch_count,
	input show_conditional_branch_count,
	input show_loaduse_count,
	input show_mem,
	input key_up,
	input key_down,
	input[4:0] level,
	output [7:0] AN,
    output [7:0] seg
    );
	
	wire CLK;
	var_f_divider var_f_divider(
	   .clk_native(clk_native),
	   .level(level),
	   .clk_out(CLK)
	);

	wire RST;
	anti_shake as_reset(clk_native, reset, RST);
	
	wire Go;
	anti_shake as_go(CLK, _go, Go);
	
    wire EN;
	wire PC_EN, EX_JMP, Branch, EX_JR;
	wire [31:0] PC, BranchAddr, JmpAddr, EX_R1, PC_in;
	assign PC_in = EX_JMP ? (EX_JR ? EX_R1 : JmpAddr) : (Branch ? BranchAddr : PC + 4);
	reg32 PC_reg(PC_in, PC_EN, CLK, RST, PC);

	wire [31:0] IF_IR;
	rom imem(
		.address(PC), 
		.data_out(IF_IR)
	);

	wire IF_ID_Clr, IF_ID_EN;
	wire [31:0] ID_IR, ID_PC;
	if_id_interface IF_ID(IF_IR, PC + 4, CLK, IF_ID_Clr, IF_ID_EN, RST, ID_IR, ID_PC);

	wire R1_Used, R2_Used;
	regsrc_used regsrc_used(ID_IR[31:26], ID_IR[5:0], R1_Used, R2_Used);

	wire ID_MemToReg, ID_MemWrite, ID_AluSrc, ID_RegWrite, ID_Syscall, ID_SignedExt, ID_RegDst, ID_Beq, ID_Bne, ID_JR, ID_JMP, ID_JAL, ID_Blez, ID_SB;
	wire [3:0] ID_AluOp;
	ctr mainctr(
		.inst(ID_IR),
		.memToReg(ID_MemToReg),
		.memWrite(ID_MemWrite),
		.aluSrc(ID_AluSrc),
		.regWrite(ID_RegWrite),
		.syscall(ID_Syscall),
		.signedExt(ID_SignedExt),
		.regDst(ID_RegDst),
		.beq(ID_Beq),
		.bne(ID_Bne),
		.jr(ID_JR),
		.jmp(ID_JMP),
		.jal(ID_JAL),
		.aluOp(ID_AluOp),
		.blez(ID_Blez),
		.sb(ID_SB)
	);

	wire [31:0] ID_Imm;
	signext signext(ID_IR[15:0], ID_Imm);

	wire [4:0] R1_Addr, R2_Addr, W_Addr;
	wire WB_RegDst, WB_JAL, WB_RegWrite;
	wire [31:0] WB_IR, WB_PC, Mem_ReadData, ID_R1, ID_R2;
	assign R1_Addr = ID_Syscall ? 2 : ID_IR[25:21];
	assign R2_Addr = ID_Syscall ? 4 : ID_IR[20:16];
	assign W_Addr = WB_JAL ? 31 : (WB_RegDst ? WB_IR[15:11] : WB_IR[20:16]);
	regFile regfile(
		.RsAddr(R1_Addr),
		.RtAddr(R2_Addr),
		.clk(CLK), 
		.reset(RST), 
		.regWriteAddr(W_Addr), 
		.regWriteData(WB_JAL ? WB_PC : Mem_ReadData), 
		.regWriteEn(WB_RegWrite),
		.RsData(ID_R1),
		.RtData(ID_R2)
	);

	wire HaltOrRST, ID_EX_Clr, ID_EX_EN;
	wire EX_MemToReg, EX_MemWrite, EX_AluSrc, EX_RegWrite, EX_Syscall, EX_SignedExt, EX_RegDst, EX_Beq, EX_Bne, EX_JAL, EX_Blez, EX_SB;
	wire [3:0] EX_AluOp;
	wire [31:0] EX_IR, EX_PC, EX_R2, EX_Imm;
	id_ex_interface ID_EX(
		.RegWrite(ID_RegWrite),
		.RegDst(ID_RegDst),
		.JAL(ID_JAL),
		.SB(ID_SB),
		.MemToReg(ID_MemToReg),
		.MemWrite(ID_MemWrite),
		.AluOp(ID_AluOp),
		.AluSrcB(ID_AluSrc),
		.SignedExt(ID_SignedExt),
		.Syscall(ID_Syscall),
		.JMP(ID_JMP),
		.JR(ID_JR),
		.Beq(ID_Beq),
		.Bne(ID_Bne),
		.Blez(ID_Blez),
		.IR(ID_IR),
		.PC(ID_PC),
		.A(ID_R1),
		.B(ID_R2),
		.Imm(ID_Imm),
		.CLK(CLK),
		.CLR(ID_EX_Clr),
		.EN(ID_EX_EN),
		.RST(HaltOrRST),
		.RegWrite_out(EX_RegWrite),
		.RegDst_out(EX_RegDst),
		.JAL_out(EX_JAL),
		.SB_out(EX_SB),
		.MemToReg_out(EX_MemToReg),
		.MemWrite_out(EX_MemWrite),
		.AluOp_out(EX_AluOp),
		.AluSrcB_out(EX_AluSrc),
		.SignedExt_out(EX_SignedExt),
		.Syscall_out(EX_Syscall),
		.JMP_out(EX_JMP),
		.JR_out(EX_JR),
		.Beq_out(EX_Beq),
		.Bne_out(EX_Bne),
		.Blez_out(EX_Blez),
		.IR_out(EX_IR),
		.PC_out(EX_PC),
		.A_out(EX_R1),
		.B_out(EX_R2),
		.Imm_out(EX_Imm)
	);

	wire [4:0] EX_WriteRegAddr;
	assign EX_WriteRegAddr = EX_JAL ? 31 : (EX_RegDst ? EX_IR[15:11] : EX_IR[20:16]);

	assign BranchAddr = (EX_Imm << 2) + EX_PC;

	wire [1:0] R1_Forward;
	wire [31:0] EX_Alu, Mem_Alu, AluA;
	assign AluA = R1_Forward == 3 ? EX_Alu : 
					R1_Forward == 2 ? Mem_Alu :
					R1_Forward == 1 ? Mem_ReadData :
					EX_R1;
	wire [1:0] R2_Forward;
	wire [31:0] AluB;
	assign AluB = R2_Forward == 3 ? EX_Alu : 
					R2_Forward == 2 ? Mem_Alu :
					R2_Forward == 1 ? Mem_ReadData :
					(EX_AluSrc ? (EX_SignedExt ? EX_Imm : (32'h0000ffff & EX_Imm)) : EX_R2);
	wire [1:0] StoreForward;
	wire [31:0] EX_B;
	assign EX_B = StoreForward == 3 ? EX_Alu :
					StoreForward == 2 ? Mem_Alu :
					StoreForward == 1 ? Mem_ReadData :
					EX_R2;

	wire Equal, Lez;
	wire [31:0] AluRes;
	alu alu(
		.x(AluA),
		.y(AluB),
		.aluOp(EX_AluOp),
		.shamt(EX_IR[10:6]),
		.result(AluRes),
		.equal(Equal),
		.bleZero(Lez)
	);

	assign JmpAddr = {EX_PC[31:28], EX_IR[26:0], 2'b00};

	wire Halt, Disp;
	assign Halt = (AluA != 34) & EX_Syscall;
	assign Disp = (AluA == 34) & EX_Syscall;

	wire MEM_Halt, MEM_RegWrite, MEM_RegDst, MEM_JAL, MEM_SB, MEM_MemToReg, MEM_MemWrite;
	wire [31:0] MEM_IR, MEM_PC, MEM_B;
	ex_mem_interface EX_MEM(
		.Halt(Halt),
		.RegWrite(EX_RegWrite),
		.RegDst(EX_RegDst),
		.JAL(EX_JAL),
		.SB(EX_SB),
		.MemToReg(EX_MemToReg),
		.MemWrite(EX_MemWrite),
		.IR(EX_IR),
		.PC(EX_PC),
		.Alu(AluRes),
		.B(EX_B),
		.CLK(CLK),
		.CLR(1'b0),
		.EN(EN),
		.RST(HaltOrRST),
		.Halt_out(MEM_Halt),
		.RegWrite_out(MEM_RegWrite),
		.RegDst_out(MEM_RegDst),
		.JAL_out(MEM_JAL),
		.SB_out(MEM_SB),
		.MemToReg_out(MEM_MemToReg),
		.MemWrite_out(MEM_MemWrite),
		.IR_out(MEM_IR),
		.PC_out(MEM_PC),
		.Alu_out(EX_Alu),
		.B_out(MEM_B)
	);

	wire [4:0] Mem_WriteRegAddr;
	assign Mem_WriteRegAddr = MEM_JAL ? 31 : (MEM_RegDst ? MEM_IR[15:11] : MEM_IR[20:16]);

	wire [31:0] memOut;
    wire[31:0] address_display;
    wire[31:0] data_out_display;
	ram dmem(
		.address(EX_Alu),
		.__address_display(address_display),
		.data_in(MEM_B),
		.clk(CLK),
		.WE(MEM_MemWrite),
		.reset(RST),
		.mode({1'b0, MEM_SB}),
		.data_out(memOut),
		.__data_out_display(data_out_display)
	);

	wire WB_Halt;
	mem_wb_interface MEM_WB(
		.Halt(MEM_Halt),
		.RegWrite(MEM_RegWrite),
		.RegDst(MEM_RegDst),
		.JAL(MEM_JAL),
		.IR(MEM_IR),
		.PC(MEM_PC),
		.Alu(EX_Alu),
		.MD(MEM_MemToReg ? memOut : EX_Alu),
		.CLK(CLK),
		.CLR(1'b0),
		.EN(EN),
		.RST(RST),
		.Halt_out(WB_Halt),
		.RegWrite_out(WB_RegWrite),
		.RegDst_out(WB_RegDst),
		.JAL_out(WB_JAL),
		.IR_out(WB_IR),
		.PC_out(WB_PC),
		.Alu_out(Mem_Alu),
		.MD_out(Mem_ReadData)
	);

	assign EN = ~(~Go & WB_Halt);
	assign HaltOrRST = ~EN | RST;

	wire BubbleClr, LoadUse;
	assign BubbleClr = EX_JMP | Branch;
	assign IF_ID_Clr = BubbleClr;
	assign ID_EX_Clr = BubbleClr | LoadUse;
	assign Branch = (Equal & EX_Beq) | (~Equal & EX_Bne) | (Lez & EX_Blez);
	assign PC_EN = (EN & ~LoadUse & ~Halt) | (Halt & Go);
	assign IF_ID_EN = PC_EN;
	assign ID_EX_EN = ~Halt;

	data_rela data_rela(
		.R1(R1_Addr),
		.R1_Used(R1_Used),
		.R2(R2_Addr),
		.R2_Used(R2_Used),
		.Ex_WriteReg(EX_WriteRegAddr),
		.Ex_RegWrite(EX_RegWrite),
		.Ex_MemToReg(EX_MemToReg),
		.Mem_WriteReg(Mem_WriteRegAddr),
		.Mem_RegWrite(MEM_RegWrite),
		.Mem_MemToReg(MEM_MemToReg),
		.MemWrite(ID_MemWrite),
		.EN(ID_EX_EN),
		.CLK(CLK),
		.RST(HaltOrRST),
		.LoadUse(LoadUse),
		.R1_Forward(R1_Forward),
		.R2_Forward(R2_Forward),
		.StoreForward(StoreForward)
	);

	wire [31:0] LedData;	
	wire [7:0] sys_AN, sys_seg;
	reg32 LedData_reg(AluB, Disp, CLK, RST, LedData);
	Display show_syscall_display(
		.reset(RST),
		.clk(clk_native),
		.data(LedData),
		.seg(sys_seg),
		.AN(sys_AN)
	);

	wire [31:0] clock_count;
	wire [7:0] clock_seg, clock_AN;
	counter clock_counter(EN, CLK, RST, clock_count);
	Display show_clock_count_display(
		.reset(RST),
		.clk(clk_native),
		.data(clock_count),
		.seg(clock_seg),
		.AN(clock_AN)
	);

	wire [31:0] jmp_count;
	wire [7:0] jmp_seg, jmp_AN;
	counter jmp_counter(EX_JMP & PC_EN, CLK, RST, jmp_count);
	Display show_jmp_count_display(
		.reset(RST),
		.clk(clk_native),
		.data(jmp_count),
		.seg(jmp_seg),
		.AN(jmp_AN)
	);

	wire [31:0] branch_count;
	wire [7:0] branch_seg, branch_AN;
	counter branch_counter(Branch & PC_EN, CLK, RST, branch_count);
	Display show_branch_count_display(
		.reset(RST),
		.clk(clk_native),
		.data(branch_count),
		.seg(branch_seg),
		.AN(branch_AN)
	);

	wire [31:0] loaduse_count;
	wire [7:0] loaduse_seg, loaduse_AN;
	counter loaduse_counter(LoadUse & EN, CLK, RST, loaduse_count);
	Display show_loaduse_count_display(
		.reset(RST),
		.clk(clk_native),
		.data(loaduse_count),
		.seg(loaduse_seg),
		.AN(loaduse_AN)
	);

	wire [7:0] mem_seg, mem_AN;

	up_down_ctr up_down_ctr(
		.clk_native(clk_native),
		.key_up(key_up),
		.key_down(key_down),
		.address(address_display)
	);

	Display show_mem_display(
		.reset(RST),
		.clk(clk_native),
		.data(data_out_display),
		.seg(mem_seg),
		.AN(mem_AN)
	);

	assign seg = show_mem ? mem_seg : 
					show_loaduse_count ? loaduse_seg :
					show_conditional_branch_count ? branch_seg : 
					show_unconditional_branch_count ? jmp_seg :
					show_clock_count ? clock_seg :
					sys_seg;
	assign AN = show_mem ? mem_AN : 
					show_loaduse_count ? loaduse_AN :
					show_conditional_branch_count ? branch_AN : 
					show_unconditional_branch_count ? jmp_AN :
					show_clock_count ? clock_AN :
					sys_AN;

endmodule
