
class sr_seqr extends uvm_sequencer#(sr_seqitem);
  `uvm_component_utils(sr_seqr);

  // Constructor for the sequencer
  function new(string name = "sr_seqr", uvm_component parent = null);
    super.new(name, parent);
    `uvm_info("SEQUENCER", "Sequencer component is created", UVM_LOW);
  endfunction
  
  // Optional: You can add more functions here to control how the sequencer generates sequence items
endclass
