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
        if(~rcvd_tx.PRESETn) begin
            wdog_rm.module_reset();
        end
        else begin
            if(rcvd_tx.PWRITE)begin
                wdog_rm.write_reg_value(rcvd_tx.PADDR[11:0], rcvd_tx.PWDATA);
                `uvm_info(get_name(), $sformatf("Value written is %0h", rcvd_tx.PWDATA), UVM_HIGH)
                
            end
                
            else begin
                bit [31:0] val;
                val = wdog_rm.read_reg_value(rcvd_tx.PADDR[11:0]);
                `uvm_info(get_name(), $sformatf("Value returned is %0h", val), UVM_HIGH)
            end
        end
    endfunction

    function void write_wdog(wdog_seq_item rcvd_tx);
        if(~rcvd_tx.WDOGRESn) begin
            wdog_rm.counter_reset();
        end
        else begin
            
            
        end
    endfunction

    //  Constructor: new
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    //  Function: build_phase
    extern function void build_phase(uvm_phase phase);
    
    //  Function: connect_phase
    extern function void connect_phase(uvm_phase phase);
    
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

    if (!uvm_config_db#(env_config)::get(this, "", "env_cfg", env_cfg))
        `uvm_fatal(get_name(), "env_config cannot be found in ConfigDB!")
    
endfunction: build_phase

function void wdog_scoreboard::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    wdog_rm.env_cfg = env_cfg;
endfunction: connect_phase


task wdog_scoreboard::run_phase(uvm_phase phase);
    // TODO: Add run task implementation
endtask: run_phase


