module rv_decoder (
    input        [31:0] instr_i,

    output logic [ 4:0] rs_addr_a_o,
    output logic [ 4:0] rs_addr_b_o,

    output logic [31:0] rs_imm_b_o,
    output logic [31:0] rd_imm_o,
    output logic        alu_src_o
);
    assign rd_imm_o = { instr_i[31:12], // 20-bit immediate
                        12'b0 };        // 12-bit zero
    
    assign rs_imm_b_o = { {21{instr_i[31]}},     // 12 bit
                          instr_i[30:20]   };  // 11 bits of 12-bit immediate

    assign rs_addr_a_o = instr_i[19:15];
    assign rs_addr_b_o = instr_i[24:20];


endmodule