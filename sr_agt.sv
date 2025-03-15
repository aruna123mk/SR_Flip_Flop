class sr_agt extends uvm_agent;
  `uvm_component_utils(sr_agt);

  sr_drv drv;              // Driver instance
  sr_mon mon;              // Monitor instance
  sr_seqr seqr;            // Sequencer instance
  virtual sr_intf vif;     // Virtual interface

  // Constructor
  function new(string name = "sr_agt", uvm_component parent = null);
    super.new(name, parent);
    `uvm_info("AGENT", "Agent component is created", UVM_LOW);
  endfunction

  // Build phase: Instantiate driver, monitor, and sequencer
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    // Create driver
    drv = sr_drv::type_id::create("drv", this);
    if (drv == null) begin
      `uvm_fatal("AGENT", "Driver creation failed");
    end

    // Create monitor
    mon = sr_mon::type_id::create("mon", this);
    if (mon == null) begin
      `uvm_fatal("AGENT", "Monitor creation failed");
    end

    // Create sequencer
    seqr = sr_seqr::type_id::create("seqr", this);
    if (seqr == null) begin
      `uvm_fatal("AGENT", "Sequencer creation failed");
    end

    // Bind virtual interface to driver and monitor
    drv.vif = vif;
    mon.vif = vif;
  endfunction

  // Connect phase: Connect the sequencer to the driver's sequence item port
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    // Connect sequencer's sequence item export to driver's sequence item port
    drv.seq_item_port.connect(seqr.seq_item_export);
    `uvm_info("AGENT", "Driver and sequencer ports connected", UVM_LOW);
  endfunction
endclass
