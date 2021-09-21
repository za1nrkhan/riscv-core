module rv_alu import rv_pkg::*; (
    input  alu_operations_e alu_ctrl_i, 
    input        [31:0]     operand_a_i,
    input        [31:0]     operand_b_i,
    output logic [31:0]     result_o,
    output logic            zero_o
);
    
    assign zero_o = (result_o == 32'b0);
    always @(alu_ctrl_i, operand_a_i, operand_b_i) begin
        case (alu_ctrl_i)
            OP_AND: result_o = operand_a_i & operand_b_i;
            OP_OR : result_o = operand_a_i | operand_b_i;
            OP_ADD: result_o = operand_a_i + operand_b_i;
            OP_SUB: result_o = operand_a_i - operand_b_i;
            OP_SLT: result_o = operand_a_i < operand_b_i ? 1:0;
            OP_NOR: result_o = ~(operand_a_i | operand_b_i);
            default: result_o = 0;
        endcase
    end
endmodule