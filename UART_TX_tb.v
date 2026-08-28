`timescale 1ns/1ps
module UART_TX_tb ();
localparam N = 8;
reg [N-1:0]p_in_tb;
reg valid_en_tb, clk_tb, rst_tb, par_en_tb, par_bit_tb;
wire TX_out_tb, busy_tb;
UART_TX dut(.p_in(p_in_tb), .valid_en(valid_en_tb), .clk(clk_tb), .rst(rst_tb), .par_en(par_en_tb), .par_bit(par_bit_tb),
 .TX_out(TX_out_tb), .busy(busy_tb));
initial begin
    clk_tb = 1'B0;
    forever begin
        #5 clk_tb = ~clk_tb; 
    end
end
initial begin
    $monitor("TIME=%0t | p_in=%b , valid_en=%b , par_en=%b , par_bit=%b | TX_out=%b , busy=%b", $time , p_in_tb,
    valid_en_tb, par_en_tb, par_bit_tb, TX_out_tb, busy_tb);

    rst_tb = 1'b0;
    valid_en_tb = 1'b0;
    par_en_tb = 1'b0;
    par_bit_tb = 1'b0;
    p_in_tb = 8'b0;
    #15;
    @(negedge clk_tb);
    rst_tb = 1'b1;
    $display("\n___ scenario 1 ___"); 
    @(negedge clk_tb);
    p_in_tb = 8'b1010_0110;
    valid_en_tb = 1'b1;
    par_en_tb = 1'b1;
    par_bit_tb = 1'b0;
    @(negedge clk_tb);
    valid_en_tb = 1'b0;
    repeat (12) @(negedge clk_tb);
    $display("\n___ scenario 2 ___");
    @(negedge clk_tb);
    p_in_tb = 8'b1010_0100;
    valid_en_tb = 1'b1;
    par_en_tb = 1'b1;
    par_bit_tb = 1'b1;
    @(negedge clk_tb);
    valid_en_tb = 1'b0;
    repeat (12) @(negedge clk_tb);
    $display("\n___ scenario 3 ___");
    @(negedge clk_tb);
    p_in_tb = 8'b1011_0010;
    valid_en_tb = 1'b1;
    par_en_tb = 1'b0;
    par_bit_tb = 1'b0;
    @(negedge clk_tb);
    valid_en_tb = 1'b0;
    repeat (11) @(negedge clk_tb);
    $finish;
end
endmodule