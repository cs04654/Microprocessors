module MCPU_RAMControllertbb;

  // Parameters
  parameter WORD_SIZE = 8;
  parameter ADDR_WIDTH = 8;
  parameter RAM_SIZE = 1 << ADDR_WIDTH;

  // Signals
  reg we, re;
  reg [WORD_SIZE-1:0] datawr;
  reg [ADDR_WIDTH-1:0] addr, instraddr;

  wire [WORD_SIZE-1:0] datard, instrrd;

  // Instantiate RAM Controller
  MCPU_RAMController dut (
    .we(we),
    .datawr(datawr),
    .re(re),
    .addr(addr),
    .datard(datard),
    .instraddr(instraddr),
    .instrrd(instrrd)
  );

  // Local memory copy for comparison
  reg [WORD_SIZE-1:0] mem_copy[RAM_SIZE-1:0];
  
      
  integer addr_counter; // Declare a counter for address increment
  reg [63:0] data_sequence;
 

  
  // Testbench behavior
  initial begin

    data_sequence[7*8 +: 8] = 8'h9;
    data_sequence[6*8 +: 8] = 8'h3;
    data_sequence[5*8 +: 8] = 8'h7;
    data_sequence[4*8 +: 8] = 8'h4;
    data_sequence[3*8 +: 8] = 8'h4;
    data_sequence[2*8 +: 8] = 8'h5;
    data_sequence[1*8 +: 8] = 8'h6;
    data_sequence[0*8 +: 8] = 8'h4;

    // Data writing to fill memory and create local copy
    // Fill memory with random words
    // Store the random words in the local copy of the memory
    we = 1; // Enable write operation
    re = 0; // Disable read operation initially
    
     
     // Use a for loop for sequential address increment
    for (addr_counter = 0; addr_counter < RAM_SIZE; addr_counter = addr_counter + 1) begin
      addr = addr_counter; // Increment address by 1 in each iteration
      datawr = data_sequence[(addr_counter % 8)*8 +: 8]; // Write specific values in a repeating pattern
      mem_copy[addr] = datawr; // Store data in local memory copy
      #1; // Hold values for 1 time unit
    end

    // Data read and comparison with local memory copy
    // Perform data read and compare with local memory copy
    re = 1; // Enable read operation
    we = 0; // Disable write operation


    for (addr_counter = 0; addr_counter < RAM_SIZE; addr_counter = addr_counter + 1) begin
      addr = addr_counter; 
      instraddr = addr_counter; 
      #1; // Hold values for 1 time unit

      if (datard !== mem_copy[addr]) begin
        $display("Data read mismatch at address %d", addr);
        $stop;
      end

      if (instrrd !== mem_copy[instraddr]) begin
        $display("Data read mismatch at address %d", instraddr);
        $stop;
      end
    end
end

endmodule
