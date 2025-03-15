class sr_mon extends uvm_monitor;  `uvm_component_utils(sr_mon);

  virtual sr_intf vif; // Virtual interface for DUT signals
  sr_seqitem item; // Sequence item to capture transactions
  uvm_analysis_port#(sr_seqitem) item_collected_port; // Analysis port to send data to the scoreboard

  // Constructor
  function new(string name = "sr_mon", uvm_component parent = null);
    super.new(name, parent);
    item_collected_port = new("item_collected_port", this); // Initialize analysis port
    `uvm_info("MONITOR", "Monitor component is created", UVM_LOW);
  endfunction

  // Build phase: Get the virtual interface from the configuration database
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(virtual sr_intf)::get(this, "", "vif", vif)) begin
      `uvm_fatal("MONITOR", "Virtual interface is not set in the configuration database");
    end
  endfunction

  // Run phase: Continuously capture DUT signals and send them to the analysis port
  task run_phase(uvm_phase phase);
    item = sr_seqitem::type_id::create("item", this); // Create a new sequence item

    forever begin
      // Wait for the rising edge of the clock
      @(posedge vif.clk);

      // Capture DUT signals into the sequence item
      item.sr = vif.sr;
      item.q = vif.q;
      item.qbar = vif.qbar;

      // Log captured values for debugging
      `uvm_info("MONITOR_DEBUG", 
        $sformatf("Captured: sr = %0b, q = %0b, qbar = %0b", item.sr, item.q, item.qbar), 
        UVM_HIGH);

      // Only send data if reset is inactive
      if (vif.rst) begin
        `uvm_info("MONITOR_DEBUG", "Reset is active, skipping this transaction", UVM_LOW);
      end else begin
        item_collected_port.write(item); // Send data to analysis port
        `uvm_info("MONITOR", "Data sent to analysis port", UVM_LOW);
      end
    end
  endtask
endclass
