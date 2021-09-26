module rv_ctrl (
    input        [6:0] opcode_i,
    output logic [1:0] alu_op_o,
    output logic       branch_o,
    output logic       alu_src_o,
    output logic       rd_we_o,
    output logic       alu_dst_o
);
    assign alu_op_o = {opcode_i[4], opcode_i[6]};
    assign branch_o = opcode_i[6];

    assign alu_src_o = ~(opcode_i[6] | (opcode_i[5] & opcode_i[4]));
    
    assign rd_we_o = (~opcode_i[6]) & ( ~( opcode_i[5] | opcode_i[2] ) | ( opcode_i[5] & opcode_i[4] ) );
    
    assign alu_dst_o = opcode_i[2];

endmodule