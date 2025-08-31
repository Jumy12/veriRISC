module controller(
    input wire zero,
    input wire [2:0] phase,op_code,
    output reg sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e


);

parameter INST_ADDR = 3'b000,
          INST_FETCH = 3'b001,
          INST_LOAD = 3'b010,
          IDLE = 3'b011,
          OP_ADDR = 3'b100,
          OP_FETCH = 3'b101,
          ALU_OP = 3'b110,
          STORE = 3'b111;



always @(*)
begin 
   case (phase)

INST_ADDR:begin
    sel = 1'b1;
    {rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = 8'b00000000;
    end

INST_FETCH:begin
    sel = 1'b1;
    {rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = 8'b10000000;
    end

INST_LOAD:begin
    sel = 1'b1;
    {rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = 8'b11000000;
    end

IDLE:begin
    sel = 1'b1;
    {rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = 8'b11000000;
    end

OP_ADDR:begin
    sel = 1'b0;
    inc_pc = 1'b1;
    {rd,ld_ir,ld_ac,ld_pc,wr,data_e} = 6'b000000;
    if (op_code==3'b000)
      halt = 1'b1;
    else 
      halt = 1'b0;  
    end

OP_FETCH:begin
    sel = 1'b0;
    {ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = 7'b0000000;
    if (op_code==3'b010 || op_code==3'b011 || op_code==3'b100 || op_code==3'b101 )
      rd = 1'b1;
    else 
      rd = 1'b0;  
    end

ALU_OP:begin

    sel = 1'b0;
    {ld_ir, halt, ld_ac, wr} = 4'b0000;
    ld_pc  = (op_code == 3'b111);
    data_e = (op_code == 3'b110);

    if (op_code == 3'b001 && zero) begin
        inc_pc = 1'b1;  // extra increment for SKZ
    end else begin
        inc_pc = 1'b0;
    end

    if (op_code==3'b010 || op_code==3'b011 || op_code==3'b100 || op_code==3'b101)
        rd = 1'b1;
    else
        rd = 1'b0;
end


STORE:begin
    sel = 1'b0;
    {ld_ir,halt,inc_pc} = 3'b000;
    ld_pc  = (op_code == 3'b111);
    data_e = (op_code == 3'b110);
    wr     = (op_code == 3'b110);
    if (op_code==3'b010 || op_code==3'b011 || op_code==3'b100 || op_code==3'b101 )
      {rd,ld_ac} = 2'b11;
    else 
      {rd,ld_ac} = 2'b00;    
    end

   endcase
end


endmodule
