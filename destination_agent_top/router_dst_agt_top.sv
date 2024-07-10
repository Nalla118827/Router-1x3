class router_dst_agt_top extends uvm_agent;
	
	`uvm_component_utils(router_dst_agt_top)

	router_dst_agent dst_agt_h[];
  	router_env_config env_cfg_h;
	router_dst_agent_config dst_agt_cfg_h[];

	function new (string name="router_dst_agt_top", uvm_component parent);
 		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
       		router_config_agents();
	endfunction


  function router_config_agents();
    //  env_cfgs_h=router_env_config::type_id::create("env_cfgs_h"); //To get the env_config creation of object is mandatory for geting
      
      if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",env_cfg_h))
              `uvm_fatal("Getting failed","getting failed in get_type_name()");
              
	dst_agt_cfg_h=new[env_cfg_h.no_of_dst_agents];

		foreach(dst_agt_cfg_h[i])
			begin
				dst_agt_cfg_h[i]=env_cfg_h.dst_agt_cfg_h[i];
			end


    dst_agt_h=new[env_cfg_h.no_of_dst_agents];
	$display(env_cfg_h.no_of_dst_agents);

          foreach(dst_agt_h[i])
			begin
			dst_agt_h[i]=router_dst_agent::type_id::create($sformatf("dst_agt_h[%0d]",i),this);
			$display("created");

			uvm_config_db #(router_dst_agent_config)::set(this,$sformatf("dst_agt_h[%0d]*",i),"router_dst_agent_config",env_cfg_h.dst_agt_cfg_h[i]);
			end   



		if(env_cfg_h==null)
			$display("IT IS NULLL*************************null");
		else
			$display(env_cfg_h);                 

    endfunction
          
            

endclass
