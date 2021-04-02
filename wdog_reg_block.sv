class wdog_reg_block extends uvm_reg_block;

    `uvm_object_utils(wdog_reg_block)
    
    Wdog_load wdog_load;
    Wdog_lock wdog_lock;

    function new(string name = "reg_file");
        super.new(name);
    endfunction //new()

    function void build();
        wdog_lock = Wdog_lock::type_id::create();
        wdog_lock.build();
        wdog_lock.configure(this);
        
        wdog_load = Wdog_load::type_id::create();
        wdog_load.build();
        wdog_load.configure(this);

        default_map = create_map("wdog_reg_map", 0, 4, UVM_LITTLE_ENDIAN);
        default_map.add_reg(wdog_lock, 'hC00, "RW");
        default_map.add_reg(wdog_load, 'h0, "RW");

        lock_model();
    endfunction: build 
endclass //reg_file extends uvm_reg_file