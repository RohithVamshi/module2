module axi#(
parameter DataWidth = 16,   
parameter Depth = 4096,
parameter PtrWidth = $clog2(Depth),
parameter MAX_VALUE = Depth
)
(
      input clk,rst,
      input rd,wr,
      input [DataWidth-1:0]s_data,
      input s_valid,
      output reg s_ready,
      input s_last,
      
      output reg [DataWidth-1:0]m_data,
      output reg m_valid,
      input m_ready,
      output reg m_last,
      
      
      output [DataWidth-1:0]data_out1,
      output [DataWidth-1:0]data_out2,
      
      output full,
      output empty
   );
   
   wire r,w,ready;
   reg valid,last;
   wire [DataWidth-1:0]m_data_reg;
   wire e1,e2,f1,f2;
   assign ready = m_ready;
   always @(posedge clk)
   begin
           if(rst)
           begin
                   valid<=0;
                   last<=0;
           end
           else
           begin
                   if(s_valid && ready)
                   begin
                            valid<=s_valid;
                             last<=s_last;
                   end
                   else
                   begin
                            valid<=0;
                             last<=0;
                   end
           end
   end
   
   assign r = (s_valid && ready&&rd) ;
   assign w = ((s_valid && ready) || s_valid==1)&&wr;
   
   fifo_4096 fifo ( clk, rst, s_data, r, w, e1,f1,e2,f2,empty, full, data_out1, data_out2);                  
    
    assign m_data_reg = e1?data_out2:data_out1 ;
    
    always @(posedge clk)
    begin
            if(s_valid && ready)
            begin 
                    m_data <=  m_data_reg;
                    m_valid <= valid;
                    m_last <= last;
                    s_ready <= ready;
            end
    end
endmodule
