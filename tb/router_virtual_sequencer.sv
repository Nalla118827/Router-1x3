class router_virtual_sequencer extends uvm_sequencer #(uvm_sequence_item);
	
	`uvm_component_utils(router_virtual_sequencer)


	router_src_sequencer src_seqr_h[];
	router_dst_sequencer dst_seqr_h[];
	router_env_config env_cfg_h;


	function new (string name="router_virtual_sequencer", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",env_cfg_h))
		`uvm_fatal("getting","failed in virtual_sequencer")


	src_seqr_h=new[env_cfg_h.no_of_src_agents];
	dst_seqr_h=new[env_cfg_h.no_of_dst_agents];
	endfunction
endclass 
				
