class router_src_agent_config extends uvm_object;

	`uvm_object_utils(router_src_agent_config)

	function new(string name = "router_src_agent_config");
         super.new(name);
        endfunction
	
	virtual router_src_if sif;
	//bit router_src_agent=1;
	uvm_active_passive_enum is_active=UVM_ACTIVE;

endclass

