module SecondMUX(
  input [31:0] in000,in111,
  input sel2,
  output [31:0] outtt
  );
  assign outtt = sel2 == 0 ? in000 : in111;
endmodule

