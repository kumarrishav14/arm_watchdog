interface wdog_intf(input logic pclk, input logic wdogclk);
    // Signals needed
    // APB Signals
    logic         PRESETn;
    logic [31:0]  PADDR;
    logic         PSEL;
    logic         PENABLE;
    logic         PWRITE;
    logic [31:0]  PWDATA;
    logic [31:0]  PRDATA;
    logic         PREADY;

    // Non-APB Signals
    logic WDOGCLKEN;
    logic WDOGRSTn;
    logic WDOGINT;
    logic WDOGRST;

    // ****************************************************************************
    // Clocking block for APB driver and monitor
    // ****************************************************************************
    clocking apb_drv_cb @(posedge pclk);
        output PWRITE, PWDATA, PADDR, PENABLE, PRESETn, PSEL;
        input PREADY;
    endclocking

    clocking apb_mon_cb @(posedge pclk);
        input PWRITE, PWDATA, PADDR, PENABLE, PRESETn, PSEL; 
        input #1 PRDATA, PREADY;
    endclocking

    // ****************************************************************************
    // Clocking block for WDOG Driver and monitor
    // ****************************************************************************
    clocking wdog_drv_cb @(posedge wdogclk);
        output WDOGCLKEN, WDOGRSTn; 
    endclocking
    
    clocking wdog_mon_cb @(posedge wdogclk);
        input WDOGCLKEN, WDOGRSTn; 
        input #1 WDOGINT, WDOGRST;
    endclocking

    // ****************************************************************************
    // Modports
    // ****************************************************************************
    modport APB_DRV  (clocking apb_drv_cb);
    modport APB_MON  (clocking apb_mon_cb);
    modport WDOG_DRV (clocking wdog_drv_cb);
    modport WDOG_MON (clocking wdog_mon_cb);

endinterface