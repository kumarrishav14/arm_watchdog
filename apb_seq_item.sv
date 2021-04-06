//  Class: apb_seq_item
//
class apb_seq_item extends uvm_sequence_item;
    typedef apb_seq_item this_type_t;
    `uvm_object_utils(apb_seq_item);

    //  Group: Variables
         bit        PRESETn;
    rand bit        PWRITE;
    rand bit [31:0] PWDATA;
    rand bit [31:0] PRDATA;
    rand bit [31:0] PADDR;

         bit [10:0] p_id; 
         bit        is_ip_pckt; 

    //  Group: Constraints


    //  Group: Functions

    //  Constructor: new
    function new(string name = "apb_seq_item");
        super.new(name);
        PRESETn = 1;
    endfunction: new

    //  Function: do_copy
    extern function void do_copy(uvm_object rhs);
    //  Function: do_compare
    extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
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
    
endclass: apb_seq_item


/*----------------------------------------------------------------------------*/
/*  Constraints                                                               */
/*----------------------------------------------------------------------------*/




/*----------------------------------------------------------------------------*/
/*  Functions                                                                 */
/*----------------------------------------------------------------------------*/
function void apb_seq_item::do_print(uvm_printer printer);
    /*  chain the print with parent classes  */
    super.do_print(printer);

    /*  list of local properties to be printed:  */
    // printer.print_string("property_label", property_name);
    // printer.print_field_int("property_label", property_name, $bits(property_name), UVM_HEX);
    printer.print_field("PRESETn",PRESETn,$bits(PRESETn),UVM_BIN);
    printer.print_field("PADDR",  PADDR,  $bits(PADDR),  UVM_HEX);
    printer.print_field("PWRITE", PWRITE, $bits(PWRITE), UVM_HEX);
    printer.print_field("PWDATA", PWDATA, $bits(PWDATA), UVM_HEX);
    printer.print_field("PRDATA", PRDATA, $bits(PRDATA), UVM_HEX);
    printer.print_field("is_ip_pckt", is_ip_pckt, $bits(is_ip_pckt), UVM_BIN);
endfunction: do_print


function void apb_seq_item::do_copy(uvm_object rhs);
    this_type_t rhs_;

    if (!$cast(rhs_, rhs)) begin
        `uvm_error({this.get_name(), ".do_copy()"}, "Cast failed!");
        return;
    end
    // `uvm_info({this.get_name(), ".do_copy()"}, "Cast succeded.", UVM_HIGH);

    /*  chain the copy with parent classes  */
    super.do_copy(rhs);

    /*  list of local properties to be copied  */
    // <this.property_name = rhs_.property_name>
    this.PRESETn    = rhs_.PRESETn;
    this.PWDATA     = rhs_.PWDATA;
    this.PWRITE     = rhs_.PWRITE;
    this.PADDR      = rhs_.PADDR;
    this.PRDATA     = rhs_.PRDATA;
    this.p_id       = rhs_.p_id;
    this.is_ip_pckt = rhs_.is_ip_pckt;
endfunction: do_copy



function bit apb_seq_item::do_compare(uvm_object rhs, uvm_comparer comparer);
    this_type_t rhs_;

    if (!$cast(rhs_, rhs)) begin
        `uvm_fatal({this.get_name(), ".do_compare()"}, "Cast failed!");
    end

    /*  chain the compare with parent classes  */
    do_compare = super.do_compare(rhs, comparer);

    /*  list of local properties to be compared:  */
    do_compare &= (
        this.PWRITE == rhs_.PWRITE &&
        this.PWDATA == rhs_.PWDATA &&
        this.PRDATA == rhs_.PRDATA &&
        this.PADDR == rhs_.PADDR &&
        this.p_id == rhs_.p_id
    );
endfunction: do_compare

