module Binary_to_BCD(
    input[15:0] binary_in,
    output reg [3:0] binler,
    output reg [3:0] onlar,
    output reg [3:0] yuzler,
    output reg [3:0] birler
);

always @(*)begin
    binler = (binary_in/1000)%10;
    yuzler = (binary_in/100)%10;
    onlar = (binary_in/10)%10;
    birler = (binary_in%10);
    end
endmodule

