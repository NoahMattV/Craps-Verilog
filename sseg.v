`timescale 1ns / 1ps

module sseg(
    output reg [6:0] disp_num, //sseg_ca
    output reg [3:0] an, //sseg_an
    input [1:0] result, // 00 == win, 01 == lose, 10 == again, 11 == reset
    input [2:0] x0, 
    input [2:0] x1, 
    input clk,
    input clr
    );
    
wire [1:0] s;	 
reg [3:0] digit;   // 1-6, U, L, A 
wire [3:0] aen;
reg [19:0] clkdiv; // Makes a psuedoclock that is 20 bits long.
wire [3:0] lego;


   // These parameters define which segements of the displays are on.
   // To make a number, AND each parameter that needs to be on.  
   parameter a = 7'b1111110;
   parameter b = 7'b1111101;
   parameter c = 7'b1111011;
   parameter d = 7'b1110111;
   parameter e = 7'b1101111;
   parameter f = 7'b1011111;
   parameter g = 7'b0111111;
   parameter off = 7'b1111111; // display is OFF
   
assign s = clkdiv[19:18]; // The clock is defined to be 20 bits. By only counting the two MSBs, the clock updates slower.
assign aen = 4'b1111; // all turned off initially
assign lego = result + 3'b111; // adds 2-bit result input with 7 so that it will display U, L, A, or 0

// Based on cycle of s, the display is chosen. s is cycled in code near clock divider at bottom
always @(posedge clk)
        
	case(s)
	0: digit = x0;       // first die
    1: digit = x1;     // second die
    2: digit = off;    // always OFF
    3: digit = lego;   // result is a number between 0 and 3. Add 7 to get corresponding display.
	default: digit = 3;
	endcase

// Choose number to display
always @(*) 
case(digit)
            
0:disp_num = a&b&c&d&e&f;  // 0			
1:disp_num = b&c;							
2:disp_num = a&b&g&e&d;                                                             
3:disp_num = a&b&g&c&d;
4:disp_num = f&g&b&c;												 
5:disp_num = a&f&g&c&d;
6:disp_num = a&f&g&c&d&e;
7:disp_num = b&c&d&e&f;    // U
8:disp_num = f&e&d;        // L
9:disp_num = e&f&a&g&b&c;  // A
10:disp_num = a&b&c&d&e&f; // 0
default: disp_num = off;   // off
endcase

// Cycles through four displays
always @(*)
begin
an=4'b1111;
if(aen[s] == 1) // always true. Should be able to get rid of this.
    an[s] = 0;
end


// Divides clock to roughly 100 Hz
always @(posedge clk or posedge clr) 
begin
if (clr == 1)
clkdiv <= 0;
else
clkdiv <= clkdiv+1;
end

endmodule
