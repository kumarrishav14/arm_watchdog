class wdog_reg_adapter extends uvm_reg_adapter;
    `uvm_object_utils(wdog_reg_adapter)


    function new(string name = "wdog_reg_adapter");
        super.new(name);
    endfunction //new()

    // reg2bus
    virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
        apb_seq_item tx;
        tx = new("tx");

        // increments the packet id everytime a register transfer is started
        tx.p_id++;

        // maps ~uvm_reg_bus_op~ to ~apb_seq_item~
        tx.PWRITE = (rw.kind == UVM_WRITE);
        tx.PADDR = rw.addr;
        if(tx.PWRITE) tx.PWDATA = rw.data;
        else tx.PRDATA = rw.data;

        return tx;
    endfunction

    // seq2bus
    virtual function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
        apb_seq_item tx;
        if(!$cast(tx, bus_item))
            `uvm_fatal(get_name(), "Cast failure in reg adapter")
        
        // maps ~apb_seq_item~ to ~uvm_reg_bus_op~ 
        rw.kind = tx.PWRITE? UVM_WRITE:UVM_READ;
        rw.addr = tx.PADDR;
        rw.data = tx.PWRITE? tx.PWDATA : tx.PRDATA;

        rw.status = UVM_IS_OK;
    endfunction
endclass //wdog_reg_adapter extends uvm_reg_adapter