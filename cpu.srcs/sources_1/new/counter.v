`timescale 1ns / 1ps

module counter(
    input EN,
    input clk,
    input reset,
    output reg [31:0] count
    );

    initial count <= 0;
    
    always@(posedge clk or posedge reset) begin
        if(reset)
            count <= 0;
        else if(EN) begin
            if (count == 32'hffffffff)
                count <= 0;
            else 
                count <= count + 1;
        end
    end
endmodule
