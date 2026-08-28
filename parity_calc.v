module parity_calc(PARITY_EO, par_calc, p_in);
parameter N = 8;
input PARITY_EO;
input [N-1:0]p_in;
output reg par_calc;
always@(*)begin
    if(!PARITY_EO)begin
        par_calc = ^p_in;
    end
    else begin
         par_calc = ~^p_in;
    end
end 
endmodule
