`timescale 1ns / 1ps

module id_ex_interface(
    input RegWrite,
    input RegDst,
    input JAL,
    input SB,
    input MemToReg,
    input MemWrite,
    input [3:0] AluOp,
    input AluSrcB,
    input SignedExt,
    input Syscall,
    input JMP,
    input JR,
    input Beq,
    input Bne,
    input Blez,
    input [31:0] IR,
    input [31:0] PC,
    input [31:0] A,
    input [31:0] B,
    input [31:0] Imm,
    input CLK,
    input CLR,
    input EN,
    input RST,
    output RegWrite_out,
    output RegDst_out,
    output JAL_out,
    output SB_out,
    output MemToReg_out,
    output MemWrite_out,
    output [3:0] AluOp_out,
    output AluSrcB_out,
    output SignedExt_out,
    output Syscall_out,
    output JMP_out,
    output JR_out,
    output Beq_out,
    output Bne_out,
    output Blez_out,
    output [31:0] IR_out,
    output [31:0] PC_out,
    output [31:0] A_out,
    output [31:0] B_out,
    output [31:0] Imm_out
    );
    wire [2:0] WB_in, Mem_in, WB_out, Mem_out;
    wire [11:0] Ex_in, Ex_out;
    wire [31:0] IR_in, PC_in, A_in, B_in, Imm_in;
    assign WB_in = CLR ? 0 : {RegWrite, RegDst, JAL};
    assign Mem_in = CLR ? 0 : {SB, MemToReg, MemWrite};
    assign Ex_in = CLR ? 0 : {AluOp, AluSrcB, SignedExt, Syscall, JMP, JR, Beq, Bne, Blez};
    assign IR_in = CLR ? 0 : IR;
    assign PC_in = CLR ? 0 : PC;
    assign A_in = CLR ? 0 : A;
    assign B_in = CLR ? 0 : B;
    assign Imm_in = CLR ? 0 : Imm;
    reg32 #(3) WB_reg(WB_in, EN, CLK, RST, WB_out);
    reg32 #(3) Mem_reg(Mem_in, EN, CLK, RST, Mem_out);
    reg32 #(12) Ex_reg(Ex_in, EN, CLK, RST, Ex_out);
    reg32 PC_reg(PC_in, EN, CLK, RST, PC_out);
    reg32 IR_reg(IR_in, EN, CLK, RST, IR_out);
    reg32 A_reg(A_in, EN, CLK, RST, A_out);
    reg32 B_reg(B_in, EN, CLK, RST, B_out);
    reg32 Imm_reg(Imm_in, EN, CLK, RST, Imm_out);
    assign RegWrite_out = WB_out[2];
    assign RegDst_out = WB_out[1];
    assign JAL_out = WB_out[0];
    assign SB_out = Mem_out[2];
    assign MemToReg_out = Mem_out[1];
    assign MemWrite_out = Mem_out[0];
    assign AluOp_out = Ex_out[11:8];
    assign AluSrcB_out = Ex_out[7];
    assign SignedExt_out = Ex_out[6];
    assign Syscall_out = Ex_out[5];
    assign JMP_out = Ex_out[4];
    assign JR_out = Ex_out[3];
    assign Beq_out = Ex_out[2];
    assign Bne_out = Ex_out[1];
    assign Blez_out = Ex_out[0];
endmodule
