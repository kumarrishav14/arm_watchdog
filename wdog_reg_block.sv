/*  ~wdog_reg_block~ builds all the registers and encapsulates them into
    a single block. Also defines the address map of the registers as per
    the ARM_WDOG specifications */

class wdog_reg_block extends uvm_reg_block;
    `uvm_object_utils(wdog_reg_block)
    
    // Register object pointer
    Wdog_load           wdog_load;
    Wdog_value          wdog_value;
    Wdog_control        wdog_control;
    Wdog_intclr         wdog_intclr;
    Wdog_ris            wdog_ris;
    Wdog_mis            wdog_mis;
    Wdog_lock           wdog_lock;
    Wdog_itcr           wdog_itcr;
    Wdog_itop           wdog_itop;
    Wdog_peripheral_id0 wdog_peripheral_id0;
    Wdog_peripheral_id1 wdog_peripheral_id1;
    Wdog_peripheral_id2 wdog_peripheral_id2;
    Wdog_peripheral_id3 wdog_peripheral_id3;
    Wdog_pcell_id0      wdog_pcell_id0;
    Wdog_pcell_id1      wdog_pcell_id1;
    Wdog_pcell_id2      wdog_pcell_id2;
    Wdog_pcell_id3      wdog_pcell_id3;

    function new(string name = "reg_file");
        super.new(name);
    endfunction //new()

    // Function to build the register block
    // --> build() individual registers
    // --> configure() individual register
    function void build();
        
        // 1. WDOG_LOAD
        wdog_load = new();
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
        wdog_lock = new();
        wdog_lock.build();
        wdog_lock.configure(this);

        // 8. WDOG_ITCR
        wdog_itcr = new();
        wdog_itcr.build();
        wdog_itcr.configure(this);

        // 9. WDOG_ITOP
        wdog_itop = new();
        wdog_itop.build();
        wdog_itop.configure(this);

        // 10. WDOG_PERIPHERAL_ID0
        wdog_peripheral_id0 = new();
        wdog_peripheral_id0.build();
        wdog_peripheral_id0.configure(this);

        // 11. WDOG_PERIPHERAL_ID1
        wdog_peripheral_id1 = new();
        wdog_peripheral_id1.build();
        wdog_peripheral_id1.configure(this);

        // 12. WDOG_PERIPHERAL_ID2
        wdog_peripheral_id2 = new();
        wdog_peripheral_id2.build();
        wdog_peripheral_id2.configure(this);

        // 13. WDOG_PERIPHERAL_ID3
        wdog_peripheral_id3 = new();
        wdog_peripheral_id3.build();
        wdog_peripheral_id3.configure(this);

        // 14. WDOG_PCELL_ID0
        wdog_pcell_id0 = new();
        wdog_pcell_id0.build();
        wdog_pcell_id0.configure(this);

        // 15. WDOG_PCELL_ID1
        wdog_pcell_id1 = new();
        wdog_pcell_id1.build();
        wdog_pcell_id1.configure(this);

        // 16. WDOG_PCELL_ID2
        wdog_pcell_id2 = new();
        wdog_pcell_id2.build();
        wdog_pcell_id2.configure(this);

        // 17. WDOG_PCELL_ID3
        wdog_pcell_id3 = new();
        wdog_pcell_id3.build();
        wdog_pcell_id3.configure(this);


        // ******************************************************************************************************
        // Create address map for the registers
        // ******************************************************************************************************
        // create_map(string name, 	uvm_reg_addr_t base_addr, int unsigned n_bytes,uvm_endianness_e endian) 
        default_map = create_map("wdog_reg_map", 0, 4, UVM_LITTLE_ENDIAN);

        //          add_reg(uvm_reg rg,	uvm_reg_addr_t offset, string rights = 	"RW")
        default_map.add_reg(wdog_load,              'h0,    "RW");
        default_map.add_reg(wdog_value,             'h4,    "RO");
        default_map.add_reg(wdog_control,           'h8,    "RW");
        default_map.add_reg(wdog_intclr,            'hC,    "WO");
        default_map.add_reg(wdog_ris,               'h10,   "RO");
        default_map.add_reg(wdog_mis,               'h14,   "RO");
        default_map.add_reg(wdog_lock,              'hC00,  "RW");
        default_map.add_reg(wdog_itcr,              'hF00,  "RW");
        default_map.add_reg(wdog_itop,              'hF04,  "WO");
        default_map.add_reg(wdog_peripheral_id0,    'hFE0,  "RO");
        default_map.add_reg(wdog_peripheral_id1,    'hFE4,  "RO");
        default_map.add_reg(wdog_peripheral_id2,    'hFE8,  "RO");
        default_map.add_reg(wdog_peripheral_id3,    'hFEC,  "RO");
        default_map.add_reg(wdog_pcell_id0,         'hFF0,  "RO");
        default_map.add_reg(wdog_pcell_id1,         'hFF4,  "RO");
        default_map.add_reg(wdog_pcell_id2,         'hFF8,  "RO");
        default_map.add_reg(wdog_pcell_id3,         'hFFC,  "RO");

        // Model needs to be locked before it can be used in test bench
        lock_model();
    endfunction: build 
endclass //reg_file extends uvm_reg_file