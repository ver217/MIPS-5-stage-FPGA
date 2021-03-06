`timescale 1ns / 1ps


module information(

    );
 
     reg clk;
     reg clk_N;
     reg reset;

  
     reg clock_counter_en;    
     reg unconditional_branch_counter_en;
     reg conditional_branch_counter_en;



     reg [2:0]select;  
     reg clk_T;
     reg [7:0]temp_counter;
     
   reg [7:0]display;
   reg [7:0]AN;

reg [3:0] decimalism_number[7:0];//十进制显示
wire [2:0]devide;
reg [31:0] number;  


wire [31:0]cycle_number;
wire [31:0]unconditional_branch_number;
wire [31:0]conditional_branch_number;
reg cout;

initial begin 

reset=0;
clock_counter_en=1;    
unconditional_branch_counter_en=0;
conditional_branch_counter_en=0;
select=0;
clk=0;
clk_N=0;
 clk_T=0;
temp_counter=0;
#1000 clock_counter_en=0;
#1100 clock_counter_en=1;
#1200 reset=1;
#1300 reset=0;
#1500 unconditional_branch_counter_en=1;
#1600 unconditional_branch_counter_en=0;
#1700 conditional_branch_counter_en=1;
#1800 conditional_branch_counter_en=0;
end

always #1 clk=~clk;
always #20 clk_N=~clk_N;
always #1000 select=select+1;


      






      







always @(posedge clk)begin
if(temp_counter==255)begin clk_T=~clk_T;temp_counter=0;end
else temp_counter=temp_counter+1;
end




always @(posedge clk_T)begin
  cout=0;
if((number&32'h0000000f)>9)
      begin
      decimalism_number[0]=(number&32'h0000000f)-10;
      cout=1;
      end
      else begin
      decimalism_number[0]=(number&32'h0000000f);
      cout=0;
      end
 if(((number&32'h000000f0)>>4+cout)>9)
      begin
      decimalism_number[1]=((number&32'h000000f0)>>4+cout)-10;
      cout=1;
      end
      else begin
      decimalism_number[1]=((number&32'h000000f0)>>4+cout);
      cout=0;
      end  
 if(((number&32'h00000f00)>>8+cout)>9)
       begin
       decimalism_number[2]=((number&32'h00000f00)>>8+cout)-10;
       cout=1;
       end
       else begin
       decimalism_number[2]=((number&32'h00000f00)>>8+cout);
       cout=0;
       end 
 if(((number&32'h0000f000)>>12+cout)>9)
       begin
       decimalism_number[3]=((number&32'h0000f000)>>12+cout)-10;
       cout=1;
       end
       else begin
       decimalism_number[3]=((number&32'h0000f000)>>12+cout);
       cout=0;
       end
 if(((number&32'h000f0000)>>16+cout)>9)
       begin
       decimalism_number[4]=((number&32'h000f0000)>>16+cout)-10;
       cout=1;
       end
       else begin
       decimalism_number[4]=((number&32'h000f0000)>>16+cout);
       cout=0;
       end
 if(((number&32'h00f00000)>>20+cout)>9)
       begin
       decimalism_number[5]=((number&32'h00f00000)>>20+cout)-10;
       cout=1;
       end
       else begin
       decimalism_number[5]=((number&32'h00f00000)>>20+cout);
       cout=0;
       end
 if(((number&32'h0f000000)>>24+cout)>9)
       begin
       decimalism_number[6]=((number&32'h0f000000)>>24+cout)-10;
       cout=1;
       end
       else begin
       decimalism_number[6]=((number&32'h0f000000)>>24+cout);
       cout=0;
       end       
 if(((number&32'hf0000000)>>28+cout)>9)
       begin
       decimalism_number[7]=((number&32'hf0000000)>>28+cout)-10;
       cout=1;
       end
       else begin
       decimalism_number[7]=((number&32'hf0000000)>>28+cout);
       cout=0;
       end  
 end
  
                      
 always @(posedge clk) begin  //输出信号选择
    case(select)
      3'h0: begin number=cycle_number; end
      3'h1: begin number=unconditional_branch_number; end
      3'h2: begin number=conditional_branch_number; end
      3'h3:begin end
    default:  number=0;
 endcase
 end
  
 always @(posedge clk) begin
    case(devide) 
    3'h0:begin
         AN=8'b01111111;
          case(decimalism_number[7])
              0: begin display = 8'h3f; end
              1: begin display = 8'h06; end
              2: begin display = 8'h5b; end
              3: begin display = 8'h4f; end
              4: begin display = 8'h66; end
              5: begin display = 8'h6d; end
              6: begin display = 8'h7d; end
              7: begin display = 8'h07; end
              8: begin display = 8'h7f; end
              9: begin display = 8'h6f; end
              default:  display = 8'h00;
           endcase
           end
       
     3'h1:begin
                AN=8'b10111111;
                 case(decimalism_number[6])
                     0: begin display = 8'h3f; end
                     1: begin display = 8'h06; end
                     2: begin display = 8'h5b; end
                     3: begin display = 8'h4f; end
                     4: begin display = 8'h66; end
                     5: begin display = 8'h6d; end
                     6: begin display = 8'h7d; end
                     7: begin display = 8'h07; end
                     8: begin display = 8'h7f; end
                     9: begin display = 8'h6f; end
                     default:  display = 8'h00;
                  endcase
                  end      

     3'h2:begin
                AN=8'b11011111;
                 case(decimalism_number[5])
                     0: begin display = 8'h3f; end
                     1: begin display = 8'h06; end
                     2: begin display = 8'h5b; end
                     3: begin display = 8'h4f; end
                     4: begin display = 8'h66; end
                     5: begin display = 8'h6d; end
                     6: begin display = 8'h7d; end
                     7: begin display = 8'h07; end
                     8: begin display = 8'h7f; end
                     9: begin display = 8'h6f; end
                     default:  display = 8'h00;
                  endcase
                  end   

     3'h3:begin
                AN=8'b11101111;
                 case(decimalism_number[4])
                     0: begin display = 8'h3f; end
                     1: begin display = 8'h06; end
                     2: begin display = 8'h5b; end
                     3: begin display = 8'h4f; end
                     4: begin display = 8'h66; end
                     5: begin display = 8'h6d; end
                     6: begin display = 8'h7d; end
                     7: begin display = 8'h07; end
                     8: begin display = 8'h7f; end
                     9: begin display = 8'h6f; end
                     default:  display = 8'h00;
                  endcase
                  end 

     3'h4:begin
                AN=8'b11110111;
                 case(decimalism_number[3])
                     0: begin display = 8'h3f; end
                     1: begin display = 8'h06; end
                     2: begin display = 8'h5b; end
                     3: begin display = 8'h4f; end
                     4: begin display = 8'h66; end
                     5: begin display = 8'h6d; end
                     6: begin display = 8'h7d; end
                     7: begin display = 8'h07; end
                     8: begin display = 8'h7f; end
                     9: begin display = 8'h6f; end
                     default:  display = 8'h00;
                  endcase
                  end                     
 
     3'h5:begin
                             AN=8'b11111011;
                              case(decimalism_number[2])
                                  0: begin display = 8'h3f; end
                                  1: begin display = 8'h06; end
                                  2: begin display = 8'h5b; end
                                  3: begin display = 8'h4f; end
                                  4: begin display = 8'h66; end
                                  5: begin display = 8'h6d; end
                                  6: begin display = 8'h7d; end
                                  7: begin display = 8'h07; end
                                  8: begin display = 8'h7f; end
                                  9: begin display = 8'h6f; end
                                  default:  display = 8'h00;
                               endcase
                               end 

     3'h6:begin
                             AN=8'b11111101;
                              case(decimalism_number[1])
                                  0: begin display = 8'h3f; end
                                  1: begin display = 8'h06; end
                                  2: begin display = 8'h5b; end
                                  3: begin display = 8'h4f; end
                                  4: begin display = 8'h66; end
                                  5: begin display = 8'h6d; end
                                  6: begin display = 8'h7d; end
                                  7: begin display = 8'h07; end
                                  8: begin display = 8'h7f; end
                                  9: begin display = 8'h6f; end
                                  default:  display = 8'h00;
                               endcase
                               end

     3'h7:begin
                             AN=8'b11111110;
                              case(decimalism_number[0])
                                  0: begin display = 8'h3f; end
                                  1: begin display = 8'h06; end
                                  2: begin display = 8'h5b; end
                                  3: begin display = 8'h4f; end
                                  4: begin display = 8'h66; end
                                  5: begin display = 8'h6d; end
                                  6: begin display = 8'h7d; end
                                  7: begin display = 8'h07; end
                                  8: begin display = 8'h7f; end
                                  9: begin display = 8'h6f; end
                                  default:  display = 8'h00;
                               endcase
                               end                               
       default:
       AN=8'b11111111;  
       endcase
       end
    
  
 eight_devide devide_1(clk,devide);
 Cycle_counter  counter(clk_N,clock_counter_en,unconditional_branch_counter_en,conditional_branch_counter_en,reset,cycle_number,unconditional_branch_number,conditional_branch_number );

    
 
    
endmodule
