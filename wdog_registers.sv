/*  ~wdog_register~ contains various registers which are present in the
    AMR_WDOG module */

// FOR REFERENCE: Funtion definition of configure(). FOR REFERENCE
//  function void configure(
//                  uvm_reg 	                parent,
//                  int 	        unsigned 	size,
//                  int 	        unsigned 	lsb_pos,
//                  string 	                    access,
//                  bit 	                    volatile,
//                  uvm_reg_data_t 	            reset,
//                  bit 	                    has_reset,
//                  bit 	                    is_rand,
//                  bit 	                    individually_accessible)
// ********************************************************************************
// 1. WDOG_LOAD (Load Register)
// ********************************************************************************
class Wdog_load extends uvm_reg;
    `uvm_object_utils(Wdog_load)
    
    rand uvm_reg_field wdog_load;

    function new(string name = "wdog_load");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction //new()

    function void build();   
        wdog_load = uvm_reg_field::type_id::create("wdog_load");
        wdog_load.configure(this, 32, 0, "RW", 0, 32'hFFFFFFFF, 1, 1, 0);
    endfunction: build
endclass //Wdog_load extends uvm_reg


// ********************************************************************************
// 2. WDOG_Value (Vaue Register)
// ********************************************************************************
class Wdog_value extends uvm_reg;
    `uvm_object_utils(Wdog_value)
    
    uvm_reg_field wdog_value;
    function new(string name = "wdog_value");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction //new()

    function void build();
        wdog_value = uvm_reg_field::type_id::create("wdog_value");
        wdog_value.configure(this, 32, 0, "RO", 1, 32'hFFFFFFFF, 1, 0, 0);
    endfunction: build
    
endclass //wdog_value extends uvm_reg


// ********************************************************************************
// 3. WDOG_Control (Control Register)
//    WDOG_Control[0] = inten
//    WDOG_Control[1] = resen
// ********************************************************************************
class Wdog_control extends uvm_reg;
    `uvm_object_utils(Wdog_value)
    
    rand uvm_reg_field inten;
    rand uvm_reg_field resen;

    function new(string name = "wdog_value");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction //new()

    function void build();
        // Build ~inten~ field and configure it  
        inten = uvm_reg_field::type_id::create("inten");
        inten.configure(this, 1, 0, "RW", 0, 1'h0, 1, 1, 0);

        // Build ~resen~ field and configure it
        resen = uvm_reg_field::type_id::create("resen");
        resen.configure(this, 1, 1, "RW", 0, 1'h0, 1, 1, 0);
    endfunction: build
endclass //wdog_control extends uvm_reg


// ********************************************************************************
// 4. WDOG_INTCLR (Interupt Clear Register)
// ********************************************************************************
class Wdog_intclr extends uvm_reg;
    // `uvm_object_utils(Wdog_intclr)
    
    uvm_reg_field wdog_intclr;
    function new(string name = "wdog_intclr");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction //new()

    function void build();
        wdog_intclr = uvm_reg_field::type_id::create("wdog_intclr");
        wdog_intclr.configure(this, 32, 0, "WO", 0, 32'h0, 0, 1, 0);
    endfunction: build
    
endclass //wdog_intclr extends uvm_reg

// ********************************************************************************
// 5. WDOG_RIS (Raw Interrupt Register)
// ********************************************************************************
class Wdog_ris extends uvm_reg;
    // `uvm_object_utils(Wdog_ris)
    
    uvm_reg_field wdog_ris;
    function new(string name = "wdog_ris");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction //new()

    function void build();
        wdog_ris = uvm_reg_field::type_id::create("wdog_ris");
        wdog_ris.configure(this, 1, 0, "RO", 1, 1'h0, 1, 0, 0);
    endfunction: build
endclass //wdog_ris extends uvm_reg


// ********************************************************************************
// 6. WDOG_MIS(Masked Interrupt Register)
// ********************************************************************************
class Wdog_mis extends uvm_reg;
    `uvm_object_utils(Wdog_mis)
    
    uvm_reg_field wdog_mis;
    function new(string name = "wdog_mis");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction //new()

    function void build();
        wdog_mis = uvm_reg_field::type_id::create("wdog_mis");
        wdog_mis.configure(this, 1, 0, "RO", 1, 1'h0, 1, 0, 0);
    endfunction: build
endclass //wdog_mis extends uvm_reg

// ********************************************************************************
// 7. WDOG_LOCK (Lock Register)
// ********************************************************************************
class Wdog_lock extends uvm_reg;
    `uvm_object_utils(Wdog_lock)
    
    uvm_reg_field wdog_lock;
    function new(string name = "wdog_lock");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction //new()

    function void build();
        wdog_lock = uvm_reg_field::type_id::create("wdog_lock");
        wdog_lock.configure(this, 32, 0, "RW", 0, 32'h0, 1, 1, 0);
    endfunction: build
    
endclass //wdog_lock extends uvm_reg

// ********************************************************************************
// 8. WDOG_ITCR (Integrtion Test Control Register)
// ********************************************************************************
class Wdog_itcr extends uvm_reg;
    `uvm_object_utils(Wdog_itcr)
    
    uvm_reg_field iten;
    function new(string name = "wdog_itcr");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction //new()

    function void build();
        iten = uvm_reg_field::type_id::create("iten");
        iten.configure(this, 1, 0, "RW", 0, 1'h0, 1, 1, 1);
    endfunction: build
    
endclass //wdog_itcr extends uvm_reg


// ********************************************************************************
// 9. WDOG_ITOP (Integration Test Output Set Register)
// ********************************************************************************
class Wdog_itop extends uvm_reg;
    `uvm_object_utils(Wdog_itop)
    
    uvm_reg_field wdogint;
    uvm_reg_field wdogres;
    function new(string name = "wdog_itop");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction //new()

    function void build();
        wdogres = uvm_reg_field::type_id::create("wdogres");
        wdogres.configure(this, 1, 0, "WO", 0, 32'h0, 1, 1, 0);

        wdogint = uvm_reg_field::type_id::create("wdogint");
        wdogint.configure(this, 1, 1, "WO", 0, 32'h0, 1, 1, 0);
    endfunction: build
    
endclass //wdog_itop extends uvm_reg


// ********************************************************************************
// 10. WDOG_PERIPHERAL_ID0 (Peripheral ID Register)
// ********************************************************************************
class Wdog_peripheral_id0 extends uvm_reg;
    `uvm_object_utils(Wdog_peripheral_id0)
    
    uvm_reg_field part_number0;
    function new(string name = "wdog_peripheral_id0");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction //new()

    function void build();
        part_number0 = uvm_reg_field::type_id::create("part_number0");
        part_number0.configure(this, 8, 0, "RO", 0, 32'h05, 1, 0, 0);
    endfunction: build
    
endclass //wdog_peripheral_id0 extends uvm_reg


// ********************************************************************************
// 11. WDOG_PERIPHERAL_ID1 (Peripheral ID Register)
// ********************************************************************************
class Wdog_peripheral_id1 extends uvm_reg;
    `uvm_object_utils(Wdog_peripheral_id1)
    
    uvm_reg_field part_number1;
    uvm_reg_field designer0;
    function new(string name = "wdog_peripheral_id1");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction //new()

    function void build();
        part_number1 = uvm_reg_field::type_id::create("part_number1");
        part_number1.configure(this, 4, 0, "RO", 0, 32'h08, 1, 0, 0);

        designer0 = uvm_reg_field::type_id::create("designer0");
        designer0.configure(this, 4, 4, "RO", 0, 32'h01, 1, 0, 0);
    endfunction: build
    
endclass //wdog_peripheral_id1 extends uvm_reg


// ********************************************************************************
// 12. WDOG_PERIPHERAL_ID2 (Peripheral ID Register)
// ********************************************************************************
class Wdog_peripheral_id2 extends uvm_reg;
    `uvm_object_utils(Wdog_peripheral_id2)
    
    uvm_reg_field designer1;
    uvm_reg_field revision;
    function new(string name = "wdog_peripheral_id2");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction //new()

    function void build();
        designer1 = uvm_reg_field::type_id::create("designer1");
        designer1.configure(this, 4, 0, "RO", 0, 4'h4, 1, 0, 0);

        revision = uvm_reg_field::type_id::create("revision");
        revision.configure(this, 4, 4, "RO", 0, 32'h1, 1, 0, 0);
    endfunction: build
    
endclass //wdog_peripheral_id2 extends uvm_reg


// ********************************************************************************
// 13. WDOG_PERIPHERAL_ID3 (Peripheral ID Register)
// ********************************************************************************
class Wdog_peripheral_id3 extends uvm_reg;
    `uvm_object_utils(Wdog_peripheral_id3)
    
    uvm_reg_field configuration;
    function new(string name = "wdog_peripheral_id3");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction //new()

    function void build();
        configuration = uvm_reg_field::type_id::create("configuration");
        configuration.configure(this, 8, 0, "RO", 0, 32'h00, 1, 0, 0);
    endfunction: build
    
endclass //wdog_peripheral_id3 extends uvm_reg


// ********************************************************************************
// 14. WDOG_PCELL_ID0 (PCELL ID Register)
// ********************************************************************************
class Wdog_pcell_id0 extends uvm_reg;
    `uvm_object_utils(Wdog_pcell_id0)
    
    uvm_reg_field wdog_pcell_id0;
    function new(string name = "wdog_pcell_id0");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction //new()

    function void build();
        wdog_pcell_id0 = uvm_reg_field::type_id::create("wdog_pcell_id0");
        wdog_pcell_id0.configure(this, 8, 0, "RO", 0, 8'h0D, 1, 0, 0);
    endfunction: build
    
endclass //wdog_pcell_id0 extends uvm_reg


// ********************************************************************************
// 15. WDOG_PCELL_ID1 (PCELL ID Register)
// ********************************************************************************
class Wdog_pcell_id1 extends uvm_reg;
    `uvm_object_utils(Wdog_pcell_id1)
    
    uvm_reg_field wdog_pcell_id1;
    function new(string name = "wdog_pcell_id1");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction //new()

    function void build();
        wdog_pcell_id1 = uvm_reg_field::type_id::create("wdog_pcell_id1");
        wdog_pcell_id1.configure(this, 8, 0, "RO", 0, 8'hF0, 1, 0, 0);
    endfunction: build
    
endclass //wdog_pcell_id1 extends uvm_reg


// ********************************************************************************
// 16. WDOG_PCELL_ID2 (PCELL ID Register)
// ********************************************************************************
class Wdog_pcell_id2 extends uvm_reg;
    `uvm_object_utils(Wdog_pcell_id2)
    
    uvm_reg_field wdog_pcell_id2;
    function new(string name = "wdog_pcell_id2");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction //new()

    function void build();
        wdog_pcell_id2 = uvm_reg_field::type_id::create("wdog_pcell_id2");
        wdog_pcell_id2.configure(this, 8, 0, "RO", 0, 8'h05, 1, 0, 0);
    endfunction: build
    
endclass //wdog_pcell_id2 extends uvm_reg


// ********************************************************************************
// 17. WDOG_PCELL_ID3 (PCELL ID Register)
// ********************************************************************************
class Wdog_pcell_id3 extends uvm_reg;
    `uvm_object_utils(Wdog_pcell_id3)
    
    uvm_reg_field wdog_pcell_id3;
    function new(string name = "wdog_pcell_id3");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction //new()

    function void build();
        wdog_pcell_id3 = uvm_reg_field::type_id::create("wdog_pcell_id3");
        wdog_pcell_id3.configure(this, 8, 0, "RO", 0, 8'hB1, 1, 0, 0);
    endfunction: build
    
endclass //wdog_pcell_id3 extends uvm_reg