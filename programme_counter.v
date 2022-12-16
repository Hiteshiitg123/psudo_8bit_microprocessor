module programme_counter (
    input clk,rst,
    output reg [7:0] out
);


always @(posedge clk) begin
    if(rst == 1) begin
        out = 8'b0;
    end
    else begin
        out = out + 1;
    end

end
    
endmodule