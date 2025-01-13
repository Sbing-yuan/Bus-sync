`timescale 1ns/1ps
`define VCDDUMP

module TB();

reg src_clk;
reg src_rstn;
reg dest_clk;
reg dest_rstn;
reg [3:0] data_in;
reg [3:0] count;
wire[3:0] data_sync_2lvl;
wire[3:0] data_sync_3lvl;

integer rand_val;

initial begin
    src_clk  = 0;
    dest_clk = 0;
    src_rstn = 1;
    dest_rstn = 1;
    #1;
    src_rstn = 0;
    dest_rstn = 0;
    fork
        begin
            repeat(2) @(posedge src_clk)
            src_rstn = 1;
        end
        begin
            repeat(2) @(posedge dest_clk)
            dest_rstn = 1;
        end
    join
    #(1000);
    $display("TB finish");
    $finish;
end

always #(10) src_clk  = ~src_clk;
always #(13) dest_clk = ~dest_clk;

assign data_toggle = (count == 4'b1111);

always@(posedge src_clk or negedge src_rstn)
    if(~src_rstn)
        data_in <= 4'b0111;
    else if(data_toggle)
        data_in <= (data_in == 4'b0111) ? 4'b1000 : 4'b0111;

always@(posedge src_clk or negedge src_rstn)
    if(~src_rstn)
        count <= 4'd0;
    else 
        count <= count + 4'd1;

Bus_sync_2lvl #(.Bus_BW(4))
UBus_sync_2lvl(
    .Bus_in     (data_in[3:0]),
    .Bus_sync   (data_sync_2lvl[3:0]),
    .dest_clk   (dest_clk),
    .dest_rstn  (dest_rstn));

Bus_sync_3lvl #(.Bus_BW(4))
UBus_sync_3lvl(
    .Bus_in     (data_in[3:0]),
    .Bus_sync   (data_sync_3lvl[3:0]),
    .dest_clk   (dest_clk),
    .dest_rstn  (dest_rstn));

`ifdef VCDDUMP
initial begin
    $dumpfile("Test.vcd");  //
    $dumpvars(0,TB);       
end
`endif

endmodule
