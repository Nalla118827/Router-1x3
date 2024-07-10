class router_dst_agent_config extends uvm_object;
	
	`uvm_object_utils(router_dst_agent_config)

	function new(string name="router_dst_agent_config");
		super.new(name);
	endfunction
	
	virtual router_dst_if dif;
//	int  has_no_of_agents;
	uvm_active_passive_enum is_active=UVM_ACTIVE;

endclass
