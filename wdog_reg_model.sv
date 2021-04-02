class wdog_reg_model extends uvm_env;
    `uvm_component_utils(wdog_reg_model)

    uvm_sequencer#(wdog_seq_item) seqr;

    // Register block and adapter
    wdog_reg_block reg_block;
    wdog_reg_adapter reg_adapter;

    // Predictor for reg
    uvm_reg_predictor#(wdog_seq_item) reg_predictor; 
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction //new()

    //  Function: build_phase
    extern function void build_phase(uvm_phase phase);
    
    //  Function: connect_phase
    extern function void connect_phase(uvm_phase phase);
    
endclass //wdog_reg_model extends uvm_object

function void wdog_reg_model::build_phase(uvm_phase phase);
    /*  note: Do not call super.build_phase() from any class that is extended from an UVM base class!  */
    /*  For more information see UVM Cookbook v1800.2 p.503  */
    //super.build_phase(phase);
    reg_block = wdog_reg_block::type_id::create("regblock",this);
    reg_block.build();
    reg_adapter = wdog_reg_adapter::type_id::create("regadapter", ,get_full_name);
    reg_predictor = uvm_reg_predictor#(wdog_seq_item)::type_id::create("reg_predictor", this);
    
endfunction: build_phase

function void wdog_reg_model::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    reg_block.default_map.set_sequencer(seqr, reg_adapter);
    reg_block.default_map.set_base_addr('h00);

    reg_predictor.map = reg_block.default_map;
    reg_predictor.adapter = reg_adapter;
endfunction: connect_phase


