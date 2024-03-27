module MCPU_Registerfile_tb;

  // Parameters
  parameter WORD_SIZE = 8;
  parameter ADDR_WIDTH = 8;
  parameter OPERAND_SIZE = 4;
  parameter REGS_NUMBER_WIDTH = 4;
  parameter REGISTERS_NUMBER = 1 << REGS_NUMBER_WIDTH;

  // Signals
  reg [OPERAND_SIZE-1:0] op1, op2, op3;
  reg [WORD_SIZE-1:0] datatoload;
  reg [1:0] regsetcmd,alucmd;
  reg regsetwb;
  wire [WORD_SIZE-1:0] RegOp1, alu1, alu2;
  reg we, re;
  reg [WORD_SIZE-1:0] datawr;
  reg [ADDR_WIDTH-1:0] addr, instraddr;

  wire [WORD_SIZE-1:0] datard, instrrd,add_result;

  // Instantiate MCPU_Registerfile module
  MCPU_Registerfile regfile (
    .op1(op1),
    .op2(op2),
    .op3(op3),
    .datatoload(datatoload),
    .regsetcmd(regsetcmd),
    .regsetwb(regsetwb),
    .RegOp1(RegOp1),
    .alu1(alu1),
    .alu2(alu2)
  );
  
    MCPU_Alu alu (
    .cmd(alucmd),
    .in1(alu1),
    .in2(alu2),
    .out(add_result), // Output for ADD result
    .CF() // Carry flag not used for this example
  );
  
    MCPU_RAMController dut (
    .we(we),
    .datawr(datawr),
    .re(re),
    .addr(addr),
    .datard(datard),
    .instraddr(instraddr),
    .instrrd(instrrd)
  );

  // Testbench behavior
  initial begin
    
    
    // Load 46 into register 0
    regsetcmd = 2'b10; // LOAD_FROM_DATA command
    datatoload = 8'b00101110; // Value 46 in binary
    op1 = 2'b00; // Select register 0
    regsetwb = 1'b0;
    #1;
    regsetwb = 1'b1; // Assert write-back signal
    #1;

    // Load 54 into register 1
    regsetcmd = 2'b10; // LOAD_FROM_DATA command
    datatoload = 8'b00110110; // Value 54 in binary
    op1 = 2'b01; // Select register 1
    regsetwb = 1'b0;
    #1;
    regsetwb = 1'b1; // Assert write-back signal
    #1;
    
    

    // Store register 0 value in memory location 100
    
    we = 1'b1;
    re = 1'b0;
    regsetcmd = 2'b11; // STORE_TO_MEM command
    op1 = 2'b00; // Select register 0
    regsetwb = 1'b0;
    #1;
    regsetwb = 1'b1; // Assert write-back signal
    #1;
    addr = 8'b01100100; // Memory address 100 in binary
    datawr = RegOp1;
    
    
    #3;

    // Store register 1 value in memory location 101
    regsetcmd = 2'b11; // STORE_TO_MEM command
    op1 = 2'b01; // Select register 1
    regsetwb = 1'b0;
    #1;
    regsetwb = 1'b1; // Assert write-back signal
    #1;
    addr = 8'b01100101; // Memory address 101 in binary
    datawr = RegOp1;
    #2;

    
    // Load value from memory location 100 to register 2
    we = 0;
    re = 1;
    addr = 8'b01100100; // Memory address 100 in binary
    #1;
    
    regsetcmd = 2'b00; // LOAD_FROM_MEM command
    op1 = 2'b10; // Select register 2
    datatoload = datard ; // Memory address 100 in binary
    regsetwb = 1'b0;
    #1;
    regsetwb = 1'b1; // Assert write-back signal
    #1;

    // Load value from memory location 101 to register 3
    addr = 8'b01100101;
    #1;
    regsetcmd = 2'b00; // LOAD_FROM_MEM command
    op1 = 2'b11; // Select register 3
    datatoload = datard; // Memory address 101 in binary
    regsetwb = 1'b0;
    #1;
    regsetwb = 1'b1; // Assert write-back signal
    #1;
    
    // Perform ADD operation using values from register 2 and 3 and store in register 4
    regsetcmd = 2'b00; // NORMAL_EX command for ADD
    regsetwb = 1'b0;
    op1 = 3'b100; // Register 4
    op2 = 2'b10;
    op3 = 2'b11;
    alucmd = 2'b11;
    #3;
    datatoload = add_result; // Memory address 102 in binary
    #1;
    regsetwb = 1'b1; // Assert write-back signal
    #1;
    
        // Store register 4 value in memory location 102
    regsetcmd = 2'b11; // STORE_TO_MEM command
    op1 = 3'b100; // Select register 4
    datatoload = 8'b01100110; // Memory address 102 in binary
    regsetwb = 1'b1; // Assert write-back signal
    #1;

    // Perform XOR operation using values from register 2 and 3 and store in register 5
    regsetcmd = 2'b00; // MOV_INTERNAL command for XOR
    regsetwb = 1'b0;
    op1 = 3'b101; // Register 5
    op2 = 2'b10;
    op3 = 2'b11;
    alucmd = 2'b10;
    #3;
    datatoload = add_result;
    #1;
    regsetwb = 1'b1; // Assert write-back signal
    #1;
    
        // Store register 5 value in memory location 103
    regsetcmd = 2'b11; // STORE_TO_MEM command
    op1 = 3'b101; // Select register 5
    datatoload = 8'b01100111; // Memory address 103 in binary
    regsetwb = 1'b1; // Assert write-back signal
    #1; 
    
  end

endmodule


