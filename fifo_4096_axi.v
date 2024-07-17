`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.06.2024 17:03:52
// Design Name: 
// Module Name: fifo_4096_axi
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fifo_4096_axi#(
parameter DataWidth = 16,   
parameter Depth = 4096,
parameter PtrWidth = $clog2(Depth),
parameter MAX_VALUE = 2048
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
      
      
      output  [DataWidth-1:0]data_out1,
      output  [DataWidth-1:0]data_out2,
      
      output full,
      output empty
   );
   reg [ DataWidth-1:0] datain;
   wire r,w,ready;
   reg valid,last;
   wire [DataWidth-1:0]m_data_reg;
   wire e1,e2,f1,f2;
   assign ready = m_ready;
  integer i;
  
  
   always @(posedge clk )
   begin
   if (rst|| full)
   s_ready<=0;
   else
   s_ready<=1;
   end
  
  
  
  
   always @(posedge clk)
   begin
           if(rst)
           begin
           last<=0;
           end
           else
           begin
                   if(s_valid && m_ready)
                   begin
                    last<=s_last;
                   end
          end
   end
   
   
   
    always @(posedge clk)
   begin
           if(rst)
                   valid<=0;
           else
           begin
                   if(s_valid && m_ready && rd)
                   valid<=1;
                  
                   else  
                   
               if (s_valid && m_ready &&~rd)
                   begin
                   m_valid<=0;
                   end 
                   else
                    begin
                            valid<=0;
                       end
           end
   end
   
   assign r = (s_valid && m_ready&&rd) ;
   assign w = ((s_valid && m_ready) )&&wr;
   
   fifo_4096 fifo ( clk, rst, s_data, r, w, e1,f1,e2,f2,empty, full, data_out1, data_out2);                  
    
   
    
    always @(posedge clk)
    begin
    m_data <= e1?data_out2:data_out1;
    end
    
    always @(posedge clk)
    begin
            if(s_valid && m_ready)
            begin 
             m_last <= last;
             end
    end

 always @(posedge clk)
    begin
            if( rd)
            begin 
              m_valid<= valid;
           end
    end

endmodule
