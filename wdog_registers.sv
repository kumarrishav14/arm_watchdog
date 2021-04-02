//function void configure(uvm_reg 	parent,
                // int 	unsigned 	size,
                // int 	unsigned 	lsb_pos,
                // string 	access,
                // bit 	volatile,
                // uvm_reg_data_t 	reset,
                // bit 	has_reset,
                // bit 	is_rand,
                // bit 	individually_accessible	)
// *************************************************************
// 1. WDOG_LOAD (Load Register)
// *************************************************************
class Wdog_load extends uvm_reg;
    `uvm_object_utils(Wdog_load)
    
    uvm_reg_field wdog_load;

    function new(string name = "wdog_load");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction //new()

    function void build();   
        wdog_load = uvm_reg_field::type_id::create("wdog_load");
        wdog_load.configure(this, 32, 0, "RW", 0, 32'hFFFFFFFF, 0, 1, 0);
    endfunction: build
endclass //Wdog_load extends uvm_reg


// *************************************************************
// 2. WDOG_Value (Vaue Register)
// *************************************************************
class Wdog_value extends uvm_reg;
    `uvm_object_utils(Wdog_value)
    
    uvm_reg_field wdog_value;
    function new(string name = "wdog_value");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction //new()

    function void build();
        wdog_value = uvm_reg_field::type_id::create("wdog_value");
        wdog_value.configure(this, 32, 0, "RO", 1, 32'h0, 0, 0, 0);
    endfunction: build
    
endclass //wdog_lock extends uvm_reg


// *************************************************************
// 3. WDOG_Control (Control Register)
//    WDOG_Control[0] = inten
//    WDOG_Control[1] = resen
// *************************************************************
class Wdog_control extends uvm_reg;
    `uvm_object_utils(Wdog_value)
    
    uvm_reg_field inten;
    uvm_reg_field resen;

    function new(string name = "wdog_value");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction //new()

    function void build();
        inten = uvm_reg_field::type_id::create("inten");
        inten.configure(this, 1, 0, "RW", 0, 1'h0, 1, 1, 0);

        resen = uvm_reg_field::type_id::create("resen");
        resen.configure(this, 1, 1, "RW", 0, 1'h0, 1, 1, 0);
    endfunction: build
    
endclass //wdog_lock extends uvm_reg

// *************************************************************
// 4. WDOG_INTCLR (Interupt Clear Register)
// *************************************************************
class Wdog_intclr extends uvm_reg;
    `uvm_object_utils(Wdog_lock)
    
    uvm_reg_field wdog_intclr;
    function new(string name = "wdog_intclr");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction //new()

    function void build();
        wdog_intclr = uvm_reg_field::type_id::create("wdog_intclr");
        wdog_intclr.configure(this, 32, 0, "WO", 0, 32'h0, 0, 1, 1);
    endfunction: build
    
endclass //wdog_intclr extends uvm_reg

// *************************************************************
// 5. WDOG_RIS (Raw Interrupt Register)
// *************************************************************
class Wdog_ris extends uvm_reg;
    `uvm_object_utils(Wdog_lock)
    
    uvm_reg_field wdog_ris;
    function new(string name = "wdog_ris");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction //new()

    function void build();
        wdog_ris = uvm_reg_field::type_id::create("wdog_ris");
        wdog_ris.configure(this, 1, 0, "RO", 0, 32'h0, 1, 1, 1);
    endfunction: build
    
endclass //wdog_ris extends uvm_reg


// *************************************************************
// 6. WDOG_MIS(Masked Interrupt Register)
// *************************************************************
class Wdog_mis extends uvm_reg;
    `uvm_object_utils(Wdog_lock)
    
    uvm_reg_field wdog_mis;
    function new(string name = "wdog_mis");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction //new()

    function void build();
        wdog_mis = uvm_reg_field::type_id::create("wdog_mis");
        wdog_mis.configure(this, 32, 0, "RO", 0, 32'h0, 1, 1, 1);
    endfunction: build
    
endclass //wdog_mis extends uvm_reg

// *************************************************************
// 7. WDOG_LOCK (Lock Register)
// *************************************************************
class Wdog_lock extends uvm_reg;
    `uvm_object_utils(Wdog_lock)
    
    uvm_reg_field wdog_lock;
    function new(string name = "wdog_lock");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction //new()

    function void build();
        wdog_lock = uvm_reg_field::type_id::create("wdog_lock");
        wdog_lock.configure(this, 32, 0, "RW", 0, 32'h1ACCE551, 0, 1, 1);
    endfunction: build
    
endclass //wdog_lock extends uvm_reg