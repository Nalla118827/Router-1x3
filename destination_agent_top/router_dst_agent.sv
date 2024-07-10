class router_dst_agent extends uvm_agent;
		
	`uvm_component_utils(router_dst_agent);

	router_dst_monitor mon_h;
	router_dst_driver drv_h;
	router_dst_sequencer seqr_h;
	router_dst_agent_config dst_agt_cfg_h;

	function new(string name = "router_dst_agent", uvm_component parent);
         super.new(name, parent);
        endfunction
 
 
   function void build_phase (uvm_phase phase);
       super.build_phase(phase);
	router_config_agents();
   endfunction

	function router_config_agents();
		
				
		begin	
		if(!uvm_config_db #(router_dst_agent_config)::get(this," ","router_dst_agent_config",dst_agt_cfg_h))
			`uvm_fatal("getting failed","getting failed in Destination agent");
		
			
		mon_h=router_dst_monitor::type_id::create("mon_h",this);

		if(dst_agt_cfg_h.is_active==UVM_ACTIVE)
		   begin
			drv_h=router_dst_driver::type_id::create("drv_h",this);
      			seqr_h=router_dst_sequencer::type_id::create("seqr_h",this);
		  end
		end

	endfunction

	
    function void connect_phase(uvm_phase phase);
          super.connect_phase(phase);
         if(dst_agt_cfg_h.is_active==UVM_ACTIVE) begin
                 drv_h.seq_item_port.connect(seqr_h.seq_item_export);
			end
    endfunction                 
    


endclass
