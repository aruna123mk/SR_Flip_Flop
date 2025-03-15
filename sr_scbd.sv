
class sr_scbd extends uvm_scoreboard;
  `uvm_component_utils(sr_scbd);

  sr_seqitem item_queue[$]; // Dynamic array to store collected items
  uvm_analysis_imp#(sr_seqitem, sr_scbd) item_collected_export;

  // Constructor
  function new(string name = "sr_scbd", uvm_component parent = null);
    super.new(name, parent);

    // Initialize the analysis export
    item_collected_export = new("item_collected_export", this);
    `uvm_info("SCOREBOARD", "Scoreboard component is created", UVM_LOW);
  endfunction

  // Write function to collect items into the queue
  function void write(sr_seqitem item);
    item_queue.push_back(item); // Add the item to the queue

    // Log the received item details
    `uvm_info("SCOREBOARD", 
      $sformatf("Received item: sr = %0d, q = %0d, qbar = %0d", 
        item.sr, item.q, item.qbar), 
      UVM_LOW);
  endfunction
endclass
