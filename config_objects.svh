class env_config extends uvm_object;
    `uvm_object_utils(env_config)

    virtual wdog_intf intf;
    uvm_reg_addr_t base_addr;
    function new(string name = "env_config");
        super.new(name);
    endfunction //new()
endclass //env_config extends uvm_object