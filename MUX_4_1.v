module MUX_4_1(serial_out_in_MUX, sel, par_bit_MUX, TX_out);
input [1:0] sel; 
input serial_out_in_MUX;
input par_bit_MUX;
output reg TX_out;
always@(*)begin
    case (sel)
        2'b00: TX_out = 1'B0;
        2'b01: TX_out = serial_out_in_MUX;
        2'b10: TX_out = par_bit_MUX;
        2'b11: TX_out = 1'b1; 
        default: TX_out = 1'b1; 
    endcase
end
endmodule
