package arm_wdog_vip;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    // Bus (APB) Sequence item
    `include "wdog_seq_item.sv"

    // Register Model
    `include "wdog_registers.sv"
    `include "wdog_reg_block.sv"
    `include "wdog_reg_adapter.sv"
    `include "wdog_reg_model.sv"

    // test
    `include "test_reg_seq.sv"
    `include "test_regmodel_test.sv"

endpackage