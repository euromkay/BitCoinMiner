/*  Simple Core
 *  
 *  Description: A simple CPU core that does not write to the register file.
 *  
 *  Notes:
 *      None.
 *
 *  Revision History:
 *      sokai       01/19/2016  1) Initial revision.
 *
 */
 
import simple_definitions::*;

module simple_core (
        input clk,                          // Clock
        input n_reset,                      // Active low reset
        output logic [31:0] alu_result_o,   // ALU result
        output logic alu_result_valid_o,    // ALU result is valid flag
        output logic stop_o                 // Stop execution flag
    );
    
    logic [2:0] pc;
    const int MAX_PC = 7;
    
    instruction_s instruction_pre, instruction_post, instruction_post2;
    logic rf_wen = 0;           // This core does not modify the reg file, no feedback.
    logic [31:0] rd_val_post, rd_val_pre;
    logic [31:0] rs_val_post, rs_val_pre;
    logic [31:0] alu_result;
    logic stop;
    
    always_ff @(posedge clk)
        begin
        // Clear PC on reset.
        if (!n_reset)
            begin
            pc <= 0;
            end
        // Increment PC unless it has reached its max value.
        else if (pc != MAX_PC)
            begin
            pc <= pc + 1;
        end
        rd_val_post <= rd_val_pre;
        rs_val_post <= rs_val_pre;
    end // always_ff
    
    // Instruction memory
    simple_imem imem (
        .clk(clk),
        .n_reset(n_reset),
        .addr_i(pc),
        .instruction(instruction_pre)
    );
    
    // Register file
    simple_reg_file rf (
        .clk(clk),
        .rs_addr_i(instruction_post.rs),
        .rd_addr_i(instruction_post.rd),
        .rs_val_o(rs_val_pre),
        .rd_val_o(rd_val_pre)
    );
    
    // ALU
    simple_alu alu (
        .rd_i(rd_val_post),
        .rs_i(rs_val_post),
        .op_i(instruction_post2),
        .writes_rf_o(alu_result_valid),
        .result_o(alu_result),
        .stop_o(stop)
    );
    
    always_ff @(posedge clk)
        begin
        if (!n_reset) 
            begin
            end
        else
            begin
            alu_result_o <= alu_result;
            alu_result_valid_o <= alu_result_valid;
            stop_o <= stop;
        end
        instruction_post <= instruction_pre;
        instruction_post2 <= instruction_post;
    end
    
endmodule
