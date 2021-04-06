class env_config extends uvm_object;
    `uvm_object_utils(env_config)

    // interface for the environment components
    virtual wdog_intf intf;

    // *****************************************************
    // Configuration related DUT
    // *****************************************************

    // base address of the watchdog timer
    uvm_reg_addr_t base_addr;

    // peripheral id0-3 for watchdog timer
    bit [7:0] peripheral_id0;
    bit [7:0] peripheral_id1;
    bit [7:0] peripheral_id2;
    bit [7:0] peripheral_id3;

    // max and min value of ~wdog_load~ register
    bit [31:0] max_val;
    bit [31:0] min_val;

    // *****************************************************
    // Funciton
    // *****************************************************

    function new(string name = "env_config");
        super.new(name);
    endfunction //new()

    function void build_phase(uvm_phase phase);
        // default value of 0 is given to base_addr
        base_addr = 0;
    
        // default value of peripheral id's as per ARM specifications
        peripheral_id0 = 8'h05;
        peripheral_id1 = 8'h18;
        peripheral_id2 = 8'h14;
        peripheral_id3 = 8'h00;

        // Default max and min values
        max_val = 20;
        min_val = 1;
    endfunction: build_phase
    
endclass //env_config extends uvm_object