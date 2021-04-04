/*  ~wdog_reg_model~ is top level register environment which consists
    of REGISTER BLOCK, REGISTER ADAPTER AND REGISTER PREDICTOR. It is
    extended from UVM_ENV and thus is a uvm_component which makes it
    visible in component tree.  */
    
class wdog_reg_model extends uvm_env;
    `uvm_component_utils(wdog_reg_model)

    // ~seqr~ which will be connected with reg_block. Will be passed
    // from top class
    uvm_sequencer#(apb_seq_item) seqr;

    // Register block and adapter
    wdog_reg_block reg_block;
    wdog_reg_adapter reg_adapter;

    // Predictor for reg
    uvm_reg_predictor#(apb_seq_item) reg_predictor; 
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction //new()

    //  Function: build_phase
    extern function void build_phase(uvm_phase phase);
    
    //  Function: connect_phase
    extern function void connect_phase(uvm_phase phase);

    //  Function: start_of_simulation_phase
    extern function void start_of_simulation_phase(uvm_phase phase);
    
    
endclass //wdog_reg_model extends uvm_object

// *************************************************************
// Funciton Implementation
// *************************************************************
function void wdog_reg_model::build_phase(uvm_phase phase);
    // Build the register block
    reg_block = wdog_reg_block::type_id::create("reg_block",this);
    reg_block.build();

    // Build adapter and predictor for reg model
    reg_adapter = wdog_reg_adapter::type_id::create("reg_adapter", ,get_full_name);
    reg_predictor = uvm_reg_predictor#(apb_seq_item)::type_id::create("reg_predictor", this);
    
endfunction: build_phase

function void wdog_reg_model::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    // set address map and adapter for PREDICTOR
    reg_predictor.map = reg_block.default_map;
    reg_predictor.adapter = reg_adapter;
endfunction: connect_phase

function void wdog_reg_model::start_of_simulation_phase(uvm_phase phase);
    super.start_of_simulation_phase(phase);
    // set sequencer and base address for the address map
    reg_block.default_map.set_sequencer(seqr, reg_adapter);
    reg_block.default_map.set_base_addr('h00);
endfunction: start_of_simulation_phase



