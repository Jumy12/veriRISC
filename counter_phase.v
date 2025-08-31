module counter_phase (
    input wire clk,rst,
    output reg [2:0] count
);

always @(posedge clk)
 begin 
    if(rst)
    count <= 'b0;
    else
    count <= count + 1;
 end 

endmodule