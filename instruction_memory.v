module instruction_memory (
  input [15:0] in,                 // 16 bit data input from testbench
  input clk,                       // clock 
  input rw,                        // rw = 1 for read and rw = 0 for write
  output reg [7:0] out,            // output instruction on demand of control unit
  input done,                      // confirmation of instrcution has been writen by testbench
  input [7:0] addr                 // address of output instrcution
);

reg [7:0] data,add;

reg [7:0] mem [255:0];

reg d;

always @(posedge done) begin
  d = 1'b1;
end

  always @(posedge d) begin         // to store the instruction at the given location at posedge done
    add = in[15:8];                 
  data = in[7:0];
  mem[add] = data;
  d = 1'b0;
end

  always @(negedge clk) begin      // to read the the data from instrucion memory from given address
  if(rw == 1) begin
    out = mem[addr];
  end
end
endmodule
