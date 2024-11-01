module MCPUtbb();


reg reset, clk;


MCPU cpuinst (clk, reset);


initial begin
  reset=1;
  #10  reset=0;
end

always begin
  #5 clk=0; 
  #5 clk=1; 
end


/********OUR ASSEMBLER*****/

integer file, i;
reg[cpuinst.WORD_SIZE-1:0] memi;
parameter  [cpuinst.OPERAND_SIZE-1:0]  R0  = 0; //4'b0000
parameter  [cpuinst.OPERAND_SIZE-1:0]  R1  = 1; //4'b0001
parameter  [cpuinst.OPERAND_SIZE-1:0]  R2  = 2; //4'b0010
parameter  [cpuinst.OPERAND_SIZE-1:0]  R3  = 3; //4'b0011
parameter  [cpuinst.OPERAND_SIZE-1:0]  R4  = 4; //4'b0100
parameter  [cpuinst.OPERAND_SIZE-1:0]  R5  = 5; //4'b0101
parameter  [cpuinst.OPERAND_SIZE-1:0]  R6  = 6; //4'b0110
parameter  [cpuinst.OPERAND_SIZE-1:0]  R7  = 7; //4'b0111
parameter  [cpuinst.OPERAND_SIZE-1:0]  R8  = 8; //4'b1000
parameter  [cpuinst.OPERAND_SIZE-1:0]  R9  = 9; //4'b1001
parameter  [cpuinst.OPERAND_SIZE-1:0]  R10 = 10; //4'b1010
parameter  [cpuinst.OPERAND_SIZE-1:0]  R11 = 11; //4'b1011
parameter  [cpuinst.OPERAND_SIZE-1:0]  R12 = 12; //4'b1100
parameter  [cpuinst.OPERAND_SIZE-1:0]  R13 = 13; //4'b1101
parameter  [cpuinst.OPERAND_SIZE-1:0]  R14 = 14; //4'b1110
parameter  [cpuinst.OPERAND_SIZE-1:0]  R15 = 15; //4'b1111

initial
begin

    for(i=0;i<256;i=i+1)
    begin
      cpuinst.raminst.mem[i]=0;
    end
    cpuinst.regfileinst.R[0]=0;
    cpuinst.regfileinst.R[1]=0;
    cpuinst.regfileinst.R[2]=0;
    cpuinst.regfileinst.R[3]=0;  
    cpuinst.regfileinst.R[4]=0;
    cpuinst.regfileinst.R[5]=0;
    cpuinst.regfileinst.R[6]=0;
    cpuinst.regfileinst.R[7]=0;    
    cpuinst.regfileinst.R[8]=0;
    cpuinst.regfileinst.R[9]=0;
    cpuinst.regfileinst.R[10]=0;
    cpuinst.regfileinst.R[11]=0;     
    cpuinst.regfileinst.R[12]=0;
    cpuinst.regfileinst.R[13]=0;
    cpuinst.regfileinst.R[14]=0;
    cpuinst.regfileinst.R[15]=0;    
    
    i=0;cpuinst.raminst.mem[0]={cpuinst.OP_SHORT_TO_REG, R0, 8'b00000000}; // dummy instruction
    
    // LSL                                                                        
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_SHORT_TO_REG, R6, 8'b00101110};   //2: R2=2;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_SHORT_TO_REG, R7, 8'b00000100};   //2: R2=2;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_LSL, R8, R6, R7}; 
    
    // LSR
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_SHORT_TO_REG, R9, 8'b00110110};   //2: R2=2;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_SHORT_TO_REG, R10, 8'b00000100};   //2: R2=2;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_LSR, R11, R9, R10}; 
    
    // HAILSTONE INITIAL
    i=i+1;cpuinst.raminst.mem[0]={cpuinst.OP_SHORT_TO_REG, R12, 8'b00001010}; // n
    i=i+1;cpuinst.raminst.mem[0]={cpuinst.OP_SHORT_TO_REG, R13, 8'b00000001}; // 1
    
    // HAILSTONE LOOP
    i=i+1;cpuinst.raminst.mem[0]={cpuinst.OP_XOR, R14, R12, R13};// XOR (n XOR 1) reverse LSB
    i=i+1;cpuinst.raminst.mem[0]={cpuinst.OP_BNZ, R14, 8'b00010110}; // 22 - if n^1 is zero stop loop
    i=i+1;cpuinst.raminst.mem[0]={cpuinst.OP_AND, R14, R12, R13}; // AND (n AND 1) get LSB
    i=i+1;cpuinst.raminst.mem[0]={cpuinst.OP_XOR, R14, R12, R13}; // XOR (n XOR 1) reverse LSB
    i=i+1;cpuinst.raminst.mem[0]={cpuinst.OP_BNZ, R14, 8'b00010011}; // 19 - if lsb is zero go to else
    i=i+1;cpuinst.raminst.mem[0]={cpuinst.OP_LSL, R15, R14, R13};// 2n
    i=i+1;cpuinst.raminst.mem[0]={cpuinst.OP_ADD, R14, R14, R15};// 2n+n
    i=i+1;cpuinst.raminst.mem[0]={cpuinst.OP_ADD, R12, R14, R13};// n = 3n+1
    i=i+1;cpuinst.raminst.mem[0]={cpuinst.OP_SHORT_TO_REG, R15, 8'b00000000}; // Set R15 to zero
    i=i+1;cpuinst.raminst.mem[0]={cpuinst.OP_BNZ, R15, 8'b00000000};  // Skip else
    i=i+1;cpuinst.raminst.mem[0]={cpuinst.OP_LSR, R12, R12, R13}; // n  = n/2
    i=i+1;cpuinst.raminst.mem[0]={cpuinst.OP_SHORT_TO_REG, R15, 8'b00000000}; // Set R15 to zero
    i=i+1;cpuinst.raminst.mem[0]={cpuinst.OP_BNZ, R15, 8'b00001001};  // 9 - Go to start
    
    // FIBONACCI INITIAL                                                                               //memory address: instruction
    i=i+1;cpuinst.raminst.mem[0]={cpuinst.OP_SHORT_TO_REG, R0, 8'b00000000};   //0: R0=0;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_SHORT_TO_REG, R1, 8'b00000001};   //1: R1=1;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_SHORT_TO_REG, R2, 8'b00000010};   //2: R2=2;
    
    // FIBONACCI LOOP                                                       //do{
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_MOV, R0, R1, 4'b0000};            //  3: R1=R0;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_MOV, R1, R2, 4'b0000};            //  4: R1=R2;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_ADD, R2, R0, R1};                 //  5: R2=R0+R1;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_STORE_TO_MEM, R2, 8'b00010100};   //  6:mem[20]=R2;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_LOAD_FROM_MEM, R3, 8'b00010100};  //  7:R3=mem[20];
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_ADD, R0, R0, R0};                 //  8:R0=R0+R0
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_BNZ, R2, 8'b00000011};         //}

    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_SHORT_TO_REG, R14, 8'b01000011};
    



    
    
    file = $fopen("program.list","w");
    for(i=0;i<cpuinst.raminst.RAM_SIZE;i=i+1)
    begin
      memi=cpuinst.raminst.mem[i];
      
      $fwrite(file, "%b_%b_%b_%b\n", 
        memi[cpuinst.INSTRUCTION_SIZE-1:cpuinst.INSTRUCTION_SIZE-cpuinst.OPCODE_SIZE],
        memi[cpuinst.OPCODE_SIZE*3-1:2*cpuinst.OPCODE_SIZE],
        memi[cpuinst.OPCODE_SIZE*2-1:cpuinst.OPCODE_SIZE],
        memi[cpuinst.OPCODE_SIZE-1:0]);
    end
    $fclose(file);
end

endmodule
