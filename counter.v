module counter
#(
  parameter integer WIDTH=5
 )
 (
  input  wire clk  ,
  input  wire rst  ,
  input  wire load ,
  input  wire enab ,
  input  wire [WIDTH-1:0] cnt_in ,
  output reg  [WIDTH-1:0] cnt_out 
 );

  
//////////////////////////////////////////////////////////////////////////////
//TO DO: DEFINE THE COUNTER COMBINATIONAL LOGIC using FUNCTION AS INSTRUCTED//
//////////////////////////////////////////////////////////////////////////////
function [4:0] cnt_func (
  input rst,load,enab,
  input [4:0] cnt_in,
  input [4:0] cnt_out
);

 begin
 if(rst)
   cnt_func = 'b0;
 else if (load)  
   cnt_func = cnt_in;
 else if (enab)
   cnt_func = cnt_out + 1'b1;
 else
   cnt_func = cnt_out;
 end

endfunction 

  always @(posedge clk)
     cnt_out <= cnt_func (rst, load, enab ,cnt_in, cnt_out); //function call

endmodule

