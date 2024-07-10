class router_src_monitor extends uvm_monitor;

	`uvm_component_utils(router_src_monitor)

	 function new(string name = "router_src_monitor", uvm_component parent);
         	super.new(name, parent);
    	 endfunction
		

	virtual router_src_if.SRC_MON_MP sif;
	router_src_agent_config src_agt_cfg_h;
	router_env_config evn_cfg_h;
	router_source_xtns xtn;
     

	uvm_analysis_port #(router_source_xtns) ap;
 
     

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
    		 ap=new("ap",this);
		
   //env_cfg_h=router_env_config::type_id::create("env_cfg_h");
//	if(!uvm_config_db #(router_env_config) ::get(this,"","router_env_config",evn_cfg_h.src_agt_cfg_h))
//			`uvm_fatal("getting failed"," failed to get ");


		// src_agt_cfg_h=router_src_agent_config::type_id::create("src_agt_cfg_h");
 		if(!uvm_config_db #(router_src_agent_config)::get(this,"","router_src_agent_config",src_agt_cfg_h))
       			`uvm_fatal("getting failed","failed to get sourece_agent_config in driver");
	endfunction


         
	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		sif=src_agt_cfg_h.sif;
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		   forever
			collect_task();
	endtask

	task collect_task();
	//	router_source_xtns xtn;
		xtn=router_source_xtns::type_id::create("xtn");
		@(sif.src_mon_cb);	
			while(sif.src_mon_cb.pkt_valid!==1)  //pkt_valid sould not be one
				@(sif.src_mon_cb);
				while(sif.src_mon_cb.busy===1)// busy should equall to 1
				@(sif.src_mon_cb);
				
				xtn.header=sif.src_mon_cb.data_in;
				xtn.payload=new[xtn.header[7:2]];
			         @(sif.src_mon_cb);
			      	foreach(xtn.payload[i])
					begin
						while(sif.src_mon_cb.busy===1) // busy equal to 1
						@(sif.src_mon_cb);
						xtn.payload[i]=sif.src_mon_cb.data_in;
						@(sif.src_mon_cb);
					end
						while(sif.src_mon_cb.busy===1) // Busy equal to 1
						@(sif.src_mon_cb);
						while(sif.src_mon_cb.pkt_valid!==0) // Pkt_valid should not equall to 0
						@(sif.src_mon_cb);
						xtn.parity=sif.src_mon_cb.data_in;
						//repeat(2)
						@(sif.src_mon_cb);
						//xtn.error=sif.src_mon_cb.error;
						ap.write(xtn); //sends the data to scoreboard from monitor
	`uvm_info(get_type_name(),$sformatf(xtn.sprint()),UVM_LOW);

	endtask		
endclass
