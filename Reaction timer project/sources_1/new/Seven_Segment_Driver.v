module Seven_Segment_Driver (
    input clk,
    input tick_1ms,          
    input [3:0] binler,      
    input [3:0] yuzler,
    input [3:0] onlar,
    input [3:0] birler,
    input loser_code,    
    output reg [7:0] an,     
    output reg [6:0] seg     
);
    
    parameter EEE = 2'b00, SSS = 2'b01, OOO = 2'b10, LLL = 2'b11;
    reg [1:0] hane_secici = 0;
    reg [3:0] aktif_rakam = 0;
    reg [1:0] aktif_harf = LLL;
    
  
    always @(posedge clk) begin
        if (tick_1ms) begin
            hane_secici <= hane_secici + 1;
        end
    end
       
    always @(*) begin
        if(loser_code == 0)begin
            case(hane_secici)
                2'b00: begin an = 8'b11111110; 
                aktif_rakam = birler; end
                2'b01: begin an = 8'b11111101; 
                aktif_rakam = onlar;  end
                2'b10: begin an = 8'b11111011; 
                aktif_rakam = yuzler; end
                2'b11: begin an = 8'b11110111; 
                aktif_rakam = binler; end
            endcase
         end
        else if (loser_code == 1) begin
            case(hane_secici)
                2'b00: begin an = 8'b11111110; 
                aktif_harf = EEE; end
                2'b01: begin an = 8'b11111101; 
                aktif_harf = SSS;  end
                2'b10: begin an = 8'b11111011; 
                aktif_harf = OOO; end
                2'b11: begin an = 8'b11110111; 
                aktif_harf = LLL; end
            endcase
         end
    end

    always @(*) begin
        if(loser_code == 0)begin
            case(aktif_rakam)   
                4'd0: seg = 7'b1000000;
                4'd1: seg = 7'b1111001;
                4'd2: seg = 7'b0100100;
                4'd3: seg = 7'b0110000;
                4'd4: seg = 7'b0011001;
                4'd5: seg = 7'b0010010;
                4'd6: seg = 7'b0000010;
                4'd7: seg = 7'b1111000;
                4'd8: seg = 7'b0000000;
                4'd9: seg = 7'b0010000;        
                default: seg = 7'b1111111;
            endcase
         end
         else if (loser_code == 1)begin         
            case(aktif_harf)   
                    EEE: seg = 7'b0000110;
                    SSS: seg = 7'b0010010;
                    OOO: seg = 7'b1000000;
                    LLL: seg = 7'b1000111;
                    default: seg = 7'b1111111;
            endcase 
          end  
        end
endmodule

