`timescale 1ns / 1ps

module prio_encoder(
    input [3:0] Din,
    output [1:0] Dout
    );
    assign Dout = Din[3] ? 3 :
                  (~Din[3] & Din[2]) ? 2 :
                  (~Din[3] & ~Din[2] & Din[1]) ? 1 : 0;
endmodule