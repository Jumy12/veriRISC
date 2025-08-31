module TOP_module #(parameter width_1 = 8)
 (
    input wire clk,rst,
    output wire halt


    
);

wire ld_ac,ld_ir,inc_pc,ld_pc;
wire [width_1-1:0] alu_out,data;
wire [width_1-1:0] ac_out;
wire [4:0] ir_addr;
wire [2:0] opcode,phase;
wire zero;
wire [4:0] pc_addr;
wire rd,wr,sel,data_e;
wire [width_1-1:0] data_o;
wire [4:0] addr;
assign ir_addr = data_o[4:0];
assign opcode = data_o[7:5];


register #(.WIDTH(8))  REG_AC(
    .CLK(clk),
    .RST(rst),
    .load(ld_ac),
    .data_in(alu_out),
    .data_out(ac_out)
);

register #(.WIDTH(8))  REG_IR(
    .CLK(clk),
    .RST(rst),
    .load(ld_ir),
    .data_in(data),
    .data_out(data_o)
);

ddriver #(.data_in_width(8)) driver_inst(
    .data_en(data_e),  //modification
    .data_in(alu_out),
    .data_out(data)
);

alu #(.WIDTH(8)) alu_inst(
    .in_a(ac_out),
    .in_b(data),
    .op_code(opcode),
    .alu_out(alu_out),
    .a_is_zero(zero)
);

counter #(.WIDTH(5)) counter_pc(
    .clk(clk),
    .rst(rst),
    .enab(inc_pc),
    .load(ld_pc),
    .cnt_in(ir_addr),
    .cnt_out(pc_addr)
);

controller controller_inst(
    .op_code(opcode),
    .zero(zero),
    .phase(phase),
    .sel(sel),
    .rd(rd),
    .ld_ir(ld_ir),
    .halt(halt),
    .inc_pc(inc_pc),
    .ld_ac(ld_ac),
    .ld_pc(ld_pc),
    .wr(wr),
    .data_e(data_e)
);

memory #(.AWIDTH(5), .DWIDTH(8)) memory_inst (
    .CLK(clk),
    .ADDR(addr),
    .wr(wr),
    .rd(rd),
    .data(data)
);

mux #(.data_width(5)) addr_mux(
    .in0(ir_addr),
    .in1(pc_addr),
    .sel(sel),
    .mux_out(addr)
);

counter_phase phase_gen (
    .clk(clk),
    .rst(rst),
    .count(phase)
);

endmodule
