// Just a placeholder class for now. Needs to be implemented in detail

class wdog_monitor extends uvm_monitor;
    `uvm_component_utils(wdog_monitor)
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction //new()

    // TODO: Implement the monitor logic. Need to decide how and when
    // to send packets to scoreboard and how to sample the data.

endclass //wdog_monitor extends uvm_monitor