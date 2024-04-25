module register(
input clk, // clock signal
    input rst, // reset signal
    
    //slave
    input [7:0]s_data,
    input s_valid,
    output reg s_ready,
    input  s_last,
    
    
    //master
    output reg  [7:0]m_data,
    output reg  m_valid,
    input m_ready,
    output reg  m_last

);

reg [7:0]data;
reg valid;
reg last;
wire ready;
  assign ready = m_ready;
  
  always@(posedge clk) begin
    if(rst)begin
        valid <= 1'b0;
        data <= 8'b0;
        last <= 1'b0;
    end
    else begin
         if(s_valid && ready) begin
            data <= s_data;
            valid <= s_valid;
            last <= s_last;
         end
         else begin
            valid <= 1'b0;
            last <= 1'b0;
         end
    end  
end

always@(posedge clk) begin
    m_data = data;
    m_valid = valid;
    m_last = last;
    s_ready = ready;
end
endmodule
  
