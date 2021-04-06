import arm_wdog_vip::*;
import uvm_pkg::*;
// WDOG Interface
`include "wdog_intf.sv"

// DUT
`include "cmsdk_apb_watchdog.v"
`include "cmsdk_apb_watchdog_frc.v"

module top();
    test test1;
    bit pclk, wdogclk;

    always #5 pclk = ~pclk;
    always #10 wdogclk = ~wdogclk;

    wdog_intf intf(pclk, wdogclk);

    cmsdk_apb_watchdog dut (
                .PCLK(pclk),        
                .PRESETn(intf.PRESETn),     
                .PENABLE(intf.PENABLE),     
                .PSEL(intf.PSEL),        
                .PADDR(intf.PADDR[11:2]),      
                .PWRITE(intf.PWRITE),      
                .PWDATA(intf.PWDATA),      

                .WDOGCLK(wdogclk),     
                .WDOGCLKEN(intf.WDOGCLKEN),   
                .WDOGRESn(intf.WDOGRESn),  

                .ECOREVNUM(4'h0),   

                .PRDATA(intf.PRDATA),      

                .WDOGINT(intf.WDOGINT),     
                .WDOGRES(intf.WDOGRES));

    env_config env_cfg;

    initial begin
        // config_object to configure environment
        env_cfg = env_config::type_id::create("env_cfg");
        env_cfg.intf = intf;

        // Configure the dut id's below in 8 bit format. Should be same as
        // expected value from the DUT for respective ID.
        env_cfg.peripheral_id0 = 8'h24;
        env_cfg.peripheral_id1 = 8'hB8;
        env_cfg.peripheral_id2 = 8'h1B;
        env_cfg.peripheral_id3 = 8'h00;
        uvm_config_db#(env_config)::set(null, "uvm_test_top.*", "env_cfg", env_cfg);
        
        // test1 = test::type_id::create("test1", null);

        intf.PREADY = 'b1;
        run_test("test");
        
    end
endmodule