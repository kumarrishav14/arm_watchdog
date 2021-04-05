class wdog_env extends uvm_env;
    `uvm_component_utils(wdog_env)

    // Register model
    wdog_reg_model reg_model;

    // Agents
    apb_agent apb_agnt;
    wdog_agent wdog_agnt;

    // Scoreboard
    wdog_scoreboard wdog_scb;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction //new()

    //  Function: build_phase
    extern function void build_phase(uvm_phase phase);
    
    //  Function: connect_phase
    extern function void connect_phase(uvm_phase phase);
    
    
endclass //wdog_env extends uvm_env

function void wdog_env::build_phase(uvm_phase phase);
    // Building reg model
    reg_model = wdog_reg_model::type_id::create("res_model", this);

    // Building agents
    apb_agnt = apb_agent::type_id::create("apb_agnt", this);
    wdog_agnt = wdog_agent::type_id::create("wdog_agnt", this);

    // Building Scoreboard
    wdog_scb = wdog_scoreboard::type_id::create("wdog_scb", this);
endfunction: build_phase

function void wdog_env::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    // Initializing the ~seqr~ in reg_model with the ~seqr~ in apb agent
    reg_model.seqr = apb_agnt.seqr;

    // Connecting analysis port of ~apb_agnt~ to predictor of reg model
    apb_agnt.ap.connect(reg_model.reg_predictor.bus_in);

    // Connecting analysis port of ~apb_agnt~ to scoreboard
    apb_agnt.ap.connect(wdog_scb.apb_ap_imp);
    wdog_agnt.ap.connect(wdog_scb.wdog_ap_imp);
endfunction: connect_phase

