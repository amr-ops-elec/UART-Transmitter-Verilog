module FSM(clk, rst, valid_en, par_en, mux_sel, sht_en, busy);
parameter N = 8;
input clk, rst, valid_en, par_en;
output reg [1:0]mux_sel;
output reg sht_en, busy;
localparam [2:0]idle = 3'b000,
                start = 3'b001,
                data_in = 3'b010,
                parity = 3'b011,
                stop = 3'b100;
reg [2:0] current_state, next_state;
reg [4:0] count;
always@(posedge clk or negedge rst) begin
    if(!rst) begin
        current_state <= idle;
        count <= 3'b000;
    end
    else begin
        current_state <= next_state;
        if(current_state == data_in)begin
            count <= count + 1'b1;
        end
        else begin
            count <= 5'b000_00;
        end
    end
end
always@(*)begin
    case (current_state)
        idle: if(valid_en)begin
            next_state = start;
        end
        else begin
            next_state = idle;
        end
        start: next_state = data_in;
        data_in: begin
                if(count == N - 1)begin
                if(par_en)begin
                    next_state = parity;
                end
                else begin
                    next_state = stop;
                end
            end
            else begin
                next_state = data_in;
            end
        end
        parity: next_state = stop;
        stop: next_state = idle; 
        default: next_state = idle;
    endcase
end
always @(*) begin
    mux_sel = 2'b11;
    sht_en = 1'b0;
    busy = 1'b1;
    case(current_state)
        idle: begin
            mux_sel = 2'b11;
            busy = 1'b0;
        end
        start: begin
            mux_sel = 2'b00;
            busy = 1'b1;
        end
        data_in: begin
            mux_sel = 2'b01;
            busy = 1'b1;
            sht_en = 1'b1;
        end
        parity: begin
            mux_sel = 2'b10;
        end
        stop: begin
            mux_sel = 2'b11;
            busy = 1'b0;
            sht_en = 1'b0;
        end
        default: begin
            mux_sel = 2'b11;
            busy = 1'b1;
            sht_en = 1'b0;       
        end
        
    endcase
end
endmodule 
