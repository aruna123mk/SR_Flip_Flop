class sr_test extends uvm_test;
  `uvm_component_utils(sr_test)
  
  sr_env env;  // Handle for the environment
  
  // Constructor
  function new(string name = "sr_test", uvm_component parent = null);
    super.new(name, parent);
    `uvm_info("TEST_COMPONENT", "Test component is created", UVM_LOW)
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = sr_env::type_id::create("env", this);
    if (env == null) begin
      `uvm_fatal("TEST_COMPONENT", "Environment is not created")
    end
  endfunction

  // Run phase
  task run_phase(uvm_phase phase);
    sr_seq sr_seq1;  // Declare the sequence handle

    phase.raise_objection(this);
    `uvm_info("TEST_COMPONENT", "The sequence will start", UVM_LOW)

    // Create the sequence
    sr_seq1 = sr_seq::type_id::create("sr_seq1");
    if (sr_seq1 == null) begin
      `uvm_fatal("TEST_COMPONENT", "Sequence creation failed")
    end

    // Start the sequence
    if (env != null) begin
      sr_seq1.start(env.agt.seqr);
    end else begin
      `uvm_fatal("TEST_COMPONENT", "Environment is not initialized")
    end

    `uvm_info("TEST_COMPONENT", "The sequence has completed", UVM_LOW)
    phase.drop_objection(this);
  endtask

  // End of elaboration phase
  function void end_of_elaboration_phase(uvm_phase phase);
    print();
    `uvm_info("TEST_COMPONENT", "End of elaboration phase", UVM_LOW)
  endfunction
endclass
