/*
class sr_env extends uvm_env;
  `uvm_component_utils(sr_env);
  sr_agt agt;
  sr_scbd scbd;
  virtual sr_intf vif;
  
  
  function new(string name="sr_env",uvm_component parent);
    super.new(name,parent);
    `uvm_info("envienvironment component","environment component is created",UVM_LOW);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    agt=sr_agt::type_id::create("agt",this);
    if(agt==null)begin
      `uvm_fatal("environment","agent is not created");
    end
    
    scbd=sr_scbd::type_id::create("scbd",this);
    if(scbd==null)begin
      `uvm_fatal("environment","scoreboard  is not created");
    end
    
    if(!uvm_config_db#(virtual sr_intf)::get(this,"","vif",vif))begin
      `uvm_fatal("environment","virtual interface is not created");
    end
    uvm_config_db#(virtual sr_intf)::set(this,"agt","vif",vif);
    
  endfunction
  
  function void connect_phase(uvm_phase phase);
    if(agt.mon.item_collected_port==null)begin
      `uvm_fatal("envronmaent","analysis port is not created");
    end
    else begin
      agt.mon.item_collected_port.connect(scbd.item_collected_export);
    end
  endfunction
endclass


*/



class sr_env extends uvm_env;
  `uvm_component_utils(sr_env);

  sr_agt agt;               // Agent instance
  sr_scbd scbd;             // Scoreboard instance
  virtual sr_intf vif;      // Virtual interface

  // Constructor
  function new(string name = "sr_env", uvm_component parent = null);
    super.new(name, parent);
    `uvm_info("ENV", "Environment component is created", UVM_LOW);
  endfunction

  // Build phase: Instantiate agent, scoreboard, and configure virtual interface
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    // Create agent
    agt = sr_agt::type_id::create("agt", this);
    if (agt == null) begin
      `uvm_fatal("ENV", "Agent creation failed");
    end
    
    // Create scoreboard
    scbd = sr_scbd::type_id::create("scbd", this);
    if (scbd == null) begin
      `uvm_fatal("ENV", "Scoreboard creation failed");
    end
    
    // Get virtual interface from the configuration database
    if (!uvm_config_db#(virtual sr_intf)::get(this, "", "vif", vif)) begin
      `uvm_fatal("ENV", "Virtual interface not found in configuration database");
    end

    // Set the virtual interface for the agent
    uvm_config_db#(virtual sr_intf)::set(this, "agt", "vif", vif);
  endfunction

  // Connect phase: Connect agent's analysis port to scoreboard's export
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    if (agt.mon.item_collected_port == null) begin
      `uvm_fatal("ENV", "Agent's analysis port is not instantiated");
    end else begin
      agt.mon.item_collected_port.connect(scbd.item_collected_export);
      `uvm_info("ENV", "Agent's analysis port connected to scoreboard's export", UVM_LOW);
    end
  endfunction
endclass
