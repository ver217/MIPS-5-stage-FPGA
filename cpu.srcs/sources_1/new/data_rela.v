`timescale 1ns / 1ps

module data_rela(
    input [4:0] R1,
    input R1_Used,
    input [4:0] R2,
    input R2_Used,
    input [4:0] Ex_WriteReg,
    input Ex_RegWrite,
    input Ex_MemToReg,
    input [4:0] Mem_WriteReg,
    input Mem_RegWrite,
    input Mem_MemToReg,
    input MemWrite,
    input EN,
    input CLK,
    input RST,
    output LoadUse,
    output [1:0] R1_Forward,
    output [1:0] R2_Forward,
    output [1:0] StoreForward
    );
    wire r1_ex_rela, r1_mem_rela, r2_ex_rela, r2_mem_rela, s_ex_rela, s_mem_rela;
    wire [1:0] r1_encoded, r2_encoded, s_encoded;

    assign r1_ex_rela = R1_Used & (R1 != 0) & (R1 == Ex_WriteReg) & Ex_RegWrite;
    assign r1_mem_rela = R1_Used & (R1 != 0) & (R1 == Mem_WriteReg) & Mem_RegWrite;
    assign r2_ex_rela = R2_Used & (R2 != 0) & (R2 == Ex_WriteReg) & Ex_RegWrite;
    assign r2_mem_rela = R2_Used & (R2 != 0) & (R2 == Mem_WriteReg) & Mem_RegWrite;
    assign s_ex_rela = MemWrite & (R2 != 0) & (R2 == Ex_WriteReg) & Ex_RegWrite;
    assign s_mem_rela = MemWrite & (R2 != 0) & (R2 == Mem_WriteReg) & Mem_RegWrite;
    assign LoadUse = (r1_ex_rela | r2_ex_rela | s_ex_rela) & Ex_MemToReg;

    prio_encoder r1_encoder({r1_ex_rela, ~Mem_MemToReg & r1_mem_rela, Mem_MemToReg & r1_mem_rela, 1'b1}, r1_encoded);
    prio_encoder r2_encoder({r2_ex_rela, ~Mem_MemToReg & r2_mem_rela, Mem_MemToReg & r2_mem_rela, 1'b1}, r2_encoded);
    prio_encoder s_encoder({s_ex_rela, ~Mem_MemToReg & s_mem_rela, Mem_MemToReg & s_mem_rela, 1'b1}, s_encoded);

    reg32 #(2) r1_reg(r1_encoded, EN, CLK, RST, R1_Forward);
    reg32 #(2) r2_reg(r2_encoded, EN, CLK, RST, R2_Forward);
    reg32 #(2) s_reg(s_encoded, EN, CLK, RST, StoreForward);

endmodule