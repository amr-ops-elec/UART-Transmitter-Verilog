`timescale 1ns / 1ps
module serializer_tb();
localparam N = 8;
reg [N-1:0]p_in_tb;
reg sht_en_tb, v_in_tb, clk_tb, rst_tb;
wire serial_out_tb;
serializer dut(.p_in(p_in_tb), .v_in(v_in_tb), .sht_en(sht_en_tb), .clk(clk_tb), .rst(rst_tb), .serial_out(serial_out_tb));
initial begin
    clk_tb = 0;
    forever #5 clk_tb = ~clk_tb;
end
initial begin 
$monitor ("Time=%0t | sht_en=%b , v_in_tb , rst=%b , p_in=%b | serial_out=%b",
$time, sht_en_tb, v_in_tb, rst_tb, p_in_tb, serial_out_tb);
rst_tb = 0;
v_in_tb = 1'b0;
p_in_tb = 8'b1011_0110;
sht_en_tb = 1'b0;
#15;
rst_tb = 1;
@(negedge clk_tb);
p_in_tb = 8'b1011_0110;
v_in_tb = 1'b1;
#10;
v_in_tb = 1'b0;
sht_en_tb = 1'b1;
#80;
sht_en_tb = 1'b0;
$finish;
end
endmodule