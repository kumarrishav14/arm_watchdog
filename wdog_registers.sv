class Wdog_lock extends uvm_reg;
    `uvm_object_utils(Wdog_lock)
    
    uvm_reg_field wdog_lock;
    function new(string name = "wdog_lock");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction //new()

    function void build();
        wdog_lock = uvm_reg_field::type_id::create("wdog_lock");
        wdog_lock.configure(this, 32, 0, "RW", 0, 32'h1ACCE551, 1, 1, 1);
    endfunction: build
    
endclass //wdog_lock extends uvm_reg

class Wdog_load extends uvm_reg;
    `uvm_object_utils(Wdog_load)
    
    uvm_reg_field wdog_load;

    function new(string name = "wdog_load");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction //new()

    function void build();   
        wdog_load = uvm_reg_field::type_id::create("wdog_load");
        wdog_load.configure(this, 32, 0, "RW", 0, 32'hFFFFFFFF, 1, 1, 1);
    endfunction: build
    
endclass //Wdog_load extends uvm_reg