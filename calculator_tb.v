`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Design Name: 
// Module Name: calculator_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module calculator_tb;

reg [7:0] A, B;
reg [2:0] sel;
reg eqlto, reset;

wire [15:0] RESULT;
wire sign_flag;
wire div_by_zero_flag;

calculatorbasic uut(
    .A               (A),
    .B               (B),
    .OPERATION       (sel),
    .eqlto           (eqlto),
    .reset           (reset),
    .RESULT          (RESULT),
    .sign_flag       (sign_flag),
    .div_by_zero_flag(div_by_zero_flag)
);

initial begin

    // initialise
    A=0; B=0; sel=0; eqlto=0; reset=0;

    // reset
    reset=1; #10; reset=0; #10;

    // ========================
    // ADDITION  sel=000
    // ========================
    A=8'd0;   B=8'd0;   sel=3'b000; #10; eqlto=1; #10; eqlto=0; #10;  // 0+0     = 0
    A=8'd3;   B=8'd4;   sel=3'b000; #15; eqlto=1; #10; eqlto=0; #10;  // 3+4     = 7
    A=8'd8;   B=8'd2;   sel=3'b000; #20; eqlto=1; #10; eqlto=0; #10;  // 8+2     = 10
    A=8'd100; B=8'd55;  sel=3'b000; #25; eqlto=1; #10; eqlto=0; #10;  // 100+55  = 155
    A=8'd255; B=8'd255; sel=3'b000; #30; eqlto=1; #10; eqlto=0; #10;  // 255+255 = 510

    // ========================
    // SUBTRACTION  sel=001
    // ========================
    A=8'd9;  B=8'd4;   sel=3'b001; #10; eqlto=1; #10; eqlto=0; #10;  // 9-4    = 5
    A=8'd5;  B=8'd5;   sel=3'b001; #10; eqlto=1; #10; eqlto=0; #10;  // 5-5    = 0
    A=8'd3;  B=8'd7;   sel=3'b001; #10; eqlto=1; #10; eqlto=0; #10;  // 3-7    sign flag
    A=8'd0;  B=8'd1;   sel=3'b001; #10; eqlto=1; #10; eqlto=0; #10;  // 0-1    sign flag  sign flag
    A=8'd1;  B=8'd255; sel=3'b001; #10; eqlto=1; #10; eqlto=0; #10;  // 1-255

    // ========================
    // MULTIPLICATION  sel=010
    // ========================
    A=8'd0;   B=8'd9;   sel=3'b010; #10; eqlto=1; #10; eqlto=0; #10;  // 0*9     = 0
    A=8'd3;   B=8'd4;   sel=3'b010; #10; eqlto=1; #10; eqlto=0; #10;  // 3*4     = 12
    A=8'd15;  B=8'd15;  sel=3'b010; #10; eqlto=1; #10; eqlto=0; #10;  // 15*15   = 225
    A=8'd100; B=8'd100; sel=3'b010; #10; eqlto=1; #10; eqlto=0; #10;  // 100*100 = 10000
    A=8'd255; B=8'd255; sel=3'b010; #10; eqlto=1; #10; eqlto=0; #10;  // 255*255 = 65025

    // ========================
    // DIVISION  sel=011
    // ========================
    A=8'd8;  B=8'd2;  sel=3'b011; #10; eqlto=1; #10; eqlto=0; #10;  // 8/2  = 4
    A=8'd9;  B=8'd3;  sel=3'b011; #10; eqlto=1; #10; eqlto=0; #10;  // 9/3  = 3
    A=8'd7;  B=8'd2;  sel=3'b011; #10; eqlto=1; #10; eqlto=0; #10;  // 7/2  = 3 truncated
    A=8'd5;  B=8'd0;  sel=3'b011; #10; eqlto=1; #10; eqlto=0; #10;  // 5/0  div_by_zero
    A=8'd0;  B=8'd0;  sel=3'b011; #10; eqlto=1; #10; eqlto=0; #10;  // 0/0  div_by_zero

    // ========================
    // AND  sel=100
    // ========================
    A=8'd12;  B=8'd10;  sel=3'b100; #10; eqlto=1; #10; eqlto=0; #10;  // 1100&1010 = 8
    A=8'd15;  B=8'd15;  sel=3'b100; #10; eqlto=1; #10; eqlto=0; #10;  // 1111&1111 = 15
    A=8'd15;  B=8'd0;   sel=3'b100; #10; eqlto=1; #10; eqlto=0; #10;  // 1111&0000 = 0
    A=8'd255; B=8'd170; sel=3'b100; #10; eqlto=1; #10; eqlto=0; #10;  // 11111111&10101010 = 170

    // ========================
    // OR  sel=101
     // ========================
    A=8'd12;  B=8'd10; sel=3'b101; #10; eqlto=1; #10; eqlto=0; #10;  // 1100|1010 = 14
    A=8'd15;  B=8'd0;  sel=3'b101; #10; eqlto=1; #10; eqlto=0; #10;  // 1111|0000 = 15
    A=8'd0;   B=8'd0;  sel=3'b101; #10; eqlto=1; #10; eqlto=0; #10;  // 0000|0000 = 0
    A=8'd255; B=8'd85; sel=3'b101; #10; eqlto=1; #10; eqlto=0; #10;  // 11111111|01010101 = 255

    // ========================
    // XOR  sel=110
    // ========================
    A=8'd12;  B=8'd10; sel=3'b110; #10; eqlto=1; #10; eqlto=0; #10;  // 1100^1010 = 6
    A=8'd15;  B=8'd15; sel=3'b110; #10; eqlto=1; #10; eqlto=0; #10;  // 1111^1111 = 0
    A=8'd9;   B=8'd6;  sel=3'b110; #10; eqlto=1; #10; eqlto=0; #10;  // 1001^0110 = 15
    A=8'd255; B=8'd85; sel=3'b110; #10; eqlto=1; #10; eqlto=0; #10;  // 11111111^01010101 = 170

    // ========================
    // RIGHT SHIFT  sel=111
    // ========================
    A=8'd8;   B=8'd1;  sel=3'b111; #10; eqlto=1; #10; eqlto=0; #10;  // 8>>1   = 4
    A=8'd8;   B=8'd2;  sel=3'b111; #10; eqlto=1; #10; eqlto=0; #10;  // 8>>2   = 2
    A=8'd8;   B=8'd3;  sel=3'b111; #10; eqlto=1; #10; eqlto=0; #10;  // 8>>3   = 1
    A=8'd8;   B=8'd4;  sel=3'b111; #10; eqlto=1; #10; eqlto=0; #10;  // 8>>4   = 0
    A=8'd255; B=8'd1;  sel=3'b111; #10; eqlto=1; #10; eqlto=0; #10;  // 255>>1 = 127
    A=8'd255; B=8'd4;  sel=3'b111; #10; eqlto=1; #10; eqlto=0; #10;  // 255>>4 = 15
    A=8'd255; B=8'd8;  sel=3'b111; #10; eqlto=1; #10; eqlto=0; #10;  // 255>>8 = 0
    A=8'd128; B=8'd7;  sel=3'b111; #10; eqlto=1; #10; eqlto=0; #10;  // 128>>7 = 1

    // ========================
    // RESET TEST
    // ========================
    A=8'd99; B=8'd9; sel=3'b000; #10; eqlto=1; #10; eqlto=0; #10;  // load 108
    reset=1; #10; reset=0; #10;                                      // reset → RESULT=0

    #50;
    $finish;
end

endmodule
