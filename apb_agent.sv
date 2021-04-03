class apb_agent extends uvm_agent;
    `uvm_component_utils(apb_agent)
    
    uvm_sequencer #(wdog_seq_item) seqr;
    apb_driver apb_drv;
    apb_monitor apb_mon;
    env_config env_cfg;
    uvm_analysis_port#(wdog_seq_item) ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction //new()

    //  Function: build_phase
    extern function void build_phase(uvm_phase phase);
    
    //  Function: connect_phase
    extern function void connect_phase(uvm_phase phase);
    
endclass //apb_agent extends uvm_agent

function void apb_agent::build_phase(uvm_phase phase);
    /*  note: Do not call super.build_phase() from any class that is extended from an UVM base class!  */
    /*  For more information see UVM Cookbook v1800.2 p.503  */
    //super.build_phase(phase);
    `uvm_info(get_name(), "building seqr", UVM_HIGH)
    seqr = uvm_sequencer#(wdog_seq_item)::type_id::create("seqr", this);
    `uvm_info(get_name(), "built seqr", UVM_HIGH)
    apb_drv = apb_driver::type_id::create("apb_drv", this);
    apb_mon = apb_monitor::type_id::create("apb_mon", this);
    
    if(!uvm_config_db#(env_config)::get(this, "", "env_cfg", env_cfg))
        `uvm_fatal(get_name(), "env_cfg cannot be found in ConfigDB!")
    
endfunction: build_phase

function void apb_agent::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    apb_drv.seq_item_port.connect(seqr.seq_item_export);
    apb_drv.drv_intf = env_cfg.intf;
    apb_mon.intf = env_cfg.intf;

    this.ap = apb_mon.ap;
endfunction: connect_phase

