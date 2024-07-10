class router_env_config extends uvm_object;
		
	`uvm_object_utils(router_env_config)

	function new(string name="router_env_config");
		super.new(name);
	endfunction

	int has_no_of_scoreboard;
	int has_no_of_source_agent_tops;
	int has_no_of_destination_agent_tops;
	int has_no_of_virtual_sequencer;
   
 	int no_of_src_agents;  // It will get the value from TEST , by assign
 	int no_of_dst_agents;  // It will get the value from TEST , by assign

	router_src_agent_config src_agt_cfg_h[];
	router_dst_agent_config dst_agt_cfg_h[];


endclass
