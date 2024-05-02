module fifo2048_tb();

parameter DataWidth = 16;
parameter Depth = 2048;
parameter PtrWidth = ($clog2(Depth));
parameter MAX_VALUE = Depth;


reg clk, rst; 
reg [DataWidth-1:0] data_in;
reg rd, wr;
wire empty,full;
wire [DataWidth-1:0] data_out;
wire [DataWidth-1:0] wr_data;


fifo_2048 #(DataWidth, Depth, PtrWidth, MAX_VALUE ) instance1 ( data_in,clk,rst, rd, wr, empty, full, wr_data,data_out);
 

 initial 
    begin
        clk = 0;
        forever #10 clk = ~clk;
    end
    
    
//reset
initial begin
      rst = 1'b1;
      #40;
      rst = 1'b0;
end
   
initial begin
    data_in = 0;
    #40;
    forever #20 data_in = data_in+1;
 end


initial
begin
rd = 0; wr = 1;
#82000;
rd = 1; wr =0;
#164000;
/*rd = 1; wr = 1;
#5000;
rd = 0; wr = 0;
#5000;
wr = 1;
#500;
wr = 0; rd =1;*/
end
     
endmodule
