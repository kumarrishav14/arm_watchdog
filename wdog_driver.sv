class wdog_driver extends uvm_driver;
    `uvm_component_utils(wdog_driver)
    
    virtual wdog_intf.WDOG_DRV intf;
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction //new()

    // //  Function: reset_phase
    // extern task reset_phase(uvm_phase phase);
    
    // main

    //  Function: run_phase
    extern task run_phase(uvm_phase phase);
    
endclass //wdog_driver extends uvm_driver


task wdog_driver::run_phase(uvm_phase phase);
    intf.wdog_drv_cb.WDOGRESn   <= 0;
    @(intf.wdog_drv_cb);
    forever begin
        @(intf.wdog_drv_cb);
        intf.wdog_drv_cb.WDOGCLKEN  <= 1;
        intf.wdog_drv_cb.WDOGRESn   <= 1;
    end
endtask: run_phase
