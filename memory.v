module memory #(parameter AWIDTH = 5 , DWIDTH =8)
( 
    input wire [AWIDTH-1:0] ADDR,
    input wire CLK,wr,rd,
    inout wire [DWIDTH-1:0] data

);

reg [DWIDTH-1:0] array [31:0];
//write
always @(posedge CLK)
  begin
  if (wr)
  array[ADDR] <= data;
  end

//read
assign data = (rd) ? array[ADDR] : {DWIDTH{1'bz}}; 

endmodule      