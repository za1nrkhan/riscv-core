module rv_ctrl (
    input        [6:0] opcode_i,
    output logic [1:0] alu_op_o
);
    assign alu_op_o = {opcode_i[4], opcode_i[6]};
    
endmodule