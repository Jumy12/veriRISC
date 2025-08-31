module ddriver #(parameter data_in_width =8 )
(
    input wire data_en,
    input wire [data_in_width-1:0] data_in,
    output wire [data_in_width-1:0] data_out

);

assign data_out = (data_en) ? data_in : 'bZ ;

endmodule