class router_dst_seqs extends uvm_sequence #(router_dst_xtns);
	
	`uvm_object_utils(router_dst_seqs)

	function new(string name = "router_dst_seqs");
         super.new(name);
        endfunction

endclass


//Seq-1 SMALL PACKETS


class small_packets_dst extends router_dst_seqs;
	
	`uvm_object_utils(small_packets_dst)

	function new(string name="small_packets_dst");
		super.new(name);
	endfunction

	task body();
	//	repeat(5)
		begin
		req=router_dst_xtns::type_id::create("req");

		start_item(req);
	
		assert(req.randomize() with {no_of_cycle inside {[1:28]};})


		finish_item(req);
		end
	endtask

endclass



//seq-2 MEDIUM PACKETS


class medium_packets_dst extends router_dst_seqs;
	
	`uvm_object_utils(medium_packets_dst)

	function new(string name="medium_packets_dst");
		super.new(name);
	endfunction

	task body();
		begin
		req=router_dst_xtns::type_id::create("req");

		start_item(req);
	
		assert(req.randomize() with {no_of_cycle inside {[1:28]};})


		finish_item(req);
		end
	endtask

endclass


//seq-3 HIGH PACKETS

class high_packets_dst extends router_dst_seqs;
	
	`uvm_object_utils(high_packets_dst)

	function new(string name="high_packets_dst");
		super.new(name);
	endfunction

	task body();
		begin
		req=router_dst_xtns::type_id::create("req");

		start_item(req);
	
		assert(req.randomize() with {no_of_cycle inside {[1:28]};})


		finish_item(req);
		end
	endtask

endclass


