module rv_decoder (
    input        [31:0] instr_i,

    output logic [ 4:0] rs_addr_a_o,
    output logic [ 4:0] rs_addr_b_o,
    output logic [ 4:0] rd_addr_o,

    output logic [31:0] rs_imm_b_o,
    output logic [31:0] rd_imm_o,
    output logic        alu_src_o,

    output rv_pkg::alu_operations_e alu_ctrl_o,

    output logic        rd_we_o,

    output logic [31:0] branch_target_o,
    output logic        branch_o,

    output logic [ 1:0] alu_dst_o,
    output logic        data_we_o
);
    import rv_pkg::*;

    assign rd_imm_o = { instr_i[31:12], // 20-bit immediate
                        12'b0 };        // 12-bit zero
    
    assign rs_imm_b_o = { {21{instr_i[31]}}, // 12 bit
                          instr_i[30:25], 
                          data_we_o ? rd_addr_o : rs_addr_b_o };  // 11 bits of 12-bit immediate

    assign branch_target_o = { {20{instr_i[31]}}, 
                                instr_i[7], instr_i[30:25], 
                                instr_i[11:8], 1'b0};

    assign rs_addr_a_o = instr_i[19:15];
    assign rs_addr_b_o = instr_i[24:20];

    assign rd_addr_o   = instr_i[11:7];

    logic [1:0] alu_op;
    logic [3:0] alu_ctrl_d; // not to be mixed with flop input of alu_ctrl_o

    assign alu_ctrl_d = {instr_i[30], instr_i[14:12]};

    logic [5:0] alu_case;
    assign alu_case = {alu_op, alu_ctrl_d};

    rv_ctrl u_rv_ctrl(
        .opcode_i ( instr_i[6:0] ),
        .alu_op_o (  alu_op      ),
        .branch_o ( branch_o     ),
        .alu_src_o ( alu_src_o   ),
        .rd_we_o  ( rd_we_o      ),
        .alu_dst_o ( alu_dst_o   ),
        .data_we_o ( data_we_o   )
    );

    // ALU Control
    //          alu_op[1]   alu_op[0]   alu_ctrl_d[3]   alu_ctrl_d[2]   alu_ctrl_d[1]   alu_ctrl_d[0]   alu_ctrl_o
    // lw,sw  |     0     |     0     |       -       |       0       |       0       |       0       |  OP_ADD
    // beq    |     0     |     1     |       -       |       0       |       0       |       0       |  OP_SUB
    // add    |     1     |     0     |       0       |       0       |       0       |       0       |  OP_ADD
    // sub    |     1     |     0     |       1       |       0       |       0       |       0       |  OP_SUB 101000 instr_i[5] = 1
    // and    |     1     |     0     |       0       |       1       |       1       |       1       |  OP_AND
    // or     |     1     |     0     |       0       |       1       |       1       |       0       |  OP_OR
    // addi   |     1     |     0     |       -       |       0       |       0       |       0       |  OP_ADD 10x000 instr_i[5] = 0
     
    always @(*) begin
        unique casex (alu_case)
            6'b00????: alu_ctrl_o = OP_ADD;
            6'b?1????: alu_ctrl_o = OP_SUB;
            6'b1?0000: alu_ctrl_o = OP_ADD;
            6'b1??000: begin
                if (instr_i[5]) begin
                    alu_ctrl_o = OP_SUB;
                end else begin
                    alu_ctrl_o = OP_ADD;
                end           
            end
            6'b1?0111: alu_ctrl_o = OP_AND;
            6'b1?0110: alu_ctrl_o = OP_OR;
            default:   alu_ctrl_o = OP_NOP;
        endcase
    end
    
endmodule