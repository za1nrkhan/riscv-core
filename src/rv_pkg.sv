package rv_pkg;

    typedef enum logic [3:0] {

        // Logical AND and OR
        OP_AND = 4'h0,
        OP_OR  = 4'h1,
        
        // Arthmetic add and subtract
        OP_ADD = 4'h2,
        OP_SUB = 4'h6,

        // Set less than operations
        OP_SLT = 4'h7,

        // Logical NOR
        OP_NOR = 4'hC,

        OP_NOP = 4'hF

    } alu_operations_e;
    
endpackage