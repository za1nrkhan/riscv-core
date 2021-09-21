module alu_tb;
    import rv_pkg::*;
    alu_operations_e alu_ctrl_i;
    logic [31:0]     operand_a_i;
    logic [31:0]     operand_b_i;
    logic [31:0]     result_o;
    logic            zero_o;

    rv_alu dut (
        .alu_ctrl_i  (  alu_ctrl_i ),
        .operand_a_i ( operand_a_i ),
        .operand_b_i ( operand_b_i ),
        .result_o    (    result_o ),
        .zero_o      (      zero_o )
    );

    task expect_values( 
        input [31:0] result_e, 
        input        zero_e
    );
        begin

            $display( "time=%0d ns alu_ctrl=%0s operand_a=%d operand_b=%d result=%d zero=%b", 
                        $time, 
                        alu_ctrl_i.name(), 
                        operand_a_i,
                        operand_b_i,
                        result_o, zero_o);

            if ( result_o !== result_e ) begin
                if ( zero_o !== zero_e )
                    $display ( "WANT:             result=%d zero=%b", result_e, zero_e );
                else
                    $display ( "WANT:             result=%d", result_e );
                $display ( "TEST FAILED" ) ;
                $finish;
            end else if ( zero_o !== zero_e ) begin
                $display ( "WANT:             zero=%b", zero_e );
                $display ( "TEST FAILED" ) ;
                $finish;
            end
        end
    endtask

    initial begin
        alu_ctrl_i=OP_ADD; operand_a_i=32'd5; operand_b_i=32'd38; #1; expect_values( 32'd43, 1'b0 );
        #1 ;
        $display ( "TEST PASSED" ) ;
        $finish;
    end
endmodule