//  Class: wdog_seq_item
//
class wdog_seq_item extends uvm_sequence_item;
    typedef wdog_seq_item this_type_t;
    `uvm_object_utils(wdog_seq_item);

    //  Group: Variables
    rand bit WDOGCLKEN;
         bit WDOGRESn;
         bit WDOGINT;
         bit WDOGRES;

    //  Group: Constraints


    //  Group: Functions

    //  Constructor: new
    function new(string name = "wdog_seq_item");
        super.new(name);
    endfunction: new

    //  Function: do_copy
    // extern function void do_copy(uvm_object rhs);
    //  Function: do_compare
    // extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    //  Function: convert2string
    extern function string convert2string();
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
function string wdog_seq_item::convert2string();
    string s;

    /*  chain the convert2string with parent classes  */
    s = super.convert2string();

    /*  list of local properties to be printed:  */
    //  guide          0---4---8--12--16--20--24--28--32--36--40--44--48--
    // s = {s, $sformatf("property_label      : 0x%0h\n", property_name)};
    s = {s, $sformatf("WDOGCLKEN    :   %b\n", WDOGCLKEN)};
    s = {s, $sformatf("WDOGRESn     :   %b\n", WDOGRESn)};
    s = {s, $sformatf("WDOGINT      :   %b\n", WDOGINT)};
    s = {s, $sformatf("WDOGRES      :   %b\n", WDOGRES)};

    return s;
endfunction: convert2string


function void wdog_seq_item::do_print(uvm_printer printer);
    /*  chain the print with parent classes  */
    super.do_print(printer);

    /*  list of local properties to be printed:  */
    // printer.print_string("property_label", property_name);
    printer.print_field("WDOGCLKEN",   WDOGCLKEN,  $bits(WDOGCLKEN),   UVM_BIN);
    printer.print_field("WDOGRESn",    WDOGRESn,   $bits(WDOGRESn),    UVM_BIN);
    printer.print_field("WDOGINT",     WDOGINT,    $bits(WDOGINT),     UVM_BIN);
    printer.print_field("WDOGRES",     WDOGRES,    $bits(WDOGRES),     UVM_BIN);
    
endfunction: do_print

