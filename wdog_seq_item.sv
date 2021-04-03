//  Class: wdog_seq_item
//
class wdog_seq_item extends uvm_sequence_item;
    typedef wdog_seq_item this_type_t;
    `uvm_object_utils(wdog_seq_item);

    //  Group: Variables
         bit        PRESETn;
    rand bit        PWRITE;
    rand bit[31:0]  PWDATA;
    rand bit[31:0]  PRDATA;
    rand bit[31:0]  PADDR;

    //  Group: Constraints


    //  Group: Functions

    //  Constructor: new
    function new(string name = "wdog_seq_item");
        super.new(name);
        PRESETn = 1;
    endfunction: new

    //  Function: do_copy
    // extern function void do_copy(uvm_object rhs);
    //  Function: do_compare
    // extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    //  Function: convert2string
    // extern function string convert2string();
    //  Function: do_print
    extern function void do_print(uvm_printer printer);
    //  Function: do_record
    // extern function void do_record(uvm_recorder recorder);
    //  Function: do_pack
    // extern function void do_pack();
    //  Function: do_unpack
    // extern function void do_unpack();
    
endclass: wdog_seq_item


/*----------------------------------------------------------------------------*/
/*  Constraints                                                               */
/*----------------------------------------------------------------------------*/




/*----------------------------------------------------------------------------*/
/*  Functions                                                                 */
/*----------------------------------------------------------------------------*/
function void wdog_seq_item::do_print(uvm_printer printer);
    /*  chain the print with parent classes  */
    super.do_print(printer);

    /*  list of local properties to be printed:  */
    // printer.print_string("property_label", property_name);
    // printer.print_field_int("property_label", property_name, $bits(property_name), UVM_HEX);
    printer.print_field("PADDR", PADDR, $bits(PADDR), UVM_HEX);
    printer.print_field("PWRITE", PWRITE, $bits(PWRITE), UVM_HEX);
    printer.print_field("PWDATA", PWDATA, $bits(PWDATA), UVM_HEX);
endfunction: do_print

