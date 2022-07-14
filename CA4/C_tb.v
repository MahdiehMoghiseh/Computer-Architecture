`include "CA4.v"
module Control_tb();
  reg clk, reset;
  reg [31:0] id;
  wire red, blue, green, door;

	reg [32:0] data [9:0];
  reg [32:0] var; 
  integer i;
  integer file;
	Control c(clk,reset,id,red,blue,green,door);
	initial begin
		clk = 0;
	end
	always  begin
		#100;
    clk = ~clk;
	end
    initial begin
        $readmemb("D:\\Tamrin\\CA\\CA\\input.txt",data);

        for (i =0 ;i < 10 ;i = i + 1) begin
            $display("%b", data[i]);
            var = data[i];
            reset = var[32];
            id = var[31:0];
            #200;
        end
        #20;
        $finish;
    end
    initial begin
        file = $fopen("D:\\Tamrin\\CA\\CA\\output.txt");
        
    end
    always @(red, blue, green, door) begin
        $fwrite(file,"red=%d blue=%d green=%d door=%d\n",red,blue,green,door);  
    end
endmodule