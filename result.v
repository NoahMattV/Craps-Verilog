`timescale 1ns / 1ps

module result(
    output reg [3:0] sum,
    output reg [1:0] result,
    input win, 
    input lose,
    input roll,
    input clock,
    input reset,
    input [2:0] x0,
    input [2:0] x1
    );
    
    reg [2:0] find; // used to concatenate win, lose, and roll into one register. 
        
    initial begin
    find <= 0;
    end
    
    always @(*) begin
        sum = x0 + x1;
    end
    
    always @(posedge clock) begin
        
        if (reset)
            find <= 0;
        else begin
        find = {win, lose, roll};
        
        case(find) // converts one-hot into normal binary counting
        3'b001: result = 2'b10;  // roll
        3'b010: result = 2'b01;  // lose
        3'b100: result = 2'b00;  // win
        3'b000: result = 2'b11;  // explicitly stating reset
        default: result = 2'b11; // reset
        endcase
        end // else
    end
    
endmodule
