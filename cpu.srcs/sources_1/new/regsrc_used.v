`timescale 1ns / 1ps
module regsrc_used(
    input [5:0] OP,
    input [5:0] Func,
    output R1_Used,
    output R2_Used
    );

    assign R1_Used = (~OP[5] & ~OP[4] & ~OP[3] & ~OP[2] & ~OP[1] & ~OP[0] & Func[5] & ~Func[4] & ~Func[3] & ~Func[2] & ~Func[1] & ~Func[0]) |
(~OP[5] & ~OP[4] & ~OP[3] & ~OP[2] & ~OP[1] & ~OP[0] & Func[5] & ~Func[4] & ~Func[3] & ~Func[2] & ~Func[1] & Func[0]) |
(~OP[5] & ~OP[4] & ~OP[3] & ~OP[2] & ~OP[1] & ~OP[0] & Func[5] & ~Func[4] & ~Func[3] & ~Func[2] & Func[1] & ~Func[0]) |
(~OP[5] & ~OP[4] & ~OP[3] & ~OP[2] & ~OP[1] & ~OP[0] & Func[5] & ~Func[4] & ~Func[3] & Func[2] & ~Func[1] & ~Func[0]) |
(~OP[5] & ~OP[4] & ~OP[3] & ~OP[2] & ~OP[1] & ~OP[0] & Func[5] & ~Func[4] & ~Func[3] & Func[2] & ~Func[1] & Func[0]) |
(~OP[5] & ~OP[4] & ~OP[3] & ~OP[2] & ~OP[1] & ~OP[0] & Func[5] & ~Func[4] & ~Func[3] & Func[2] & Func[1] & Func[0]) |
(~OP[5] & ~OP[4] & ~OP[3] & ~OP[2] & ~OP[1] & ~OP[0] & Func[5] & ~Func[4] & Func[3] & ~Func[2] & Func[1] & ~Func[0]) |
(~OP[5] & ~OP[4] & ~OP[3] & ~OP[2] & ~OP[1] & ~OP[0] & Func[5] & ~Func[4] & Func[3] & ~Func[2] & Func[1] & Func[0]) |
(~OP[5] & ~OP[4] & ~OP[3] & ~OP[2] & ~OP[1] & ~OP[0] & ~Func[5] & ~Func[4] & Func[3] & ~Func[2] & ~Func[1] & ~Func[0]) |
(~OP[5] & ~OP[4] & ~OP[3] & ~OP[2] & ~OP[1] & ~OP[0] & ~Func[5] & ~Func[4] & Func[3] & Func[2] & ~Func[1] & ~Func[0]) |
(~OP[5] & ~OP[4] & ~OP[3] & OP[2] & ~OP[1] & ~OP[0]) |
(~OP[5] & ~OP[4] & ~OP[3] & OP[2] & ~OP[1] & OP[0]) |
(~OP[5] & ~OP[4] & OP[3] & ~OP[2] & ~OP[1] & ~OP[0]) |
(~OP[5] & ~OP[4] & OP[3] & OP[2] & ~OP[1] & ~OP[0]) |
(~OP[5] & ~OP[4] & OP[3] & ~OP[2] & ~OP[1] & OP[0]) |
(~OP[5] & ~OP[4] & OP[3] & ~OP[2] & OP[1] & ~OP[0]) |
(~OP[5] & ~OP[4] & OP[3] & OP[2] & ~OP[1] & OP[0]) |
(OP[5] & ~OP[4] & ~OP[3] & ~OP[2] & OP[1] & OP[0]) |
(OP[5] & ~OP[4] & OP[3] & ~OP[2] & OP[1] & OP[0]) |
(~OP[5] & ~OP[4] & ~OP[3] & ~OP[2] & ~OP[1] & ~OP[0] & Func[5] & ~Func[4] & ~Func[3] & Func[2] & Func[1] & ~Func[0]) |
(~OP[5] & ~OP[4] & OP[3] & OP[2] & OP[1] & ~OP[0]) |
(OP[5] & ~OP[4] & OP[3] & ~OP[2] & ~OP[1] & ~OP[0]) |
(~OP[5] & ~OP[4] & ~OP[3] & OP[2] & OP[1] & ~OP[0]);

    assign R2_Used = (~OP[5] & ~OP[4] & ~OP[3] & ~OP[2] & ~OP[1] & ~OP[0] & ~Func[5] & ~Func[4] & ~Func[3] & ~Func[2] & ~Func[1] & ~Func[0]) |
(~OP[5] & ~OP[4] & ~OP[3] & ~OP[2] & ~OP[1] & ~OP[0] & ~Func[5] & ~Func[4] & ~Func[3] & ~Func[2] & Func[1] & Func[0]) |
(~OP[5] & ~OP[4] & ~OP[3] & ~OP[2] & ~OP[1] & ~OP[0] & ~Func[5] & ~Func[4] & ~Func[3] & ~Func[2] & Func[1] & ~Func[0]) |
(~OP[5] & ~OP[4] & ~OP[3] & ~OP[2] & ~OP[1] & ~OP[0] & Func[5] & ~Func[4] & ~Func[3] & ~Func[2] & ~Func[1] & ~Func[0]) |
(~OP[5] & ~OP[4] & ~OP[3] & ~OP[2] & ~OP[1] & ~OP[0] & Func[5] & ~Func[4] & ~Func[3] & ~Func[2] & ~Func[1] & Func[0]) |
(~OP[5] & ~OP[4] & ~OP[3] & ~OP[2] & ~OP[1] & ~OP[0] & Func[5] & ~Func[4] & ~Func[3] & ~Func[2] & Func[1] & ~Func[0]) |
(~OP[5] & ~OP[4] & ~OP[3] & ~OP[2] & ~OP[1] & ~OP[0] & Func[5] & ~Func[4] & ~Func[3] & Func[2] & ~Func[1] & ~Func[0]) |
(~OP[5] & ~OP[4] & ~OP[3] & ~OP[2] & ~OP[1] & ~OP[0] & Func[5] & ~Func[4] & ~Func[3] & Func[2] & ~Func[1] & Func[0]) |
(~OP[5] & ~OP[4] & ~OP[3] & ~OP[2] & ~OP[1] & ~OP[0] & Func[5] & ~Func[4] & ~Func[3] & Func[2] & Func[1] & Func[0]) |
(~OP[5] & ~OP[4] & ~OP[3] & ~OP[2] & ~OP[1] & ~OP[0] & Func[5] & ~Func[4] & Func[3] & ~Func[2] & Func[1] & ~Func[0]) |
(~OP[5] & ~OP[4] & ~OP[3] & ~OP[2] & ~OP[1] & ~OP[0] & Func[5] & ~Func[4] & Func[3] & ~Func[2] & Func[1] & Func[0]) |
(~OP[5] & ~OP[4] & ~OP[3] & ~OP[2] & ~OP[1] & ~OP[0] & ~Func[5] & ~Func[4] & Func[3] & Func[2] & ~Func[1] & ~Func[0]) |
(~OP[5] & ~OP[4] & ~OP[3] & OP[2] & ~OP[1] & ~OP[0]) |
(~OP[5] & ~OP[4] & ~OP[3] & OP[2] & ~OP[1] & OP[0]) |
(~OP[5] & ~OP[4] & ~OP[3] & ~OP[2] & ~OP[1] & ~OP[0] & Func[5] & ~Func[4] & ~Func[3] & Func[2] & Func[1] & ~Func[0]);
endmodule