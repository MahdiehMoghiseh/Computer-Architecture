module cla(a,b,Cin,s,Cout);
  input [31:0] a;
  input [31:0] b;
  input Cin;
  output [31:0] s;
  output Cout;

  wire [31:0] gen;
  wire [31:0] pro;
  wire [32:0] carry_tmp;

  genvar j, i;
  generate
 
  assign carry_tmp[0] = Cin;
 
 
  for(j = 0; j < 32; j = j + 1) 
  begin : carry_generator
  assign gen[j] = a[j] & b[j];
  assign pro[j] = a[j] | b[j];
  assign carry_tmp[j+1] = gen[j] | pro[j] & carry_tmp[j];
  end
 
  //carry out 
  assign Cout = carry_tmp[32];
 
  for(i = 0; i < 32; i = i+1) 
  begin: sum_without_carry
  assign s[i] = a[i] ^ b[i] ^ carry_tmp[i];
  end 
  endgenerate 
endmodule
