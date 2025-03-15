

class sr_seq extends uvm_sequence#(sr_seqitem);
  `uvm_object_utils(sr_seq);
  
  // Sequence item to be used in the sequence
  sr_seqitem item;
  
  // Constructor for the sequence
  function new(string name="sr_seq");
    super.new(name);
    `uvm_info("SEQUENCE", "Sequence object is created", UVM_LOW);
  endfunction
  
  // The body of the sequence where items are generated
  task body();
    // Repeat 5 times to create 5 sequence items
    repeat(5) begin
      // Create a new sequence item
      item = sr_seqitem::type_id::create("item");
      
      // Start the sequence item
      start_item(item);
      
      // Randomize the sequence item
      if (!item.randomize()) begin
        `uvm_fatal("SEQUENCE", "Item is not randomized successfully");
      end
      
      // Finish the sequence item after randomization
      finish_item(item);
      
      // Optionally, log the item values for debugging
      `uvm_info("SEQUENCE", $sformatf("Generated item: sr=%b, q=%b, qbar=%b", item.sr, item.q, item.qbar), UVM_LOW);
    end
  endtask
endclass
