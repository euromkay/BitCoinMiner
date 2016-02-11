//This is the ALU module of the core, op_code_e is defined in definitions.v file
import definitions::*;

module alu (
        input  [31:0] rd_i,
        input  [31:0] rs_i, 
        input  instruction_s op_i,
        output logic [31:0] result_o,
        output logic jump_now_o
    );

    op_mne op_mnemonic;

    always_comb
        begin
        result_o   = 32'd0; 
        jump_now_o = 1'b0; 
    
        unique casez (op_i)
            kADDU:  result_o   = rd_i +  rs_i;
            kSUBU:  result_o   = rd_i -  rs_i;
            kSLLV:  result_o   = rd_i << rs_i[4:0];
            kSRAV:  result_o   = $signed (rd_i)   >>> rs_i[4:0];
            kSRLV:  result_o   = $unsigned (rd_i) >>  rs_i[4:0];
            kROL:   result_o   = (rd_i << rs_i[4:0]) | (rd_i >> (~rs_i[4:0] + 5'd1));
            kROR:   result_o   = (rd_i >> rs_i[4:0]) | (rd_i << ((~rs_i[4:0]) + 5'd1));
            kXOR:   result_o   = rd_i ^ rs_i;
            kAND:   result_o   = rd_i & rs_i;
            kOR:    result_o   = rd_i | rs_i;
            kNOR:   result_o   = ~ (rd_i|rs_i);
            
            //s7(x) + s18(x) + r3(x)
            kLA:    result_o   = ((rs_i >> 32'd7 ) | (rs_i << 32'd25)) ^ ((rs_i >> 32'd18) | (rs_i << 32'd14)) ^ (rs_i >> 32'd3);
            //s17(x) + s19(x) + r10(x)
            kLB:    result_o   = ((rs_i >> 32'd17) | (rs_i << 32'd15)) ^ ((rs_i >> 32'd19) | (rs_i << 32'd13)) ^ (rs_i >> 32'd10);

            //s17(x) + s19(x) + r10(x)
            //kBA:    result_o   = ((rd_i >> 32'd17) | (rd_i << 32'd15)) ^ ((rd_i >> 32'd19) | (rd_i << 32'd13)) ^ ((rd_i >> 32'd19) | (rd_i << 32'd13));
            
            kSLT:   result_o   = ($signed(rd_i)<$signed(rs_i))     ? 32'd1 : 32'd0;
            kSLTU:  result_o   = ($unsigned(rd_i)<$unsigned(rs_i)) ? 32'd1 : 32'd0;
            kBEQZ:  jump_now_o = (rd_i==32'd0)                     ? 1'b1  : 1'b0;
            kBNEQZ: jump_now_o = (rd_i!=32'd0)                     ? 1'b1  : 1'b0;
            kBGTZ:  jump_now_o = ($signed(rd_i)>$signed(32'd0))    ? 1'b1  : 1'b0;
            kBLTZ:  jump_now_o = ($signed(rd_i)<$signed(32'd0))    ? 1'b1  : 1'b0;
            
            kMOV, kLW, kLBU, kJALR, kBAR:  
                begin
                result_o   = rs_i;
            end
            
            kSW, kSB:
                begin
                result_o   = rd_i;
            end
            
            default: 
                begin 
                result_o   = 32'd0; 
                jump_now_o = 1'b0; 
            end
        endcase
    
        // Set symbolic opcode
        op_mnemonic = op_mne'(op_i.opcode);
        if (op_i ==? kBAR)
            begin
            op_mnemonic = BARR;
            end
        else if ((op_i.opcode == 0) && (rd_i == 0) && (rs_i == 0))
            begin
            op_mnemonic = NOP;
        end
    
    end // always_comb
    
endmodule 
