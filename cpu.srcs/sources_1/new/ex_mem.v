`timescale 1ns / 1ps

module ex_mem_interface(
    input Halt,
    input RegWrite,
    input RegDst,
    input JAL,
    input SB,
    input MemToReg,
    input MemWrite,
    input [31:0] IR,
    input [31:0] PC,
    input [31:0] Alu,
    input [31:0] B,
    input CLK,
    input CLR,
    input EN,
    input RST,
    output Halt_out,
    output RegWrite_out,
    output RegDst_out,
    output JAL_out,
    output SB_out,
    output MemToReg_out,
    output MemWrite_out,
    output [31:0] IR_out,
    output [31:0] PC_out,
    output [31:0] Alu_out,
    output [31:0] B_out
    );
    wire Halt_in;
    wire [2:0] WB_in, Mem_in, WB_out, Mem_out;
    wire [31:0] IR_in, PC_in, Alu_in, B_in;
    assign Halt_in = CLR ? 0 : Halt;
    assign WB_in = CLR ? 0 : {RegWrite, RegDst, JAL};
    assign Mem_in = CLR ? 0 : {SB, MemToReg, MemWrite};
    assign IR_in = CLR ? 0 : IR;
    assign PC_in = CLR ? 0 : PC;
    assign Alu_in = CLR ? 0 : Alu;
    assign B_in = CLR ? 0 : B;
    reg1 Halt_reg(Halt_in, EN, CLK, RST, Halt_out);
    reg32 #(3) WB_reg(WB_in, EN, CLK, RST, WB_out);
    reg32 #(3) Mem_reg(Mem_in, EN, CLK, RST, Mem_out);
    reg32 PC_reg(PC_in, EN, CLK, RST, PC_out);
    reg32 IR_reg(IR_in, EN, CLK, RST, IR_out);
    reg32 Alu_reg(Alu_in, EN, CLK, RST, Alu_out);
    reg32 B_reg(B_in, EN, CLK, RST, B_out);
    assign RegWrite_out = WB_out[2];
    assign RegDst_out = WB_out[1];
    assign JAL_out = WB_out[0];
    assign SB_out = Mem_out[2];
    assign MemToReg_out = Mem_out[1];
    assign MemWrite_out = Mem_out[0];
endmodule
