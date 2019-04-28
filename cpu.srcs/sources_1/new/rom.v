`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/18 16:34:07
// Design Name: 
// Module Name: rom
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module rom(
    input [31:0] address,
    output [31:0] data_out
    );
    
    parameter HEX_LINE_MAX = 4096;
    reg[31:0] mem[0:HEX_LINE_MAX - 1];

    // TODO: consider migration of $intructions
    
    // benchmark_ccmb.hex
    initial begin
        mem[0] = 32'h20110001;
mem[1] = 32'h08000c05;
mem[2] = 32'h20110001;
mem[3] = 32'h20120002;
mem[4] = 32'h20130003;
mem[5] = 32'h08000c09;
mem[6] = 32'h20110001;
mem[7] = 32'h20120002;
mem[8] = 32'h20130003;
mem[9] = 32'h08000c0d;
mem[10] = 32'h20110001;
mem[11] = 32'h20120002;
mem[12] = 32'h20130003;
mem[13] = 32'h08000c11;
mem[14] = 32'h20110001;
mem[15] = 32'h20120002;
mem[16] = 32'h20130003;
mem[17] = 32'h0c000cfc;
mem[18] = 32'h20100001;
mem[19] = 32'h20110001;
mem[20] = 32'h00118fc0;
mem[21] = 32'h00112020;
mem[22] = 32'h20020022;
mem[23] = 32'h0000000c;
mem[24] = 32'h00118882;
mem[25] = 32'h12200001;
mem[26] = 32'h08000c15;
mem[27] = 32'h00112020;
mem[28] = 32'h20020022;
mem[29] = 32'h0000000c;
mem[30] = 32'h20110001;
mem[31] = 32'h00118880;
mem[32] = 32'h00112020;
mem[33] = 32'h20020022;
mem[34] = 32'h0000000c;
mem[35] = 32'h12200001;
mem[36] = 32'h08000c1f;
mem[37] = 32'h20110001;
mem[38] = 32'h00118fc0;
mem[39] = 32'h00112020;
mem[40] = 32'h20020022;
mem[41] = 32'h0000000c;
mem[42] = 32'h001188c3;
mem[43] = 32'h00112020;
mem[44] = 32'h20020022;
mem[45] = 32'h0000000c;
mem[46] = 32'h00118903;
mem[47] = 32'h00112020;
mem[48] = 32'h20020022;
mem[49] = 32'h0000000c;
mem[50] = 32'h00118903;
mem[51] = 32'h00112020;
mem[52] = 32'h20020022;
mem[53] = 32'h0000000c;
mem[54] = 32'h00118903;
mem[55] = 32'h00112020;
mem[56] = 32'h20020022;
mem[57] = 32'h0000000c;
mem[58] = 32'h00118903;
mem[59] = 32'h00112020;
mem[60] = 32'h20020022;
mem[61] = 32'h0000000c;
mem[62] = 32'h00118903;
mem[63] = 32'h00112020;
mem[64] = 32'h20020022;
mem[65] = 32'h0000000c;
mem[66] = 32'h00118903;
mem[67] = 32'h00112020;
mem[68] = 32'h20020022;
mem[69] = 32'h0000000c;
mem[70] = 32'h00118903;
mem[71] = 32'h00112020;
mem[72] = 32'h20020022;
mem[73] = 32'h0000000c;
mem[74] = 32'h20100001;
mem[75] = 32'h00109fc0;
mem[76] = 32'h00139fc3;
mem[77] = 32'h00008021;
mem[78] = 32'h2012000c;
mem[79] = 32'h24160003;
mem[80] = 32'h26100001;
mem[81] = 32'h3210000f;
mem[82] = 32'h20080008;
mem[83] = 32'h20090001;
mem[84] = 32'h00139900;
mem[85] = 32'h02709825;
mem[86] = 32'h00132020;
mem[87] = 32'h20020022;
mem[88] = 32'h0000000c;
mem[89] = 32'h01094022;
mem[90] = 32'h1500fff9;
mem[91] = 32'h22100001;
mem[92] = 32'h2018000f;
mem[93] = 32'h02188024;
mem[94] = 32'h00108700;
mem[95] = 32'h20080008;
mem[96] = 32'h20090001;
mem[97] = 32'h00139902;
mem[98] = 32'h02709825;
mem[99] = 32'h00132021;
mem[100] = 32'h20020022;
mem[101] = 32'h0000000c;
mem[102] = 32'h01094022;
mem[103] = 32'h1500fff9;
mem[104] = 32'h00108702;
mem[105] = 32'h02c9b022;
mem[106] = 32'h12c00001;
mem[107] = 32'h08000c50;
mem[108] = 32'h00004020;
mem[109] = 32'h01084027;
mem[110] = 32'h00084400;
mem[111] = 32'h3508ffff;
mem[112] = 32'h00082021;
mem[113] = 32'h20020022;
mem[114] = 32'h0000000c;
mem[115] = 32'h2010ffff;
mem[116] = 32'h20110000;
mem[117] = 32'hae300000;
mem[118] = 32'h22100001;
mem[119] = 32'h22310004;
mem[120] = 32'hae300000;
mem[121] = 32'h22100001;
mem[122] = 32'h22310004;
mem[123] = 32'hae300000;
mem[124] = 32'h22100001;
mem[125] = 32'h22310004;
mem[126] = 32'hae300000;
mem[127] = 32'h22100001;
mem[128] = 32'h22310004;
mem[129] = 32'hae300000;
mem[130] = 32'h22100001;
mem[131] = 32'h22310004;
mem[132] = 32'hae300000;
mem[133] = 32'h22100001;
mem[134] = 32'h22310004;
mem[135] = 32'hae300000;
mem[136] = 32'h22100001;
mem[137] = 32'h22310004;
mem[138] = 32'hae300000;
mem[139] = 32'h22100001;
mem[140] = 32'h22310004;
mem[141] = 32'hae300000;
mem[142] = 32'h22100001;
mem[143] = 32'h22310004;
mem[144] = 32'hae300000;
mem[145] = 32'h22100001;
mem[146] = 32'h22310004;
mem[147] = 32'hae300000;
mem[148] = 32'h22100001;
mem[149] = 32'h22310004;
mem[150] = 32'hae300000;
mem[151] = 32'h22100001;
mem[152] = 32'h22310004;
mem[153] = 32'hae300000;
mem[154] = 32'h22100001;
mem[155] = 32'h22310004;
mem[156] = 32'hae300000;
mem[157] = 32'h22100001;
mem[158] = 32'h22310004;
mem[159] = 32'hae300000;
mem[160] = 32'h22100001;
mem[161] = 32'h22310004;
mem[162] = 32'hae300000;
mem[163] = 32'h22100001;
mem[164] = 32'h22310004;
mem[165] = 32'h22100001;
mem[166] = 32'h00008020;
mem[167] = 32'h2011003c;
mem[168] = 32'h8e130000;
mem[169] = 32'h8e340000;
mem[170] = 32'h0274402a;
mem[171] = 32'h11000002;
mem[172] = 32'hae330000;
mem[173] = 32'hae140000;
mem[174] = 32'h2231fffc;
mem[175] = 32'h1611fff8;
mem[176] = 32'h00102020;
mem[177] = 32'h20020022;
mem[178] = 32'h0000000c;
mem[179] = 32'h22100004;
mem[180] = 32'h2011003c;
mem[181] = 32'h1611fff2;
mem[182] = 32'h20020032;
mem[183] = 32'h0000000c;
mem[184] = 32'h00000000;
mem[185] = 32'h20080001;
mem[186] = 32'h20090003;
mem[187] = 32'h20110876;
mem[188] = 32'h00112020;
mem[189] = 32'h20020022;
mem[190] = 32'h0000000c;
mem[191] = 32'h200b0008;
mem[192] = 32'h01118804;
mem[193] = 32'h01318804;
mem[194] = 32'h00112020;
mem[195] = 32'h20020022;
mem[196] = 32'h0000000c;
mem[197] = 32'h216bffff;
mem[198] = 32'h1560fff9;
mem[199] = 32'h2002000a;
mem[200] = 32'h0000000c;
mem[201] = 32'h00000000;
mem[202] = 32'h2008ffff;
mem[203] = 32'h20117777;
mem[204] = 32'h00112020;
mem[205] = 32'h20020022;
mem[206] = 32'h0000000c;
mem[207] = 32'h200b0010;
mem[208] = 32'h02288826;
mem[209] = 32'h00112020;
mem[210] = 32'h20020022;
mem[211] = 32'h0000000c;
mem[212] = 32'h216bffff;
mem[213] = 32'h1560fffa;
mem[214] = 32'h2002000a;
mem[215] = 32'h0000000c;
mem[216] = 32'h00000000;
mem[217] = 32'h20090000;
mem[218] = 32'h200b0010;
mem[219] = 32'h34118483;
mem[220] = 32'h20120404;
mem[221] = 32'h00118c00;
mem[222] = 32'h00129400;
mem[223] = 32'h36318281;
mem[224] = 32'h22520404;
mem[225] = 32'had310000;
mem[226] = 32'h02328820;
mem[227] = 32'h21290004;
mem[228] = 32'h216bffff;
mem[229] = 32'h1560fffb;
mem[230] = 32'h200b0020;
mem[231] = 32'h20090000;
mem[232] = 32'h85310000;
mem[233] = 32'h00112020;
mem[234] = 32'h20020022;
mem[235] = 32'h0000000c;
mem[236] = 32'h21290002;
mem[237] = 32'h216bffff;
mem[238] = 32'h1560fff9;
mem[239] = 32'h2002000a;
mem[240] = 32'h0000000c;
mem[241] = 32'h00000000;
mem[242] = 32'h2011000f;
mem[243] = 32'h00112020;
mem[244] = 32'h20020022;
mem[245] = 32'h0000000c;
mem[246] = 32'h2231ffff;
mem[247] = 32'h1e20fffb;
mem[248] = 32'h2002000a;
mem[249] = 32'h0000000c;
mem[250] = 32'h2002000a;
mem[251] = 32'h0000000c;
mem[252] = 32'h20100000;
mem[253] = 32'h22100001;
mem[254] = 32'h00102020;
mem[255] = 32'h20020022;
mem[256] = 32'h0000000c;
mem[257] = 32'h22100002;
mem[258] = 32'h00102020;
mem[259] = 32'h20020022;
mem[260] = 32'h0000000c;
mem[261] = 32'h22100003;
mem[262] = 32'h00102020;
mem[263] = 32'h20020022;
mem[264] = 32'h0000000c;
mem[265] = 32'h22100004;
mem[266] = 32'h00102020;
mem[267] = 32'h20020022;
mem[268] = 32'h0000000c;
mem[269] = 32'h22100005;
mem[270] = 32'h00102020;
mem[271] = 32'h20020022;
mem[272] = 32'h0000000c;
mem[273] = 32'h22100006;
mem[274] = 32'h00102020;
mem[275] = 32'h20020022;
mem[276] = 32'h0000000c;
mem[277] = 32'h22100007;
mem[278] = 32'h00102020;
mem[279] = 32'h20020022;
mem[280] = 32'h0000000c;
mem[281] = 32'h22100008;
mem[282] = 32'h00102020;
mem[283] = 32'h20020022;
mem[284] = 32'h20020022;
mem[285] = 32'h0000000c;
mem[286] = 32'h03e00008;
    end

    assign data_out = mem[address[11:2]];
endmodule
