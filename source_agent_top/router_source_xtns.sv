class router_source_xtns extends uvm_sequence_item;
	
	`uvm_object_utils(router_source_xtns)
	/*	`uvm_field_int(header,UVM_ALL_ON)
		`uvm_field_array_int(payload,UVM_ALL_ON)
		`uvm_field_int(parity,UVM_ALL_ON)
	`uvm_object_utils_end*/


	function new(string name="router_source_xtns");
		super.new(name);
	endfunction


	rand bit [7:0] header;
	rand bit [7:0] payload[];
	     bit [7:0] parity;
	
	constraint a {header[1:0]!=2'b11;}
	constraint b {header[7:2]inside{[1:63]};}
	constraint c {payload.size==header[7:2];}

	function void post_randomize();
		parity=header^8'b0;
			foreach(payload[i])
				begin
				parity=parity^payload[i];
				end
	endfunction

	function void do_print(uvm_printer printer);
		super.do_print(printer);
	   printer.print_field("header",this.header,8,UVM_DEC);
	foreach(payload[i]) begin
   	   printer.print_field($sformatf("payload[%0d]",i),this.payload[i],8,UVM_DEC);
	   end
    	   printer.print_field("parity", this.parity,8,UVM_DEC);
	endfunction
endclass
