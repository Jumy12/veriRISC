module alu #(parameter WIDTH =8)
(
    input wire [WIDTH-1:0] in_a,in_b,
    input wire [2:0] op_code,
    output reg [WIDTH-1:0] alu_out,
    output wire a_is_zero



);
assign a_is_zero = (in_a == 'b0) ? 1'b1 : 1'b0;

always @(*) 
begin
    case (op_code)
    3'b000 : begin 
        alu_out = in_a;
    end
    3'b001 : begin 
        alu_out = in_a;
    end
    3'b010 : begin 
        alu_out = in_a + in_b;
    end
    3'b011 : begin 
        alu_out = in_a & in_b;
    end
    3'b100 : begin 
        alu_out = in_a ^ in_b;
    end
    3'b101 : begin 
        alu_out = in_b;
    end
    3'b110 : begin 
        alu_out = in_a;
    end
    3'b111 : begin 
        alu_out = in_a;
    end    




    endcase
end   

endmodule