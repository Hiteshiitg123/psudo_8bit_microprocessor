module  control_unit (
  input[15:0] in,
  input sub_clk,rst,c,z,
  output reg system_clk,clk,
  wire [7:0] pc_out,i_out,m_out,
  wire [7:0] r_out,a_out,
  input done,
  output reg m_r,m_w,r_r,r_w,
  wire [3:0] imm4,opcode,
  wire [1:0] imm2,Rd,Rs,
  output reg d_act,r_act,a_act,
  output reg [7:0] num,
  output reg [2:0] state,
  wire r_done,d_done,
  output reg [7:0] in1,in2
);

//wire [7:0] pc_out,i_out,m_out;
//wire [3:0] imm4,opcode;
//wire [1:0] imm2,Rd,Rs;



reg [2:0] sel;
reg [7:0] r_in,d_in;
reg [3:0] a_sel;

//always @(*) begin
//  pc_out1 = pc_out;
//end

//always @(*) begin
//  i_out1 = i_out;
//end

//always @(*) begin
//  opcode1 = opcode;
//  Rd1 = Rd;
//  Rs1 = Rs;
//  imm21 = imm2;
//  imm41 = imm4;
//end

//always @ (m_out) begin
//m_out1 = m_out;
//end

//always @(clk) begin
//  r_out1 = r_out;
//end

always @ (posedge sub_clk) begin
if(rst == 1) begin
system_clk = 1;
clk = 1;
state <= 3'b000;
end

else begin
clk = ~clk;
end
end



always @ (posedge clk) begin
system_clk = ~system_clk;
end

programme_counter C(system_clk,rst,pc_out);
instruction_memory I(in,system_clk,1'b1,i_out,done,pc_out);
instruction_decoder D(i_out,system_clk,opcode,Rd,Rs,imm2,imm4);
data_block D1(imm4,m_r,m_w,m_out,d_act,d_in,d_done);
register_block R(sel,r_in,r_out,r_r,r_w,r_act,r_done);
ALU A(r_out,num,a_out,a_sel,c,z,a_act);

always @ (posedge system_clk) begin
state <= 3'b000;
end


always @(sub_clk) begin
  case (opcode)
   4'b0000 : begin
    r_w <= 1;
    m_r <= 1;
    sel <= 2'b00;
    r_in <= m_out;
    d_act <= 1;
    r_act <= 1;
   end 

   4'b0001 : begin
    r_r <= 1;
    m_w <= 1;
    sel <= 2'b00;
    d_in <= r_out;
    d_act <= 1;
    r_act <= 1;
   end

   4'b0010 : begin
    case (imm2)
     2'b00 : r_in <= 8'b00000000;
     2'b01 : r_in <= 8'b00000001;
     2'b10 : r_in <= 8'b11111110;
     2'b11 : r_in <= 8'b11111111;
    endcase
    r_w <= 1;
    sel <= Rd;
    r_act <= 1;
   end
   4'b0011 : begin
    if(d_act == 0 && r_act == 0) begin
      case (state)
      3'b000 : begin
        r_r <= 1;
        r_act <= 1;
        sel <= Rs;
        state <= 3'b001;
      end 
      3'b001 : begin
        r_act <= 1;
        r_w <= 1;
        sel <= Rd;
        r_in <= r_out;
      end
      endcase
    end
    end
      4'b0100 : begin
        if(d_act == 0 && r_act == 0) begin
          case (state)
           3'b000 : begin
            r_act <= 1;
            r_r <= 1;
            sel <= Rs;
            state <= 3'b001;
           end 
           3'b010 : begin
            r_act <= 1;
            r_r <= 1;
            sel <= Rd;
            state <= 3'b011;
           end
           3'b011 : begin
           a_act <= 1;
           a_sel <= 3'b000;
           state <= 3'b100;
           end
           3'b100 : begin
            if(a_out[1] == 0 && a_out[0] == 0)  r_in <= 8'b00000000 ;
            else if(a_out[1] == 0 && a_out[0] == 1) r_in <= 8'b00000001;
            else if(a_out[1] == 1 && a_out[0] == 0) r_in <= 8'b11111110;
            else if(a_out[1] == 1 && a_out[1] == 1) r_in <= 8'b11111111;
           //r_in <= a_out;
           r_w <= 1;
           r_act <= 1;
           sel <= Rd;
           state <= 3'b101;
           end
          endcase
        end
        else begin
          case (state)
          3'b001 : begin
           num <= r_out;
           state <= 3'b010;
           end
          endcase
        end
      end
      4'b0101 : begin
        if(d_act == 0 && r_act == 0) begin
          case (state)
           3'b000 : begin
            r_act <= 1;
            r_r <= 1;
            sel <= Rs;
            state <= 3'b001;
           end 
           3'b010 : begin
            r_act <= 1;
            r_r <= 1;
            sel <= Rd;
            state <= 3'b011;
           end
           3'b011 : begin
           a_act <= 1;
           a_sel <= 3'b001;
           state <= 3'b100;
           end
           3'b100 : begin
            if(a_out[1] == 0 && a_out[0] == 0) r_in <= 8'b00000000;
            else if(a_out[1] == 0 && a_out[0] == 1) r_in <= 8'b00000001;
            else if(a_out[1] == 1 && a_out[0] == 0) r_in <= 8'b11111110;
            else if(a_out[1] == 1 && a_out[1] == 1) r_in <= 8'b11111111;
           //r_in <= a_out;
           r_w <= 1;
           r_act <= 1;
           sel <= Rd;
           state <= 3'b101;
           end
          endcase
        end
        else begin
          case (state)
          3'b001 : begin
           num <= r_out;
           state <= 3'b010;
           end
          endcase
        end
      end
      4'b0110 : begin
        if(d_act == 0 && r_act == 0) begin
          case (state)
           3'b000 : begin
            r_act <= 1;
            r_r <= 1;
            sel <= Rs;
            state <= 3'b001;
           end 
           3'b010 : begin
            r_act <= 1;
            r_r <= 1;
            sel <= Rd;
            state <= 3'b011;
           end
           3'b011 : begin
           a_act <= 1;
           a_sel <= 3'b010;
           state <= 3'b100;
           end
           3'b100 : begin
            if(a_out[1] == 0 && a_out[0] == 0)  r_in <= 8'b00000000 ;
            else if(a_out[1] == 0 && a_out[0] == 1) r_in <= 8'b00000001;
            else if(a_out[1] == 1 && a_out[0] == 0) r_in <= 8'b11111110;
            else if(a_out[1] == 1 && a_out[1] == 1) r_in <= 8'b11111111;
           //r_in <= a_out;
           r_w <= 1;
           r_act <= 1;
           sel <= Rd;
           state <= 3'b101;
           end
          endcase
        end
        else begin
          case (state)
          3'b001 : begin
           num <= r_out;
           state <= 3'b010;
           end
          endcase
        end
      end

      4'b0111 : begin
        if(d_act == 0 && r_act == 0) begin
          case (state)
           3'b000 : begin
            r_act <= 1;
            r_r <= 1;
            sel <= Rs;
            state <= 3'b001;
           end 
           3'b010 : begin
            r_act <= 1;
            r_r <= 1;
            sel <= Rd;
            state <= 3'b011;
           end
           3'b011 : begin
           a_act <= 1;
           a_sel <= 3'b101;
           state <= 3'b100;
           end
          endcase
        end
        else begin
          case (state)
          3'b001 : begin
           num <= r_out;
           state <= 3'b010;
           end
          endcase
        end
      end

      4'b1000 : begin
        if(d_act == 0 && r_act == 0) begin
          case (state)
           3'b000 : begin
            r_act <= 1;
            r_r <= 1;
            sel <= Rs;
            state <= 3'b001;
           end 
           3'b010 : begin
            r_act <= 1;
            r_r <= 1;
            sel <= Rd;
            state <= 3'b011;
           end
           3'b011 : begin
           a_act <= 1;
           a_sel <= 3'b011;
           state <= 3'b100;
           end
           3'b100 : begin
            if(a_out[1] == 0 && a_out[0] == 0)  r_in <= 8'b00000000 ;
            else if(a_out[1] == 0 && a_out[0] == 1) r_in <= 8'b00000001;
            else if(a_out[1] == 1 && a_out[0] == 0) r_in <= 8'b11111110;
            else if(a_out[1] == 1 && a_out[1] == 1) r_in <= 8'b11111111;
           //r_in <= a_out;
           r_w <= 1;
           r_act <= 1;
           sel <= Rd;
           state <= 3'b101;
           end
          endcase
        end
        else begin
          case (state)
          3'b001 : begin
           num <= r_out;
           state <= 3'b010;
           end
          endcase
        end
      end
      4'b1001 : begin
        if(d_act == 0 && r_act == 0) begin
          case (state)
           3'b000 : begin
            case (imm2)
              2'b00 : num <= 8'b00000000;
              2'b01 : num <= 8'b00000001;
              2'b10 : num <= 8'b11111110;
              2'b11 : num <= 8'b11111111;
            endcase
            r_act <= 1;
            r_r <= 1;
            sel <= Rd;
            state <= 3'b001;
           end 
           3'b001 : begin
            a_act <= 1;
            a_sel <= 3'b011;
            state <= 3'b010;
           end
           3'b010 : begin
            if(a_out[1] == 0 && a_out[0] == 0)  r_in <= 8'b00000000 ;
            else if(a_out[1] == 0 && a_out[0] == 1) r_in <= 8'b00000001;
            else if(a_out[1] == 1 && a_out[0] == 0) r_in <= 8'b11111110;
            else if(a_out[1] == 1 && a_out[1] == 1) r_in <= 8'b11111111;
           //r_in <= a_out;
           r_w <= 1;
           r_act <= 1;
           sel <= Rd;
           state <= 3'b011;
           end
          endcase
        end
      end
      4'b1010 : begin
        if(d_act == 0 && r_act == 0) begin
          case (state)
           3'b000 : begin
            r_act <= 1;
            r_r <= 1;
            sel <= Rs;
            state <= 3'b001;
           end 
           3'b010 : begin
            r_act <= 1;
            r_r <= 1;
            sel <= Rd;
            state <= 3'b011;
           end
           3'b011 : begin
           a_act <= 1;
           a_sel <= 3'b100;
           state <= 3'b100;
           end
           3'b100 : begin
            if(a_out[1] == 0 && a_out[0] == 0)  r_in <= 8'b00000000 ;
            else if(a_out[1] == 0 && a_out[0] == 1) r_in <= 8'b00000001;
            else if(a_out[1] == 1 && a_out[0] == 0) r_in <= 8'b11111110;
            else if(a_out[1] == 1 && a_out[1] == 1) r_in <= 8'b11111111;
           //r_in <= a_out;
           r_w <= 1;
           r_act <= 1;
           sel <= Rd;
           state <= 3'b101;
           end
          endcase
        end
        else begin
          case (state)
          3'b001 : begin
           num <= r_out;
           state <= 3'b010;
           end
          endcase
        end
      end

      4'b1011 : begin
        if(d_act == 0 && r_act == 0) begin
          case (state)
           3'b000 : begin
            case (imm2)
              2'b00 : num <= 8'b00000000;
              2'b01 : num <= 8'b00000001;
              2'b10 : num <= 8'b11111110;
              2'b11 : num <= 8'b11111111;
            endcase
            r_act <= 1;
            r_r <= 1;
            sel <= Rd;
            state <= 3'b001;
           end 
           3'b001 : begin
            a_act <= 1;
            a_sel <= 3'b100;
            state <= 3'b010;
           end
           3'b010 : begin
            if(a_out[1] == 0 && a_out[0] == 0)  r_in <= 8'b00000000 ;
            else if(a_out[1] == 0 && a_out[0] == 1) r_in <= 8'b00000001;
            else if(a_out[1] == 1 && a_out[0] == 0) r_in <= 8'b11111110;
            else if(a_out[1] == 1 && a_out[1] == 1) r_in <= 8'b11111111;
           //r_in <= a_out;
           r_w <= 1;
           r_act <= 1;
           sel <= Rd;
           state <= 3'b011;
           end
          endcase
        end
      end

      4'b1100 : begin
        if(d_act == 0 && r_act == 0) begin
          case (state)
           3'b000 : begin
            case (imm2)
              2'b00 : num <= 8'b00000000;
              2'b01 : num <= 8'b00000001;
              2'b10 : num <= 8'b11111110;
              2'b11 : num <= 8'b11111111;
            endcase
            r_act <= 1;
            r_r <= 1;
            sel <= Rd;
            state <= 3'b001;
           end 
           3'b001 : begin
            a_act <= 1;
            a_sel <= 3'b000;
            state <= 3'b010;
           end
           3'b010 : begin
            if(a_out[1] == 0 && a_out[0] == 0)  r_in <= 8'b00000000 ;
            else if(a_out[1] == 0 && a_out[0] == 1) r_in <= 8'b00000001;
            else if(a_out[1] == 1 && a_out[0] == 0) r_in <= 8'b11111110;
            else if(a_out[1] == 1 && a_out[1] == 1) r_in <= 8'b11111111;
           //r_in <= a_out;
           r_w <= 1;
           r_act <= 1;
           sel <= Rd;
           state <= 3'b011;
           end
          endcase
        end
      end
      4'b1101 : begin
        if(d_act == 0 && r_act == 0) begin
          case (state)
           3'b000 : begin
            case (imm2)
              2'b00 : num <= 8'b00000000;
              2'b01 : num <= 8'b00000001;
              2'b10 : num <= 8'b11111110;
              2'b11 : num <= 8'b11111111;
            endcase
            r_act <= 1;
            r_r <= 1;
            sel <= Rd;
            state <= 3'b001;
           end 
           3'b001 : begin
            a_act <= 1;
            a_sel <= 3'b001;
            state <= 3'b010;
           end
           3'b010 : begin
            if(a_out[1] == 0 && a_out[0] == 0)  r_in <= 8'b00000000 ;
            else if(a_out[1] == 0 && a_out[0] == 1) r_in <= 8'b00000001;
            else if(a_out[1] == 1 && a_out[0] == 0) r_in <= 8'b11111110;
            else if(a_out[1] == 1 && a_out[1] == 1) r_in <= 8'b11111111;
           //r_in <= a_out;
           r_w <= 1;
           r_act <= 1;
           sel <= Rd;
           state <= 3'b011;
           end
          endcase
        end
      end
      4'b1110 : begin
        if(d_act == 0 && r_act == 0) begin
          case (state)
           3'b000 : begin
            case (imm2)
              2'b00 : num <= 8'b00000000;
              2'b01 : num <= 8'b00000001;
              2'b10 : num <= 8'b11111110;
              2'b11 : num <= 8'b11111111;
            endcase
            r_act <= 1;
            r_r <= 1;
            sel <= Rd;
            state <= 3'b001;
           end 
           3'b001 : begin
            a_act <= 1;
            a_sel <= 3'b010;
            state <= 3'b010;
           end
           3'b010 : begin
            if(a_out[1] == 0 && a_out[0] == 0)  r_in <= 8'b00000000 ;
            else if(a_out[1] == 0 && a_out[0] == 1) r_in <= 8'b00000001;
            else if(a_out[1] == 1 && a_out[0] == 0) r_in <= 8'b11111110;
            else if(a_out[1] == 1 && a_out[1] == 1) r_in <= 8'b11111111;
           //r_in <= a_out;
           r_w <= 1;
           r_act <= 1;
           sel <= Rd;
           state <= 3'b011;
           end
          endcase
        end
      end
      4'b1111 : begin
        if(d_act == 0 && r_act == 0) begin
          case (state)
           3'b000 : begin
            case (imm2)
              2'b00 : num <= 8'b00000000;
              2'b01 : num <= 8'b00000001;
              2'b10 : num <= 8'b11111110;
              2'b11 : num <= 8'b11111111;
            endcase
            r_act <= 1;
            r_r <= 1;
            sel <= Rd;
            state <= 3'b001;
           end 
           3'b001 : begin
            a_act <= 1;
            a_sel <= 3'b101;
            state <= 3'b010;
           end
          endcase
        end
      end
    endcase
   end

always @(sub_clk) begin
  if(r_r == 1) r_r <= 0;
  if(r_w == 1) r_w <= 0;
  if(m_r == 1) m_r <= 0;
  if(m_w == 1) m_w <= 0;
  if(d_act == 1) d_act <= 0;
  if(r_act == 1) r_act <= 0;
  if(a_act == 1) a_act <= 0;
  
end

endmodule
