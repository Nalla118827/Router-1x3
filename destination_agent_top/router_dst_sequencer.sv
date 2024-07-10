class router_dst_sequencer extends uvm_sequencer #(router_dst_xtns);
		
	`uvm_component_utils(router_dst_sequencer)

	function new(string name = "router_dst_sequencer", uvm_component parent);
         super.new(name, parent);
        endfunction

endclass
