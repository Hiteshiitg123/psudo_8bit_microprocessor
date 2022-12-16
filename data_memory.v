module data_block (
    input [3:0] addr,
    input r,w,               // rw == 1 for read and rw == 0 for write 
    output reg [7:0] out,
    input clk,
    input [7:0] in,
    output reg done

);

reg [7:0] mem [15:0];

initial begin
mem[1] = 8'b00001111;
mem[3] = 8'b00001001;
    done = 0;
end

always @(clk) begin
if(w == 1)begin mem[addr] = in; done = ~done; end
if(r == 1)begin out = mem[addr]; end
    
end
    
endmodule