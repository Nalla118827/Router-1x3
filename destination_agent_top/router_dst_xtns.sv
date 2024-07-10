class router_dst_xtns extends uvm_sequence_item;
	
	`uvm_object_utils(router_dst_xtns)

	function new(string name="router_dst_xtns");
		super.new(name);
	endfunction

	bit valid_out;
	bit read_enb;
	bit[7:0] header;
	bit[7:0] payload[];
	bit[7:0] parity;
	rand bit [5:0] no_of_cycle;

 
  function void do_print(uvm_printer printer);
	super.do_print(printer);

	printer.print_field("header",this.header,8,UVM_DEC);
	foreach(payload[i]) 
	begin
	printer.print_field($sformatf("payload[%0d]",i),this.payload[i],8,UVM_DEC);
	end
        printer.print_field("parity",this.parity,8,UVM_DEC);

	printer.print_field("valid_out",this.valid_out,1,UVM_DEC);
	printer.print_field("read_enb",this.read_enb,1,UVM_DEC);
	printer.print_field("no_of_cycle",this.no_of_cycle,6,UVM_DEC);

  endfunction




endclass
