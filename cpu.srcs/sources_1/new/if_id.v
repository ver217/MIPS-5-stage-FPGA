`timescale 1ns / 1ps

module if_id_interface(
    input [31:0] IR,
    input [31:0] PC,
    input CLK,
    input CLR,
    input EN,
    input RST,
    output [31:0] IR_out,
    output [31:0] PC_out
    );
    wire [31:0] PC_in, IR_in;
    assign PC_in = CLR ? 0 : PC;
    assign IR_in = CLR ? 0 : IR;
    reg32 PC_reg(PC_in, EN, CLK, RST, PC_out);
    reg32 IR_reg(IR_in, EN, CLK, RST, IR_out);
endmodule
