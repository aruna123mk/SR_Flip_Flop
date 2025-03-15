import uvm_pkg::*;
`include "uvm_macros.svh"
`include "sr_intf.sv"
`include "package.sv"

module top;
  // Declare clock and reset signals
  logic clk, rst;

  // Instantiate the SR interface
  sr_intf sint(clk, rst);

  // Instantiate the SR flip-flop module
  SR_FLIP s1(
    .clk(sint.clk),
    .rst(sint.rst),
    .sr(sint.sr[1:0]),
    .q(sint.q),
    .qbar(sint.qbar)
  );
  
  // Clock generation
  initial begin
    clk = 0;
    forever #10 clk = ~clk; // 50 MHz clock
  end

  // Reset generation
  initial begin
    rst = 0;
    #10 rst = 1; // Assert reset
    #10 rst = 0; // De-assert reset
  end

  // Declare a virtual interface for UVM
  virtual sr_intf vif;

  // Set the virtual interface in the UVM configuration database
  initial begin
    vif = sint;
    uvm_config_db #(virtual sr_intf)::set(uvm_root::get(), "*", "vif", vif);
  end

  // Run the UVM test
  initial begin
    run_test("sr_test");
  end

  // Dump waveform for debugging
  initial begin
    $dumpfile("dumpfile.vcd");
    $dumpvars(0, top);
  end

  // End simulation after a specific time
  initial begin
    #100;
    $finish;
  end
endmodule
