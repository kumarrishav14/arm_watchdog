class wdog_reg_block extends uvm_reg_block;

    `uvm_object_utils(wdog_reg_block)
    
    // Register objects
    Wdog_load       wdog_load;
    Wdog_lock       wdog_lock;
    Wdog_value      wdog_value;
    Wdog_control    wdog_control;
    Wdog_intclr     wdog_intclr;
    Wdog_ris        wdog_ris;
    Wdog_mis        wdog_mis;

    function new(string name = "reg_file");
        super.new(name);
    endfunction //new()

    // Builds the register block
    // --> build() the registers
    // --> configure() the register
    function void build();
        
        // 1. WDOG_LOAD
        wdog_load = Wdog_load::type_id::create();
        wdog_load.build();
        wdog_load.configure(this);

        // 2. WDOG_VALUE
        wdog_value = new();
        wdog_value.build();
        wdog_value.configure(this);

        // 3. WDOG_CONTROL
        wdog_control = new();
        wdog_control.build();
        wdog_control.configure(this);

        // 4. WDOG_INTCLR
        wdog_intclr = new();
        wdog_intclr.build();
        wdog_intclr.configure(this);

        // 5. WDOG_RIS
        wdog_ris = new();
        wdog_ris.build();
        wdog_ris.configure(this);

        // 6. WDOG_MIS
        wdog_mis = new();
        wdog_mis.build();
        wdog_mis.configure(this);

        // 7. WDOG_LOCK
        wdog_lock = Wdog_lock::type_id::create();
        wdog_lock.build();
        wdog_lock.configure(this);


        // Create address map for the registers
        default_map = create_map("wdog_reg_map", 0, 4, UVM_LITTLE_ENDIAN);
        default_map.add_reg(wdog_load,      'h0,    "RW");
        default_map.add_reg(wdog_value,     'h4,    "RO");
        default_map.add_reg(wdog_control,   'h8,    "RW");
        default_map.add_reg(wdog_intclr,    'hC,    "WO");
        default_map.add_reg(wdog_ris,       'h10,   "RO");
        default_map.add_reg(wdog_mis,       'h14,   "RO");
        default_map.add_reg(wdog_lock,      'hC00,  "RW");

        lock_model();
    endfunction: build 
endclass //reg_file extends uvm_reg_file