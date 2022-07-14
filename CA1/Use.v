module Use();
  reg [1:0] oner,twor;
  reg [4:0] threer;
  wire [5:0] w;
  wire [31:0] in0,in1,out1,out2,result;
  wire cout,overflow,zero;

  // use FirstROM 
  FirstROM fr(oner,in0);
  // use SecondROM
  SecondROM sr(twor,in1);
  // use ThirdROM
  ThirdROM tr(threer,w);
  // use FirstMUX
  FirstMUX fm(in0,in1,w[4],out1);
  // use SecondMUX
  SecondMUX sm(in1,in0,w[5],out2);
  // use ALU32
  ALU32 alu32(out1,out2,w[3:0],result,cout,overflow,zero);

  initial begin
    // and
    oner = 2'b00;
    twor = 2'b01;
    threer = 5'b00001;
    #100
    // or
    oner = 2'b00;
    twor = 2'b10;
    threer = 5'b01000;
    #100
    // sum
    oner = 2'b10;
    twor = 2'b11;
    threer = 5'b01001;
    #100
    //sub
    oner = 2'b11;
    twor = 2'b00;
    threer = 5'b10000;
    #100
    // slt
    oner = 2'b10;
    twor = 2'b11;
    threer = 5'b10111;
    #100
    // nor
    oner = 2'b01;
    twor = 2'b11;
    threer = 5'b11110;
  end
endmodule
