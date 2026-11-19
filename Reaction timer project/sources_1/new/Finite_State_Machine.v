module Finite_State_Machine(
    input clk,
    input button_start,
    input button_stop,
    input tick_1ms,
    output reg led_out = 0,
    output reg [15:0] ms_counter = 0,
    output reg loser_code = 0
);

    parameter IDLE = 3'b000, WAITING = 3'b001, COUNTING = 3'b010, END = 3'b011, LOSE = 3'b100;
    parameter seed = 13'd4000;
    reg[2:0] status = IDLE;
    reg[15:0] target_delay = 0;
    reg[15:0] wait_counter = 0;
    reg[12:0] lfsr_out = seed;
    

always @(posedge clk)begin
    case(status)
        LOSE: begin
            loser_code <= 1;                     
            if(button_start == 1)begin
            status <= IDLE;
            end 
        end    
            
        IDLE: begin
            led_out <= 0;
            ms_counter <= 0;
            wait_counter <= 0;
            loser_code <= 0;
            lfsr_out <= {lfsr_out[11:0], lfsr_out[0] ^ lfsr_out[11] ^ lfsr_out[10] ^ lfsr_out[2]};
                                                          
            if(button_start == 1)begin
                target_delay <= lfsr_out ;
                status <= WAITING;
            end
        end        
        WAITING: begin
            if(tick_1ms)begin
                 wait_counter <= wait_counter + 1;
                 if(wait_counter == target_delay)begin
                    led_out <= 1;
                    status <= COUNTING;
                 end
            end
            if(button_stop == 1)begin
                status <= LOSE;
            end
        end
        
        COUNTING: begin
            if(tick_1ms == 1)begin
                ms_counter <= ms_counter + 1;
            end
            if(button_stop == 1)begin
                led_out <= 0;
                status <= END;
            end
        end
        END: begin
            if(button_start == 1)begin
                status <= IDLE;
            end
        end
        default: begin
            status<=IDLE;
        end
   endcase
end
endmodule


            
            
            
            
      
    

        
        
        
            
            
            
    
    
    
 



















