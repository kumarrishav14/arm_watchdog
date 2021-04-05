class wdog_agent extends uvm_agent;
    `uvm_component_utils(wdog_agent)
    
    wdog_driver wdog_drv;
    wdog_monitor wdog_mon;
    env_config env_cfg;

    uvm_analysis_port#(wdog_seq_item) ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction //new()

    //  Function: build_phase
    extern function void build_phase(uvm_phase phase);
    
    //  Function: connect_phase
    extern function void connect_phase(uvm_phase phase);
    
endclass //wdog_agent extends uvm_agent

function void wdog_agent::build_phase(uvm_phase phase);
    /*  note: Do not call super.build_phase() from any class that is extended from an UVM base class!  */
    /*  For more information see UVM Cookbook v1800.2 p.503  */
    //super.build_phase(phase);

    wdog_drv = wdog_driver::type_id::create("wdog_drv", this);
    wdog_mon = wdog_monitor::type_id::create("wdog_mon", this);
    if(!uvm_config_db#(env_config)::get(this, "", "env_cfg", env_cfg))
        `uvm_fatal(get_name(), "env_config cannot be found in ConfigDB!")
    
endfunction: build_phase

function void wdog_agent::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    wdog_drv.intf = env_cfg.intf;
    wdog_mon.intf = env_cfg.intf;

    ap = wdog_mon.ap;
endfunction: connect_phase

