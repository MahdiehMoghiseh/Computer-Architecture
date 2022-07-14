module ALU32(
  input [31:0] a,b,
  input [3:0] operation,
  output reg [31:0] result,
  output reg cout,overflow,zero
  );

  wire Cin,CoutCLA1,CoutCLA2;
  wire [31:0] sum,sum2;
  
  assign Cin = operation == 4'b0110 ? 1 : 0;
  // for sum and sub
  cla cla(a,b,Cin,sum,CoutCLA1);
  cla cla2(a,~b,Cin,sum2,CoutCLA2);
  always @(*) begin
    overflow = 0;
    cout = 0;
    case (operation)
      4'b0000 : begin
        result = a&b;
      end
      4'b0001 : begin
        result = a|b;
      end
      4'b0010 : begin
        result = sum;
        cout = CoutCLA1;
        if (a<0 && b<0 && result>0) begin
          overflow = 1;
        end
        if (a>0 && b>0 && result<0) begin
          overflow = 1;
        end
      end
      4'b0110 : begin
        result = sum2;
        cout = CoutCLA2;
      end
      4'b0111 : begin
        result = (a<b ? 1 : 0);
      end
      4'b1100 : begin
        result = ~(a|b);
      end
    endcase
    zero = result==0 ? 1 : 0;
  end
endmodule
