`timescale 1ns / 1ps

// LFSR = Linear-Feedback Shift Register

module lfsr(output reg [5:0]q, 
            input [5:0]seed, 
            input [5:0]feedback,
            input rst, 
            input clock,
            input rb
            );
            
//   reg [2:0]q;
   
    initial begin
        q[0] <= seed[0]; 
        q[1] <= seed[1];
        q[2] <= seed[2];
        q[3] <= seed[3];
        q[4] <= seed[4];
        q[5] <= seed[5];
    end
            
//    always @(*) begin // keeps the output a value between 1 and 6 (3'b001 adn 3'b110)
//    x <= (q % 3'b110) + 1'b1;
//    end
            
    assign din = (q[0]&feedback[0])^(q[1]&feedback[1])^(q[2]&feedback[2])^(q[3]&feedback[3])^(q[4]&feedback[4])^(q[5]&feedback[5]);

    always @(posedge clock)
        begin // shifts the values sequentally
            // Shift register
            if (rst)
            begin
                q[0] <= seed[0];
                q[1] <= seed[1];
                q[2] <= seed[2];
                q[3] <= seed[3];
                q[4] <= seed[4];
                q[5] <= seed[5];
            end
            
            else if (rb)
            begin
                q[5] <= q[4];
                q[4] <= q[3];
                q[3] <= q[2];
                q[2] <= q[1];
                q[1] <= q[0];
                q[0] <= din; 
            end
            
            else 
            begin
                q[5] <= q[5];
                q[4] <= q[4];
                q[3] <= q[3];
                q[2] <= q[2];
                q[1] <= q[1];
                q[0] <= q[0];
            end
        end
        
endmodule
