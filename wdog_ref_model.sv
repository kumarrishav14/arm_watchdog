//  Class: wdog_ref_model
//
class wdog_ref_model extends uvm_component;
    `uvm_component_utils(wdog_ref_model);

    //  Group: Components
    virtual wdog_intf.WDOG_MON intf;
    virtual wdog_intf intf_pclk;
    env_config env_cfg;

    // *****************************************************************
    //  Group: Address Constants
    // *****************************************************************
    `define WDOG_LOAD_A             12'h000
    `define WDOG_VALUE_A            12'h004
    `define WDOG_CONTROL_A          12'h008
    `define WDOG_INTCLR_A           12'h00C
    `define WDOG_RIS_A              12'h010
    `define WDOG_MIS_A              12'h014
    `define WDOG_LOCK_A             12'hC00
    `define WDOG_ITCR_A             12'hF00
    `define WDOG_ITOP_A             12'hF04
    `define WDOG_PERIPHERAL_ID0_A   12'hFE0
    `define WDOG_PERIPHERAL_ID1_A   12'hFE4
    `define WDOG_PERIPHERAL_ID2_A   12'hFE8
    `define WDOG_PERIPHERAL_ID3_A   12'hFEC
    `define WDOG_PCELL_ID0_A        12'hFF0
    `define WDOG_PCELL_ID1_A        12'hFF4
    `define WDOG_PCELL_ID2_A        12'hFF8
    `define WDOG_PCELL_ID3_A        12'hFFC
    

    // *****************************************************************
    //  Group: Variables
    // *****************************************************************
    // Registers to configure model
    reg [31:0] wdog_load;
    reg [31:0] wdog_value;
    reg [1:0]  wdog_control;
    reg [31:0] wdog_intclr;
    reg        wdog_ris;
    reg        wdog_mis;
    reg [31:0] wdog_lock;
    reg        wdog_itcr;
    reg [1:0]  wdog_itop;
    reg [8:0]  wdog_peripheral_id0;
    reg [8:0]  wdog_peripheral_id1;
    reg [8:0]  wdog_peripheral_id2;
    reg [8:0]  wdog_peripheral_id3;
    reg [8:0]  wdog_pcell_id0;
    reg [8:0]  wdog_pcell_id1;
    reg [8:0]  wdog_pcell_id2;
    reg [8:0]  wdog_pcell_id3;

    // counter
    bit [31:0] counter;
    
    // WDOG variables
    bit WDOGINT;
    bit WDOGRES;

    // event
    event reset_counter;

    // Internal variables
    bit wdog_inten_rise;
    bit wdog_inten_prev;

    // sampled value
    reg [31:0] sampled_value;
    reg [31:0] sampled_prev_value;
    
    // *****************************************************************
    //  Group: Functions
    // *****************************************************************
    function void write_reg_value(bit [11:0] paddr, bit [31:0] pwdata);
        
        if(paddr == `WDOG_LOCK_A) begin
            wdog_lock = pwdata == 32'h1ACCE551 ? 0 : 1;
            return;
        end
        // If wdog_lock is 1 no other register are accessible for write
        if(wdog_lock)
            return;

        case (paddr)
            `WDOG_LOAD_A: begin 
                            wdog_load = pwdata;
                            wdog_value = pwdata;
                            counter = wdog_value;
                        end
            `WDOG_CONTROL_A: begin
                            wdog_control = pwdata[1:0];
                            wdog_inten_rise = !wdog_inten_prev & wdog_control[0];
                            wdog_inten_prev = wdog_control[0];
                            if(wdog_inten_rise)
                                ->reset_counter;
            end
                         
            `WDOG_INTCLR_A: begin
                            wdog_intclr = pwdata;
                            if(~WDOGRES)
                                ->reset_counter;
            end
            `WDOG_ITCR_A: wdog_itcr = pwdata[0];
            `WDOG_ITOP_A: wdog_itop = pwdata[1:0];
        endcase
    endfunction

    function bit [31:0] read_reg_value(bit [11:0] paddr);
        `uvm_info(get_name(), "reading value from reg", UVM_HIGH)
        
        case (paddr)
            `WDOG_LOAD_A:           return wdog_load;
            `WDOG_VALUE_A:          return sampled_value;
            `WDOG_CONTROL_A:        return wdog_control;
            `WDOG_RIS_A:            return wdog_ris;
            `WDOG_MIS_A:            return wdog_mis;
            `WDOG_LOCK_A:           return wdog_lock;
            `WDOG_ITCR_A:           return wdog_itcr;
            `WDOG_PERIPHERAL_ID0_A: return wdog_peripheral_id0;
            `WDOG_PERIPHERAL_ID1_A: return wdog_peripheral_id1;
            `WDOG_PERIPHERAL_ID2_A: return wdog_peripheral_id2;
            `WDOG_PERIPHERAL_ID3_A: return wdog_peripheral_id3;
            `WDOG_PCELL_ID0_A:      return wdog_pcell_id0;
            `WDOG_PCELL_ID1_A:      return wdog_pcell_id1;
            `WDOG_PCELL_ID2_A:      return wdog_pcell_id2;
            `WDOG_PCELL_ID3_A:      return wdog_pcell_id3;
            default:                return 32'h0;
        endcase
    endfunction

    function wdog_seq_item get_wdog_value();
        
    endfunction

    function void counter_reset(bit trigger_reset_event);
        `uvm_info(get_name(), "Resetting counter", UVM_HIGH)
        
        wdog_value  = wdog_load;
        wdog_ris    = 0;
        wdog_mis    = 0;
        WDOGINT     = 0;

        if(trigger_reset_event)
            ->reset_counter;
    endfunction

    function void module_reset();
        `uvm_info(get_name(), "Reseting watchdog module", UVM_HIGH)
        
        wdog_load       = 32'hFFFFFFFF;
        wdog_value      = wdog_load;
        wdog_control    = 2'b00;
        wdog_lock       = 0;
        WDOGRES         = 0;
        wdog_inten_prev = wdog_control[0];
        wdog_inten_rise = 0;
    endfunction

    task run_counter();
        counter = wdog_load;
        // as monitor returns the value for the previous clock
        // @(intf.wdog_mon_cb);
        forever begin 
            @(intf.wdog_mon_cb);
            if(intf.wdog_mon_cb.WDOGCLKEN) begin
                `uvm_info(get_name(), "decrementing counter", UVM_DEBUG)
                
                counter -= 1;
                wdog_value = counter; 
                `uvm_info(get_name(), $sformatf("counter value is %0h, wdog_value is %0h", counter, wdog_value), UVM_DEBUG)   
            end
            
            if(counter == 0 && !wdog_ris) begin
                @(intf.wdog_mon_cb);
                wdog_ris = 1;
                wdog_mis = wdog_ris & wdog_control[0];
                WDOGINT = 1;
                counter = wdog_load;
                wdog_value = counter;
                // @(intf.wdog_mon_cb);
            end
            else if(counter == 0 && wdog_ris) begin
                @(intf.wdog_mon_cb);
                WDOGRES = wdog_control[1] ? 1:0;
                counter = wdog_load;
                sampled_value = counter;
                return;
            end
            
        end
    endtask

    task sample_values_at_pclk();
        forever begin
            @(posedge intf_pclk.pclk);
            // #1;
            `uvm_info(get_name(), $sformatf("counter value is %0h, wdog_value is %0h in sample function", counter, wdog_value), UVM_DEBUG) 
            sampled_value = counter;
            sampled_prev_value <= sampled_value;
            `uvm_info(get_name(), $sformatf("sampled value is %0h, prev_value is %0h", sampled_value, sampled_prev_value), UVM_DEBUG)
            
        end
    endtask

    //  Constructor: new
    function new(string name = "wdog_ref_model", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    //  Function: build_phase
    extern function void build_phase(uvm_phase phase);
    
    //  Function: start_of_simulation_phase
    extern function void start_of_simulation_phase(uvm_phase phase);
    
    //  Function: run_phase
    extern task run_phase(uvm_phase phase);
    
endclass: wdog_ref_model

function void wdog_ref_model::build_phase(uvm_phase phase);
    wdog_pcell_id0 = 8'h0D;
    wdog_pcell_id1 = 8'hF0;
    wdog_pcell_id2 = 8'h05;
    wdog_pcell_id3 = 8'hB1;
endfunction: build_phase


function void wdog_ref_model::start_of_simulation_phase(uvm_phase phase);
    super.start_of_simulation_phase(phase);
    intf = env_cfg.intf;
    intf_pclk = env_cfg.intf;

    wdog_peripheral_id0 = env_cfg.peripheral_id0;
    wdog_peripheral_id1 = env_cfg.peripheral_id1;
    wdog_peripheral_id2 = env_cfg.peripheral_id2;
    wdog_peripheral_id3 = env_cfg.peripheral_id3;
endfunction: start_of_simulation_phase

task wdog_ref_model::run_phase(uvm_phase phase);
    fork
        sample_values_at_pclk();
    join_none
    forever begin
        if(wdog_inten_rise)
            @(intf.wdog_mon_cb);

        if(wdog_control[0]) begin
            // @(intf.wdog_mon_cb)
            fork
                run_counter();
            join_none
            @(reset_counter);
            disable fork;
            counter_reset(0);    
        end
        else #1;
    end
endtask: run_phase

