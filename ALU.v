module ALU (
    input[7:0] in1,in2,
    output reg [7:0] out,
    input[2:0] select,
    output reg c,z,
    input active
);

always @(active) begin
    case (select)
      3'b000 :  out = in1 + in2;
      3'b001 :  out = in1 - in2;
      3'b010 :  out = in1 & in2;
      3'b011 :  out = in1 | in2;
      3'b100 :  out = in1 ^ in2; 
      3'b101 : begin
        if(in2 > in1) begin  // in2 == rd   in1  == rs/imm2
          c = 1'b0;
          z = 1'b0;
        end
        else if(in2 < in1) begin
          c = 1'b1;
          z = 1'b0;
        end
        else begin
          c = 1'b0;
          z = 1'b1;
        end

      end
    endcase
end
    
endmodule