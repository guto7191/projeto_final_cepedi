module mux_write_reg_data (
    input UseImmediate,
    input [7:0] immediate_ext,
    input MemRead,
    input [7:0]ram_data_out,
    input [7:0] alu_result,
    output reg [7:0] write_reg_data
);


/*UseImmediate ? immediate_ext :     // LDC
            MemRead      ? ram_data_out :      // LDA/LDB
            alu_result;   
*/                     
    
    always @(*) begin
        
        if(UseImmediate)begin 
            write_reg_data = immediate_ext;
        end else if(MemRead) begin
            write_reg_data = ram_data_out;
        end else 
            write_reg_data = alu_result;
    end
    


endmodule