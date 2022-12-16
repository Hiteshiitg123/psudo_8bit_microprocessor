module test;

reg clk1,rst,done;
wire clk2,c,z;
reg [15:0] in;
wire [7:0] out1,out2,out3,out4,a_out,num,in1,in2;
wire [3:0] opcode,imm4;
wire [1:0] imm2,Rd,Rs;
wire [2:0] state;
wire r1,w1,r2,w2,act1,act2,d_r,d_d,a_act;

final C(in,clk1,rst,c,z,clk3,clk2,out1,out2,out3,out4,a_out,done,r1,w1,r2,w2,imm4,opcode,imm2,Rd,Rs,act1,act2,a_act,num,state,d_r,d_d,in1,in2);

initial begin
  $dumpfile("GTK.vcd");
  $dumpvars(1,test);
end

initial begin
clk1 = 0;
forever begin #1 clk1 = ~clk1;end
end

initial begin
in = 16'b0000000000000011; done = 1; #1 done = 0;
#4 in = 16'b0000000100010000; done = 1; #1 done = 0;
#4 in = 16'b0000001000000001; done = 1; #1 done = 0;
#4 in = 16'b0000001100000000; done = 1; #1 done = 0;
#4 in = 16'b0000010000100110; done = 1; #1 done = 0;
#4 in = 16'b0000010100010000; done = 1; #1 done = 0;
#4 in = 16'b0000011000110001; done = 1; #1 done = 0;
#4 in = 16'b0000011100010000; done = 1; #1 done = 0;
#4 in = 16'b0000100000000000; done = 1; #1 done = 0;
#4 in = 16'b0000100100100101; done = 1; #1 done = 0;
#4 in = 16'b0000101000111001; done = 1; #1 done = 0;
#4 in = 16'b0000101100010000; done = 1; #1 done = 0; 
#4 in = 16'b0000110000110010; done = 1; #1 done = 0;
#4 in = 16'b0000110100010000; done = 1; #1 done = 0;
#4 in = 16'b0000111000000000; done = 1; #1 done = 0;
#4 in = 16'b0000111100100001; done = 1; #1 done = 0;
#4 in = 16'b0001000000100110; done = 1; #1 done = 0;
#4 in = 16'b0001000101000001; done = 1; #1 done = 0;
#4 in = 16'b0001001000010000; done = 1; #1 done = 0;
#4 in = 16'b0001001100100010; done = 1; #1 done = 0;
#4 in = 16'b0001010000100101; done = 1; #1 done = 0;
#4 in = 16'b0001010101010001; done = 1; #1 done = 0;
#4 in = 16'b0001011000010000; done = 1; #1 done = 0;
#4 in = 16'b0001011100100110; done = 1; #1 done = 0;
#4 in = 16'b0001100001100001; done = 1; #1 done = 0;
#4 in = 16'b0001100100010000; done = 1; #1 done = 0;
#4 in = 16'b0001101000100001; done = 1; #1 done = 0;
#4 in = 16'b0001101100100110; done = 1; #1 done = 0;
#4 in = 16'b0001110010000001; done = 1; #1 done = 0;
#1 in = 16'b0001110100010000; done = 1; #1 done = 0;
#4 in = 16'b0001111010100001; done = 1; #1 done = 0;
#4 in = 16'b0001111100010000; done = 1; #1 done = 0;
#4 in = 16'b0010000001110001; done = 1; #1 done = 0;
#4 in = 16'b0010000110010011; done = 1; #1 done = 0;
#4 in = 16'b0010001000010000; done = 1; #1 done = 0;
#4 in = 16'b0010001100100010; done = 1; #1 done = 0;
#4 in = 16'b0010010010110001; done = 1; #1 done = 0;
#4 in = 16'b0010010100010000; done = 1; #1 done = 0;
#4 in = 16'b0010011011000001; done = 1; #1 done = 0;
#4 in = 16'b0010011100010000; done = 1; #1 done = 0;
#4 in = 16'b0010100011010001; done = 1; #1 done = 0;
#4 in = 16'b0010100100010000; done = 1; #1 done = 0;
#4 in = 16'b0010101011100001; done = 1; #1 done = 0;
#4 in = 16'b0010101100010000; done = 1; #1 done = 0;
#4 in = 16'b0010110011110000; done = 1; #1 done = 0;





  #5 rst = 1;
  #4 rst = 0;



end

initial #1000 $finish;

endmodule