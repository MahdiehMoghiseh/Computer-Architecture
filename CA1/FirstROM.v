module FirstROM(
  input [1:0] in,
  output reg [31:0] out
);
  always @(*) begin
    case (in)
      00 : out = 32'h00000099;
      01 : out = 32'h00000024;
      10 : out = 32'h00000030;
      11 : out = 32'h00000068;
    endcase
  end
endmodule
