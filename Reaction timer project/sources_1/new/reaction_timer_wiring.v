module reaction_timer_wiring(
    input clk,
    input physical_button_start,
    input physical_button_stop,
    output suprise_led,   
    output [7:0] anot,
    output [6:0] katot
      
);
    wire [15:0] millisecond_binary;
    wire w_button_start;
    wire w_button_stop;
    wire w_tick_ms;
    wire w_loser;
    wire [3:0] w_birler;
    wire [3:0] w_onlar;
    wire [3:0] w_yuzler;
    wire [3:0] w_binler; 
    

    Clock_Divider u_metronom(
       .clk(clk),
       .tick_1ms(w_tick_ms)
        );
    
    Button_Debouncer u_button_start(
        .clk(clk),
        .button_in(physical_button_start),
        .button_tick_1ms(w_tick_ms),
        .button_out(w_button_start)
        );
    
    Button_Debouncer u_button_stop(
        .clk(clk),
        .button_in(physical_button_stop),
        .button_tick_1ms(w_tick_ms),
        .button_out(w_button_stop)
        );
    
    Finite_State_Machine u_main_brain(
        .clk(clk),
        .button_start(w_button_start),
        .button_stop(w_button_stop),
        .tick_1ms(w_tick_ms),
        .led_out(suprise_led),
        .ms_counter(millisecond_binary),
        .loser_code(w_loser)
        );
        
    Binary_to_BCD u_decoder(
        .binary_in(millisecond_binary),
        .binler(w_binler),
        .onlar(w_onlar),
        .yuzler(w_yuzler),
        .birler(w_birler)
    );    
    Seven_Segment_Driver u_boss(
        .clk(clk),
        .tick_1ms(w_tick_ms),
        .binler(w_binler),
        .onlar(w_onlar),
        .yuzler(w_yuzler),
        .birler(w_birler), 
        .an(anot),
        .seg(katot),  
        .loser_code(w_loser)
    );
endmodule
