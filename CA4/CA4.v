module Control(
  input clk,
  input reset,
  input [31:0] id, // id is 4 byte
  output reg red, // 0 -> off    1 -> on
  output reg blue,
  output reg green,
  output reg door // 1 => open   0 => close
);

reg [31:0] memory [8:0];
integer size  = 0;    
reg [3:0] current, next;
integer i;
reg flag = 0;
reg [7:0] counter = 7'd0;
reg adminMode, userMode;
reg[31:0] admin = 32'd0;

localparam state0 = 4'd0; // reset 
localparam state1 = 4'd1; // add admin
localparam state2 = 4'd2; // go to admin Mode
localparam state3 = 4'd3; // add new user to memory
localparam state4 = 4'd4; // delete user from memory
localparam state5 = 4'd5; // known user => green 
localparam state6 = 4'd6; // unkown user => red

always @(posedge clk,posedge reset) begin
    if (reset) begin
        current = state0;
    end else begin
        current = next;
    end
end

always @(id, current)begin
  case (current)
    state0: begin
        for (i = 0;i < size; i= i + 1 ) begin
          memory[i] = 32'bz;   
        end
        blue = 0;
        green = 0;
        red = 0;
        door = 0;
        admin = id;
        if (adminMode!=0) begin
            next = state1;
        end
        adminMode = 0;
        userMode = 0;
    end 

    state1: begin
            blue = 1;
            green = 0;
            red = 0;
            door = 0;
            if (id == admin) begin
                next = state2;
                adminMode = 1;
                userMode = 0;
            end
            else if (id != admin) begin
                adminMode = 0;
                userMode = 1;
                blue = 1;
                green = 0;
                red = 0;
                flag = 0;
                for (i = 0; i<size; i = i+1) begin
                    if (memory[i]== id) begin
                        flag = 1;
                    end
                end
                if (flag) begin
                  next = state5; 
                end else begin
                  next = state6;
                end
            end
        end
        state2: begin
            flag = 0;
            blue = 1;
            green = 0;
            red = 0;
            door = 0;
            if (id != admin) begin
                for (i = 0;i < size ; i = i + 1) begin
                    if (id == memory[i]) begin
                        counter = i;
                        flag = 1;
                    end
                end
                 if (flag) begin
                    next = state4;
                end
                if(!flag) begin
                    next = state3;
                end
            end
            if (id == admin) begin
                next = state1;
                adminMode = 0;
                userMode = 1;
            end 
        end
        state3: begin
            memory[size] = id;
            size <= size + 1;
            next = state2;
            blue = 0;
            green = 0;
            red = 0;       
            door = 0;             
        end
        state4: begin
            for (i = counter ;i<size;i = i + 1 ) begin
                memory[i] = memory[i+1];
            end
            size = size - 1;
            blue = 0;
            green = 0;
            red = 0;
            door = 0;
            next = state2; 
        end
        state5: begin
            blue = 0;
            green = 1;
            red = 0;
            current = state1;
            door = 1;
        end
        state6: begin
            blue = 0;
            green = 0;
            red = 1;
            door = 0;
            current = state1;
        end
        default: begin  
        blue = 0;
        green = 0;
        red = 0;
        door = 0;
        adminMode = 0;
        userMode = 0;
        end
  endcase
end

endmodule