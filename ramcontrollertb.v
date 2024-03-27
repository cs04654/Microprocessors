module MCPU_RAMControllertb;

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


  
  // Testbench behavior
  initial begin
    // Initialize random seed
    $randomize;

    // Data writing to fill memory and create local copy
    // Fill memory with random words
    // Store the random words in the local copy of the memory
    we = 1; // Enable write operation
    re = 0; // Disable read operation initially
    
    
    for (addr_counter = 0; addr_counter < RAM_SIZE; addr_counter = addr_counter + 1) begin
      addr = addr_counter; // Increment address by 1 in each iteration
      datawr = $random % (1 << WORD_SIZE); // Generate random data
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