`timescale 1ns / 1ps

// This program divides the clock so that the output is 1Hz
// as opposed to the 100 MHz native clock time

module clock_divider(cout, cin);

    input cin;
    output cout; // the new divided clock
    
    parameter timeconst = 70; // constant. Used for dividing clock 84 is 1 Hz
    integer count0;
    integer count1;
    integer count2;
    integer count3;
    reg d; // this is the output clock variable
    reg cout;
    
        initial begin
            count0=0;
            count1=0;
            count2=0;
            count3=0;
            d = 0;
        end
        
    always @ (posedge cin ) // splits the count into 4 parts
        begin
            count0 <= (count0 + 1); 
            
            if ((count0 == timeconst))
                begin
                    count0 <= 0;
                    count1 <= (count1 + 1);
                end
        
            else if ((count1 == timeconst))
                begin
                    count1 <= 0;
                    count2 <= (count2 + 1);
                end    
            
            else if ((count2 == timeconst))
                begin
                    count2 <= 0;
                    count3 <= (count3 + 1);
                end
                
            else if ((count3 == timeconst))
                begin
                    count3 <= 0;
                    d <= ~ (d);
                end
                    
            cout <= d;
        
        end // end always

endmodule
