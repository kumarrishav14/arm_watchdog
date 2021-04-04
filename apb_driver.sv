class apb_driver extends uvm_driver#(apb_seq_item);
    `uvm_component_utils(apb_driver)
    
    //  Group: Variables
    apb_seq_item trans_drv;
    virtual wdog_intf.APB_DRV drv_intf;
    int i;
    event DRV_DONE;
    
    //  Group: Functions
    // idle task - IDLE operating state
    task idle();
        drv_intf.apb_drv_cb.PSEL    <= 0;
        drv_intf.apb_drv_cb.PENABLE <= 0;
    endtask //idle

    // setup task - SETUP operating state (Sets all the input for the slave)
    task setup();
        // #2;
        drv_intf.apb_drv_cb.PSEL    <= 1;
        drv_intf.apb_drv_cb.PENABLE <= 0;
        drv_intf.apb_drv_cb.PRESETn <= trans_drv.PRESETn;
        drv_intf.apb_drv_cb.PWRITE  <= trans_drv.PWRITE;
        drv_intf.apb_drv_cb.PWDATA  <= trans_drv.PWDATA;
        drv_intf.apb_drv_cb.PADDR   <= trans_drv.PADDR;
    endtask

    // access task - ACCESS operating state
    task access();
        drv_intf.apb_drv_cb.PSEL    <= 1;
        drv_intf.apb_drv_cb.PENABLE <= 1;
    endtask

    // drive task - Switches b/w different operating states
    task drive();
        if(!trans_drv.PRESETn) begin
            @(drv_intf.apb_drv_cb);
            drv_intf.apb_drv_cb.PRESETn <= trans_drv.PRESETn;
            #10;
            drv_intf.apb_drv_cb.PRESETn <= 1;
        end
        else begin  
            @(drv_intf.apb_drv_cb);
            setup();
            @(drv_intf.apb_drv_cb);
            access();
            @(drv_intf.apb_drv_cb);
            wait(drv_intf.apb_drv_cb.PREADY == 1);
        end
        idle();
    endtask

    //  Constructor: new
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction //new()

    //  Function: build_phase
    extern function void build_phase(uvm_phase phase);
    
    //  Function: run_phase
    extern task run_phase(uvm_phase phase);
    
endclass //drvier extends uvm_driver#(transaction)

function void apb_driver::build_phase(uvm_phase phase);
    // if(!uvm_config_db#(virtual APB_intf)::get(this, "*", "vif", drv_intf))
    //     `uvm_fatal(get_name(), "Cant get interface")    
endfunction: build_phase

task apb_driver::run_phase(uvm_phase phase);
    forever begin
        `uvm_info(get_name(), "Requesting for item", UVM_NONE)
        
        seq_item_port.get_next_item(trans_drv);
        `uvm_info(get_name(), "item recieved", UVM_NONE)
        trans_drv.print();
        drive();
        @(drv_intf.apb_drv_cb);
        // ->DRV_DONE;
        seq_item_port.item_done();
    end
endtask: run_phase