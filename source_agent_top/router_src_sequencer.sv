class router_src_sequencer extends uvm_sequencer #(router_source_xtns);

	`uvm_component_utils(router_src_sequencer)

	
	function new(string name = "router_src_sequencer", uvm_component parent);
         super.new(name, parent);
        endfunction

endclass

