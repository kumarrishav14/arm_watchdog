class apb_monitor extends uvm_monitor;
    `uvm_component_utils(apb_monitor)
    
    // Components
    uvm_analysis_port#(wdog_seq_item) ap;

    // Variables
    virtual wdog_intf.APB_MON intf;
    wdog_seq_item trans;
    int ip_pntr, op_pntr;
    bit sampled;
    bit pck_complete;

    //   Methods
    // -------------

    task ip_mon();
        @(intf.apb_mon_cb);
        if(intf.apb_mon_cb.PENABLE == 1 && !sampled) begin
            trans.PWRITE    = intf.apb_mon_cb.PWRITE;
            // trans.PSEL     = intf.apb_mon_cb.PSEL;
            trans.PRESETn   = intf.apb_mon_cb.PRESETn;
            trans.PADDR  = intf.apb_mon_cb.PADDR;
            trans.PWDATA = intf.apb_mon_cb.PWDATA;
            ip_pntr++;
            sampled = 1;
        end
        if(intf.apb_mon_cb.PENABLE == 0) sampled = 0;
    endtask

    task op_mon();
        @(intf.apb_mon_cb);
        if(intf.apb_mon_cb.PREADY == 1 && intf.apb_mon_cb.PENABLE == 1) begin
            // trans.PREADY = intf.apb_mon_cb.PREADY;
            trans.PRDATA  = intf.apb_mon_cb.PRDATA;
            op_pntr++;
            pck_complete = 1;
        end 
    endtask

    // Constructor: new
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction //new()

    //  Function: build_phase
    extern function void build_phase(uvm_phase phase);
    
    //  Function: run_phase
    extern task run_phase(uvm_phase phase);
    
endclass //apb_monitor extends uvm_monitor

function void apb_monitor::build_phase(uvm_phase phase);
    // if(!uvm_config_db#(virtual APB_intf)::get(this, "*", "vif", intf))
    //     `uvm_fatal(get_name(), "Cant get interface") 
    ap = new("ap", this);
    trans = new("sam_trans");
endfunction: build_phase

task apb_monitor::run_phase(uvm_phase phase);
    forever begin
        fork
            ip_mon();
            op_mon();
        join
        `uvm_info(get_name(), $sformatf("pck_complete: %b, PSEL1: %b", pck_complete, intf.apb_mon_cb.PSEL), UVM_HIGH)
        if((pck_complete && !intf.apb_mon_cb.PSEL) || !intf.apb_mon_cb.PRESETn) begin
            `uvm_info(get_name(), "Sampled Packet is:", UVM_LOW)
            trans.print();
            ap.write(trans);
            trans = new("sam_trans");
            ip_pntr = 0;
            op_pntr = 0;
            pck_complete = 0;
        end
    end
endtask: run_phase
