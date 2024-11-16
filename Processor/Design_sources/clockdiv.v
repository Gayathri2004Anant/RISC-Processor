module clockdiv (
    input clk,
    input rst,
    output reg clkslow
);
    reg [31:0] counter;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            clkslow <= 0;
        end else begin
            counter <= counter + 1;
            if (counter == 32'd10000000) begin // Adjust for desired frequency
                clkslow <= ~clkslow;
                counter <= 0;
            end
        end
    end
endmodule