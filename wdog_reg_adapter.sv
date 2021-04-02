class wdog_reg_adapter extends uvm_reg_adapter;
    `uvm_object_utils(wdog_reg_adapter)


    function new(string name = "wdog_reg_adapter");
        super.new(name);
    endfunction //new()

    // reg2bus
    virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
        wdog_seq_item tx;
        tx = wdog_seq_item::type_id::create("tx");

        tx.pwrite = (rw.kind == UVM_WRITE);
        tx.paddr = rw.addr;
        if(tx.pwrite) tx.pwdata = rw.data;
        else tx.prdata = rw.data;

        return tx;
    endfunction

    // seq2bus
    virtual function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
        wdog_seq_item tx;
        if(!$cast(tx, bus_item))
            `uvm_fatal(get_name(), "Cast failure in reg adapter")
        
        rw.kind = tx.pwrite? UVM_WRITE:UVM_READ;
        rw.addr = tx.paddr;
        rw.data = tx.pwrite? tx.pwdata : tx.prdata;

        rw.status = UVM_IS_OK;
    endfunction
endclass //wdog_reg_adapter extends uvm_reg_adapter