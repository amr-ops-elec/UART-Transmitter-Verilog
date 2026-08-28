`timescale 1ns / 1ps
module FSM_tb();
reg clk_tb, rst_tb, valid_en_tb, par_en_tb;
wire [1:0]mux_sel_tb;
wire sht_en_tb, busy_tb;
FSM dut(.clk(clk_tb), .rst(rst_tb), .valid_en(valid_en_tb), .par_en(par_en_tb),
.mux_sel(mux_sel_tb), .sht_en(sht_en_tb), .busy(busy_tb));
initial begin
    clk_tb <= 1'b0;
    forever begin
        #5 clk_tb <= ~clk_tb;
    end
end
initial begin
    $monitor("Time=%0t | rst=%b | valid_en=%b | par_en=%b | state=%0d | mux_sel=%b | shift_en=%b | busy=%b",
    $time, rst_tb, valid_en_tb, par_en_tb, dut.current_state, mux_sel_tb, sht_en_tb, busy_tb);    
    rst_tb = 1'b0;
    valid_en_tb = 1'b0;
    par_en_tb = 1'b0;
    #15;
    @(negedge clk_tb);
    rst_tb = 1'b1;
    $display("\n___ scenario 1 ___"); 
    @(negedge clk_tb);
    valid_en_tb = 1'b1;
    par_en_tb = 1'b1;
    @(negedge clk_tb);
    valid_en_tb = 1'b0;
    repeat (12) @(negedge clk_tb);
    $display("\n___ scenario 2 ___"); 
    @(negedge clk_tb);
    valid_en_tb = 1'b1;
    par_en_tb = 1'b0;
    @(negedge clk_tb);
    valid_en_tb = 1'b0;
    repeat(11) @(negedge clk_tb);
    #20
     $finish;
end
    
endmodule
