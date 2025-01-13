module Bus_sync_2lvl(
    Bus_in, dest_clk, dest_rstn, Bus_sync
   );

parameter Bus_BW = 8;

input [Bus_BW-1:0]  Bus_in; 

input               dest_clk;
input               dest_rstn;
output[Bus_BW-1:0]  Bus_sync;

reg [Bus_BW-1:0]    Bus_stage1; 
reg [Bus_BW-1:0]    Bus_stage2; 
reg [Bus_BW-1:0]    Bus_stage3; 
reg [Bus_BW-1:0]    Bus_sync; 

always@(posedge dest_clk or negedge dest_rstn)
    if(~dest_rstn)
    begin
        Bus_stage1 <= 0; 
        Bus_stage2 <= 0; 
        Bus_stage3 <= 0; 
    end
    else
    begin
        Bus_stage1 <= Bus_in;      
        Bus_stage2 <= Bus_stage1;  
        Bus_stage3 <= Bus_stage2;  
    end

assign Bus_is_stable = (Bus_stage2 == Bus_stage3);

always@(posedge dest_clk or negedge dest_rstn)
    if(~dest_rstn)
        Bus_sync <= 0; 
    else if(Bus_is_stable)
        Bus_sync <= Bus_stage2;      

endmodule
