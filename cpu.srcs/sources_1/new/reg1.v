`timescale 1ns / 1ps

module reg1(
    input Din,
    input EN,
    input CLK,
    input RST,
    output reg Dout
    );
    initial Dout <= 0;
    always @(posedge CLK or posedge RST) begin
        if (RST) Dout <= 0;
        else if (EN) Dout <= Din;
    end
endmodule
