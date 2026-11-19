module Button_Debouncer(
    input clk,
    input button_in,
    input button_tick_1ms,
    output reg button_out = 0 
);
    reg [3:0] counter = 0;

    always @(posedge clk) begin 
            if (counter == 0) begin
                button_out <= button_in;
                           
                if (button_in != button_out) begin
                    counter <= 1; 
                end
            end
            else begin
                if(button_tick_1ms) begin
                    counter <= counter + 1; 
             
                    if (counter == 11) begin
                    counter <= 0; 
                
                    end
                end
            end
    end       
endmodule