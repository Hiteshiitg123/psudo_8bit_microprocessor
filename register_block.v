module register_block (
    input [1:0] sel,
    input [7:0] in,
    output reg [7:0] out,
    input r,w,act,            // 1 for read and 0 for write
    output reg done
);

reg [7:0] mem [3:0];

initial done = 0;

always @(act) begin
    if(w == 1) begin mem[sel] = in; done = ~done; end
    if(r == 1) begin out = mem[sel]; end
end
    
endmodule
