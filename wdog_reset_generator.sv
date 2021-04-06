//  Class: wdog_reset_generator
//
class wdog_reset_generator extends uvm_component;
    `uvm_component_utils(wdog_reset_generator);

    //  Group: Configuration Object(s)
    env_config env_cfg;


    //  Group: Components
    virtual wdog_intf intf;


    //  Constructor: new
    function new(string name = "wdog_reset_generator", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    task reset_frc();
        intf.WDOGRESn <= 0;
        #1;
        @(posedge intf.wdogclk);
        intf.WDOGRESn <= 1;
    endtask

    task reset_module();
        intf.PRESETn <= 0;
        #1;
        @(posedge intf.pclk);
        intf.PRESETn <= 1;
    endtask

    function void build_phase(uvm_phase phase);    
        if (!uvm_config_db#(env_config)::get(this, "", "env_cfg", env_cfg)) 
            `uvm_fatal(get_name(), "env_cfg cannot be found in ConfigDB!")
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    
        intf = env_cfg.intf;
    endfunction: connect_phase   
endclass: wdog_reset_generator
