class router_src_seqs extends uvm_sequence #(router_source_xtns);

	`uvm_object_utils(router_src_seqs)
	

	function new(string name = "router_src_seqs");
         super.new(name);
        endfunction
		

endclass


//Seq-1 SMALL PACKETS


class small_packets_src extends router_src_seqs;
	
	`uvm_object_utils(small_packets_src)
	
	 bit [1:0] addr;

	function new(string name="small_packets_src");
		super.new(name);
	endfunction

	task body();
	//	repeat(5)
		begin
		uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit",addr);

		req=router_source_xtns::type_id::create("req");

		start_item(req);
	
		assert(req.randomize() with {header[1:0]==addr; header[7:2] inside{[1:20]};});
	//	$display(req);
		finish_item(req);
		end
	endtask

endclass



//seq-2 MEDIUM PACKETS


class medium_packets_src extends router_src_seqs;
	
	`uvm_object_utils(medium_packets_src)

	 bit [1:0] addr;


	function new(string name="medium_packets_src");
		super.new(name);
	endfunction

	task body();
		begin

		uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit",addr);


		req=router_source_xtns::type_id::create("req");

		start_item(req);
	
		assert(req.randomize() with {header[1:0]==addr; header[7:2]inside {[21:40]};});

		finish_item(req);
		end
	endtask

endclass


//seq-3 HIGH PACKETS

class high_packets_src extends router_src_seqs;
	
	`uvm_object_utils(high_packets_src)

	 bit [1:0] addr;


	function new(string name="high_packets_src");
		super.new(name);
	endfunction

	task body();
		begin


		uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit",addr);


		req=router_source_xtns::type_id::create("req");

		start_item(req);
	
		assert(req.randomize() with {header[1:0]==addr; header[7:2] inside {[41:62]};});

		finish_item(req);
		end
	endtask

endclass


