`timescale 1ns / 1ps

module mem_wb_interface(
    input Halt,
    input RegWrite,
    input RegDst,
    input JAL,
    input [31:0] IR,
    input [31:0] PC,
    input [31:0] Alu,
    input [31:0] MD,
    input CLK,
    input CLR,
    input EN,
    input RST,
    output Halt_out,
    output RegWrite_out,
    output RegDst_out,
    output JAL_out,
    output [31:0] IR_out,
    output [31:0] PC_out,
    output [31:0] Alu_out,
    output [31:0] MD_out
    );
    wire Halt_in;
    wire [2:0] WB_in, WB_out;
    wire [31:0] IR_in, PC_in, Alu_in, MD_in;
    assign Halt_in = CLR ? 0 : Halt;
    assign WB_in = CLR ? 0 : {RegWrite, RegDst, JAL};
    assign IR_in = CLR ? 0 : IR;
    assign PC_in = CLR ? 0 : PC;
    assign Alu_in = CLR ? 0 : Alu;
    assign MD_in = CLR ? 0 : MD;
    reg1 Halt_reg(Halt_in, EN, CLK, RST, Halt_out);
    reg3 WB_reg(WB_in, EN, CLK, RST, WB_out);
    reg32 PC_reg(PC_in, EN, CLK, RST, PC_out);
    reg32 IR_reg(IR_in, EN, CLK, RST, IR_out);
    reg32 Alu_reg(Alu_in, EN, CLK, RST, Alu_out);
    reg32 MD_reg(MD_in, EN, CLK, RST, MD_out);
    assign RegWrite_out = WB_out[2];
    assign RegDst_out = WB_out[1];
    assign JAL_out = WB_out[0];

endmodule
