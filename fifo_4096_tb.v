module fifo_4096_tb();

parameter DataWidth = 16;
parameter Depth = 4096;
parameter PtrWidth = ($clog2(Depth));
parameter MAX_VALUE = Depth;

reg clk, rst; 
reg [DataWidth-1:0] data_in;
reg rd, wr;
wire empty1;
wire full1;
wire empty2;
wire full2;

wire empty;
wire full;

wire [DataWidth-1:0] data_out1;
wire [DataWidth-1:0] data_out2;

fifo_4096 #(DataWidth, Depth, PtrWidth, MAX_VALUE ) dutest (clk, rst, data_in, rd, wr,empty1,full1,empty2,full2, empty, full, ,data_out1, data_out2);

   
// Clock Generation
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
