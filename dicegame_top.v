`timescale 1ns / 1ps

module dicegame_top(
    output [6:0] SSEG_CA, // 7-segment cathodes
    output [3:0] SSEG_AN, // 7-segment anodes
    input rb,
    input rst,
    input clk
    );
    
    parameter s0 = 6'b101110;
    //parameter s1 = 3'b111;
    parameter f = 6'b111111;
    
    wire [1:0] res2;
    wire [3:0] sum;
    wire [2:0] x0;
    wire [2:0] x1;
    wire [5:0] x;
    
    assign x0 = (x[2:0] % 6) + 1'b1;
    assign x1 = (x[5:3] % 6) + 1'b1;
    
    dicegame_ctrl dg(rb, rst, cout, sum, roll, win, lose); 
    sseg sseg(SSEG_CA, SSEG_AN, res2, x0, x1, clk, rst);
    clock_divider clkdiv(cout, clk);
    lfsr lfsr0(x, s0, f, rst, cout, rb);
    //lfsr lfsr1(x1, s1, f, rst, cout, rb);
    result res(sum, res2, win, lose, roll, clk, rst, x0, x1);
    
endmodule
