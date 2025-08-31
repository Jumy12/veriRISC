module mux #(parameter data_width =5) 
(
    input wire [data_width-1:0] in0,
    input wire [data_width-1:0] in1,
    input wire sel,
    output wire [data_width-1:0] mux_out


);

assign mux_out = (sel) ? in1 : in0 ;

endmodule


