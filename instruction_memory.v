module instruction_memory (
  input [15:0] in,
  input clk,
  input rw,                        // rw = 1 for read and rw = 0 for write
  output reg [7:0] out,
  input done,
  input [7:0] addr
);

reg [7:0] data,add;

reg [7:0] mem [255:0];

reg d;

always @(posedge done) begin
  d = 1'b1;
end

always @(posedge d) begin
  add = in[15:8];
  data = in[7:0];
  mem[add] = data;
  d = 1'b0;
end

always @(negedge clk) begin
  if(rw == 1) begin
    out = mem[addr];
  end
end
endmodule