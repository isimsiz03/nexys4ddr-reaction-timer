module Clock_Divider(
    input clk,
    output reg tick_1ms
    ); 
reg [16:0] counter = 0;

always @(posedge clk)begin
    if(counter == 99999)begin
        counter <= 0;
        tick_1ms <= 1;
    end
    else begin
        counter <= counter+1;
        tick_1ms <= 0;
    end
end
endmodule
