module SecondROM(
  input [1:0] in22,
  output reg [31:0] out22
);
  always @(*) begin
    case (in22)
      00 : out22 = 32'h00000099;
      01 : out22 = 32'h00000042;
      10 : out22 = 32'h00000003;
      11 : out22 = 32'h00000086;
    endcase
    
  end
endmodule

