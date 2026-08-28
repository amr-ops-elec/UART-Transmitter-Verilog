module UART_TX (p_in, valid_en, clk, rst, par_en, par_bit, TX_out, busy);
parameter N = 8;
input [N-1:0]p_in;
input valid_en, clk, rst, par_en, par_bit;
output TX_out, busy;
wire sht_en;
wire [1:0] mux_sel;
wire serial_out;
wire par_calc;
serializer ser_dut(.p_in(p_in), .v_in(valid_en), .sht_en(sht_en), .clk(clk), .rst(rst), .serial_out(serial_out));
FSM FSM_dut(.clk(clk), .rst(rst), .valid_en(valid_en), .par_en(par_en), .mux_sel(mux_sel), .sht_en(sht_en), .busy(busy));
parity_calc par_dut(.PARITY_EO(par_bit), .par_calc(par_calc), .p_in(p_in));
MUX_4_1 mux_dut(.serial_out_in_MUX(serial_out), .sel(mux_sel), .par_bit_MUX(par_calc), .TX_out(TX_out));    
endmodule
