module register #(parameter WIDTH = 8)

(
   input wire [WIDTH-1:0] data_in,
   input wire load,CLK,RST,
   output reg [WIDTH-1:0] data_out

);

always @(posedge CLK)
   begin
    if(RST) begin
          data_out <= 'b0;
    end 
    else if (load) begin 
          data_out <= data_in ; 
    end       
    else begin
          data_out <= data_out ;  
    end       

   end 

endmodule
