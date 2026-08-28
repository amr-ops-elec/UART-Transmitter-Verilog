module serializer (p_in, v_in, sht_en, clk, rst, serial_out);
parameter N = 8;
input [N-1:0]p_in;
input v_in,sht_en, clk, rst;
output wire serial_out;
reg [N-1:0]sht_reg;
always@(posedge clk or negedge rst)
begin
if(!rst) begin
    sht_reg <= {N{1'b0}};
end 
else if(v_in) begin
    sht_reg <= p_in;
    end
else if(sht_en)begin
    sht_reg <= {1'b0, sht_reg[N-1:1]};
end
end
assign serial_out = sht_reg[0];
endmodule
