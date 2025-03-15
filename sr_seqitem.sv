
class sr_seqitem extends uvm_sequence_item;
  `uvm_object_utils(sr_seqitem);

  // Randomized fields for the SR flip-flop
  randc bit [1:0] sr;   // 2-bit shift register value
   bit q;           // Q output
   bit qbar;        // Q' (Q bar) output
  
  // Constructor for the sequence item
  function new(string name="sr_seqitem");
    super.new(name);
    `uvm_info("SEQ_ITEM", "Sequence item object is created", UVM_LOW);
  endfunction

  // Display function for logging the sequence item values
  function void display();
    `uvm_info("SEQ_ITEM", $sformatf("Received item: sr=%b, q=%b, qbar=%b", sr, q, qbar), UVM_LOW);
  endfunction

  // Constraint to ensure valid values for the sr field
  constraint valid_input {
    sr inside {2'b00, 2'b01, 2'b10, 2'b11};
  }
endclass
