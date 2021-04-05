// Just a placeholder class for now. Needs to be implemented in detail

class wdog_monitor extends uvm_monitor;
    `uvm_component_utils(wdog_monitor)
    uvm_analysis_port#(wdog_seq_item) ap;
    virtual wdog_intf.WDOG_MON intf;

    wdog_seq_item sampled_item;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction //new()

    // TODO: Implement the monitor logic. Need to decide how and when
    // to send packets to scoreboard and how to sample the data.
    //  Function: build_phase
    extern function void build_phase(uvm_phase phase);
    
    //  Function: connect_phase
    // extern function void connect_phase(uvm_phase phase);

    //  Function: run_phase
    extern task run_phase(uvm_phase phase);
endclass //wdog_monitor extends uvm_monitor

function void wdog_monitor::build_phase(uvm_phase phase);
    /*  note: Do not call super.build_phase() from any class that is extended from an UVM base class!  */
    /*  For more information see UVM Cookbook v1800.2 p.503  */
    //super.build_phase(phase);

    ap = new("ap", this);
    sampled_item = wdog_seq_item::type_id::create("sampled_item");
endfunction: build_phase

task wdog_monitor::run_phase(uvm_phase phase);
    forever begin
        @(intf.wdog_mon_cb);
        sampled_item.WDOGCLKEN  = intf.wdog_mon_cb.WDOGCLKEN; 
        sampled_item.WDOGRESn   = intf.wdog_mon_cb.WDOGRESn; 
        sampled_item.WDOGINT    = intf.wdog_mon_cb.WDOGINT;
        sampled_item.WDOGRES    = intf.wdog_mon_cb.WDOGRES;
        ap.write(sampled_item);
        if(sampled_item.WDOGINT == 1)
            `uvm_info(get_name(), $sformatf("Sampled wdog packet is: %s", sampled_item.convert2string()), UVM_DEBUG)
            
    end
endtask: run_phase

