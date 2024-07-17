
module fifo_4096_axi_tb
();

parameter DataWidth = 16; 
parameter Depth = 4096;
parameter PtrWidth = ($clog2(Depth));
parameter MAX_VALUE = 2048;

reg clk,rst;
reg rd;
reg wr;
 reg [DataWidth-1:0]s_data;
reg s_valid;
wire s_ready;
reg s_last;
      
wire [DataWidth-1:0]m_data;
wire m_valid;
reg m_ready;
wire m_last;
     
wire [DataWidth-1:0]data_out1;
wire [DataWidth-1:0]data_out2;
reg [ DataWidth-1:0] datain;     
wire full;
wire empty;
 
 fifo_4096_axi #(DataWidth, Depth, PtrWidth, MAX_VALUE )
 test ( clk, rst,rd,wr, s_data, s_valid, s_ready, s_last, m_data, m_valid, m_ready,m_last, data_out1,data_out2, full, empty); 

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
/*   
initial begin
if(rst)
 s_data =0;
 else
 if(~rst)
    s_data = 0;
   repeat(6000)
   begin
   @(posedge clk)
   s_data=s_data+1;
   end
   
 end

*/

always @(posedge clk)
begin
if(rst)
begin
s_data<=0;
end
else
begin
s_data<=1;
forever #20 s_data <= s_data +1;
end
end





initial
begin
rd = 0; wr = 1;
#83000;
rd = 1; wr =0;
#164000;
end
initial
begin

s_valid = 1;
#510
s_valid = 0;
#40
s_valid = 1;
#40
s_valid = 0;
#40
s_valid = 1;

#82840
s_valid = 0;
#40
s_valid = 1;
#40
s_valid = 0;
#40
s_valid = 1;


end

initial 
begin
m_ready=0;
#40
m_ready = 1;
#610
m_ready = 1;
#82840
m_ready = 0;
#20
m_ready = 1;
#60
m_ready = 0;
#400
m_ready = 1;
#20
m_ready = 1;
#20
m_ready = 1;


end

initial
begin
forever
begin
repeat(7) @(posedge clk)s_last = 0;
@(posedge clk)s_last = 1;
end
