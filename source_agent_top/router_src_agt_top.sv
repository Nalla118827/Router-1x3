class router_src_agt_top extends uvm_env;
    
      `uvm_component_utils(router_src_agt_top);

	router_source_agent src_agt_h[];
	router_src_agent_config src_agt_cfg_h;
	router_env_config env_cfg_h;
      
        function new (string name="router_src_agt_top", uvm_component parent);
        	  super.new(name,parent);
        endfunction

	function void build_phase(uvm_phase phase);
		  super.build_phase(phase);
		  config_router_agents();
		
	endfunction

	function config_router_agents();

   	//	 env_cfg_h=router_env_config::type_id::create("env_cfg_h"); //To get the env_config creation of object is mandatory for geting
		if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",env_cfg_h))
				`uvm_fatal("getting failed","getting failed in config_db");
        
    
    
       	    src_agt_h=new[env_cfg_h.no_of_src_agents];
            foreach(src_agt_h[i])
		begin
                  src_agt_h[i]=router_source_agent::type_id::create($sformatf("src_agt_h[%0d]",i),this);
      

		uvm_config_db #(router_src_agent_config) ::set(this,"*","router_src_agent_config",env_cfg_h.src_agt_cfg_h[i]);
     		$display("sucess to set");
		end

	endfunction

     // function void end_of_elaboration();
//		uvm_top.print_topology();
		
//	endfunction
      
endclass
