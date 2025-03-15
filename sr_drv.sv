
class sr_drv extends uvm_driver#(sr_seqitem);
  `uvm_component_utils(sr_drv);

  virtual sr_intf vif; // Virtual interface for driving signals
  sr_seqitem item;     // Sequence item to hold the data to be driven

  // Constructor
  function new(string name = "sr_drv", uvm_component parent = null);
    super.new(name, parent);
    `uvm_info("DRIVER", "Driver component is created", UVM_LOW);
  endfunction

  // Build phase: Get the virtual interface from the configuration database
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(virtual sr_intf)::get(this, "", "vif", vif)) begin
      `uvm_fatal("DRIVER", "Virtual interface is not set in the configuration database");
    end
  endfunction

  // Run phase: Fetch items from the sequencer and drive them to the DUT
  task run_phase(uvm_phase phase);
    forever begin
      // Get the next transaction from the sequencer
      seq_item_port.get_next_item(item);

      // Drive the transaction onto the DUT interface
      drive(item);

      // Notify the sequencer that the item has been processed
      seq_item_port.item_done();
    end
  endtask

  // Drive task: Drive the `sr` signal onto the DUT using the virtual interface
  task drive(sr_seqitem item);
    if (vif == null) begin
      `uvm_fatal("DRIVER", "Virtual interface is not set or is null");
    end

    @(posedge vif.clk);
    vif.sr <= item.sr; // Drive the `sr` signal
    `uvm_info("DRIVER", $sformatf("Driving sr = %0b", item.sr), UVM_HIGH);
  endtask
endclass
