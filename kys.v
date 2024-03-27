module MCPU_Alutb();

parameter CMD_SIZE=2;
parameter WORD_SIZE=2;

reg [CMD_SIZE-1:0] opcode ;
reg [WORD_SIZE-1:0] r1 ;
reg [WORD_SIZE-1:0] r2 ;
//new code
reg iscorrect ; // Register to track correctness

wire [WORD_SIZE-1:0] out ;
wire OVERFLOW ;


MCPU_Alu #(.CMD_SIZE(CMD_SIZE), .WORD_SIZE(WORD_SIZE)) aluinst (opcode, r1, r2, out, OVERFLOW);

// Testbench code goes here
always #20 r1[0] = $random;
always #20 r2[0] = $random;
always #20 r1[1] = $random;
always #20 r2[1] = $random;

always #20 opcode[0] = $random;
always #20 opcode[1] = $random;

//new code
// Always block to check correctness on change of 'out'
always @ (opcode,r1,r2) begin
    #4
    case(opcode)
        2'b00: iscorrect = (out == (r1 & r2)); // CMD_AND
        2'b01: iscorrect = (out == (r1 | r2)); // CMD_OR
        2'b10: iscorrect = (out == (r1 ^ r2)); // CMD_XOR
        default: iscorrect = ({OVERFLOW,out} == (r1+r2)); // CMD_ADD
    endcase
end

initial begin
  #5
  $display("@%0dps default is selected, opcode %b",$time,opcode);
end


endmodule
