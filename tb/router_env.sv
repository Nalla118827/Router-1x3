class router_env extends uvm_env;

	`uvm_component_utils(router_env)
	
	router_scoreboard sb_h[];
 	router_dst_agt_top dst_agt_top_h[];
	router_src_agt_top src_agt_top_h[];
	router_env_config env_cfg_h;
	router_src_agent_config src_agt_cfg_h;
	router_virtual_sequencer v_seqr_h;
		
	function new (string name="router_env",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		v_seqr_h=router_virtual_sequencer::type_id::create("v_seqr_h",this);
		router_config_agt_tops();
		endfunction
	
	function router_config_agt_tops();

      // we get the env_config for creating how many no. of  scoreboard, source_agent_top ,Destination_agent_tops and if requied v_sequencers we need to create with according to UVM 

		if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",env_cfg_h))  
				`uvm_fatal("getting failed","getting failed in config_db");



	    sb_h=new[env_cfg_h.has_no_of_scoreboard];
	    src_agt_top_h=new[env_cfg_h.has_no_of_source_agent_tops];
	    dst_agt_top_h=new[env_cfg_h.has_no_of_destination_agent_tops];

                        foreach(sb_h[i])
                                sb_h[i]=router_scoreboard::type_id::create($sformatf("sb_h[%0d]",i),this);
			
			foreach(src_agt_top_h[i])
								begin
                                src_agt_top_h[i]=router_src_agt_top::type_id::create($sformatf("src_agt_top_h[%0d]",i),this);
								end

			foreach(dst_agt_top_h[i])
								begin
                                dst_agt_top_h[i]=router_dst_agt_top::type_id::create($sformatf("dst_agt_top_h[%0d]",i),this);
								end
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		begin
		for (int i=0;i<env_cfg_h.no_of_src_agents;i++)
			begin
			v_seqr_h.src_seqr_h[i]=src_agt_top_h[i].src_agt_h[i].seqr_h;
			 src_agt_top_h[i].src_agt_h[i].mon_h.ap.connect(sb_h[i].fifo_src[i].analysis_export);
			end


		for (int i=0;i<env_cfg_h.no_of_dst_agents;i++)
			begin
			v_seqr_h.dst_seqr_h[i]=dst_agt_top_h[0].dst_agt_h[i].seqr_h;
			 dst_agt_top_h[0].dst_agt_h[i].mon_h.monitor_port.connect(sb_h[0].fifo_dst[i].analysis_export);

			end
		end
	

		
	endfunction
	

	
		
endclass
