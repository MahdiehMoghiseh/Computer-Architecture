module FirstMUX(
  input [31:0] in00,in11,
  input sel1,
  output [31:0] outt
  );
  assign outt = sel1 == 0 ? in00 : in11;
endmodule
