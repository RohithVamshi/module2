
module fifo_4096#(
parameter DataWidth = 16,
    parameter Depth = 4096,
    parameter PtrWidth = 12,
    parameter MAX_VALUE = 2048
)(
    input clk, rst, 
    input [DataWidth-1:0] data_in,
    input rd, wr,
    output  empty1,
    output  full1,
    output  empty2,
    output  full2,
    output reg empty,
    output reg full,
    output  [DataWidth-1:0] data_out1,
    output  [DataWidth-1:0] data_out2
);


reg w1,w2,r1,r2;
integer i;


   

always@(posedge clk) begin
    if (rst) begin
        r1 <= 1'b0;
        w1 <= 1'b0;
        r2 <= 1'b0;
        w2 <= 1'b0;
    end 
    else begin
        r1 = (~empty1 && rd) ? 1'b1 : 1'b0;
        w1 = (~full1 && wr) ? 1'b1 : 1'b0;
        r2 = (empty1 && ~empty2 && rd) ? 1'b1 : 1'b0 ;
        w2 = (full1 && ~full2 && wr) ? 1'b1 : 1'b0 ; 
    end
end


fifo_2048#(DataWidth,Depth, PtrWidth, MAX_VALUE ) fifo1(data_in, clk, rst, r1, w1,empty1,full1,data_out1);
fifo_2048#(DataWidth,Depth, PtrWidth, MAX_VALUE ) fifo2(data_in, clk, rst, r2, w2,empty2,full2,data_out2);

always @(posedge clk,posedge rst) begin
    if (rst) begin
        full <= 1'b0;
        empty <= 1'b1;
    end else begin
        full <= full1 && full2;
        empty <= empty1 && empty2;
    end
end

endmodule
