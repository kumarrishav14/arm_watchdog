//  Class: wdog_scoreboard
//
`uvm_analysis_imp_decl(_apb)
`uvm_analysis_imp_decl(_wdog)
class wdog_scoreboard extends uvm_scoreboard;
    typedef wdog_scoreboard T;
    `uvm_component_utils(wdog_scoreboard);
    
    //  Group: Configuration Object(s)
    env_config env_cfg;

    //  Group: Components
    uvm_analysis_imp_apb#(apb_seq_item, T) apb_ap_imp;
    uvm_analysis_imp_wdog#(wdog_seq_item, T) wdog_ap_imp;
    wdog_ref_model wdog_rm;

    //  Group: Variables


    //  Group: Functions
    function void write_apb(apb_seq_item rcvd_tx);
        // TODO: Add write_apb implementation
    endfunction

    function void write_wdog(wdog_seq_item rcvd_tx);
        // TODO: Add write_wdog implementation
    endfunction

    //  Constructor: new
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    //  Function: build_phase
    extern function void build_phase(uvm_phase phase);
    
    //  Function: connect_phase
    // extern function void connect_phase(uvm_phase phase);
    
    //  Function: run_phase
    extern task run_phase(uvm_phase phase);
endclass: wdog_scoreboard

function void wdog_scoreboard::build_phase(uvm_phase phase);
    /*  note: Do not call super.build_phase() from any class that is extended from an UVM base class!  */
    /*  For more information see UVM Cookbook v1800.2 p.503  */
    //super.build_phase(phase);

    apb_ap_imp = new("apb_ap_imp", this);
    wdog_ap_imp = new("wdog_ap_imp", this);

    wdog_rm = wdog_ref_model::type_id::create("wdog_rm", this);
endfunction: build_phase

task wdog_scoreboard::run_phase(uvm_phase phase);
    // TODO: Add run task implementation
endtask: run_phase


