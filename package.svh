package arm_wdog_vip;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    // Bus (APB) and Watchdog Sequence item
    `include "apb_seq_item.sv"
    `include "wdog_seq_item.sv"

    // Register Model
    `include "wdog_registers.sv"
    `include "wdog_reg_block.sv"
    `include "wdog_reg_adapter.sv"
    `include "wdog_reg_model.sv"

    // Config objects
    `include "config_objects.svh"

    // APB Agent
    `include "apb_driver.sv"
    `include "apb_monitor.sv"
    `include "apb_agent.sv"

    // Watchdog Agent
    `include "wdog_driver.sv"
    `include "wdog_monitor.sv"
    `include "wdog_agent.sv"

    // Scoreboard
    `include "wdog_ref_model.sv"
    `include "wdog_scoreboard.sv"

    // Reset Generator
    `include "wdog_reset_generator.sv"

    // Environment
    `include "wdog_env.sv"
    
    // test
    `include "test_reg_seq.sv"
    `include "test_regmodel_test.sv"

endpackage