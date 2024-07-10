class router_src_driver extends uvm_driver #(router_source_xtns);
	
   `uvm_component_utils(router_src_driver)

    function new(string name = "router_src_driver", uvm_component parent);
         super.new(name, parent);
    endfunction

    			
     virtual router_src_if.SRC_DRV_MP sif;
     router_src_agent_config src_agt_cfg_h;
     router_env_config evn_cfg_h;

 	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
	//if(!uvm_config_db #(router_env_config) ::get(this,"","router_env_config",env_cfg_h.src_agt_cfg_h)
	//		`uvm_fatal("getting failed","getting failed in get_type_name()");
      
      //src_agt_cfg_h=router_src_agent_config::type_id::create("src_agt_cfg_h");
      
   if(!uvm_config_db #(router_src_agent_config)::get(this,"","router_src_agent_config",src_agt_cfg_h))
       `uvm_fatal("getting failed","failed to get sourece_agent_config in driver");

	endfunction

	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		sif=src_agt_cfg_h.sif;
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		@(sif.src_drv_cb);
			sif.src_drv_cb.resetn<=1'b0;
  		@(sif.src_drv_cb);
			sif.src_drv_cb.resetn<=1'b1;
		forever
			begin
			seq_item_port.get_next_item(req);	
			
			drive_to_rtl(req);
			
			seq_item_port.item_done();
			end
	endtask

	task drive_to_rtl(router_source_xtns xtn);
		`uvm_info(get_type_name(),$sformatf(xtn.sprint()),UVM_LOW);
		@(sif.src_drv_cb);
			while(sif.src_drv_cb.busy===1)
				@(sif.src_drv_cb); 
			       sif.src_drv_cb.pkt_valid<=1'b1;
			       sif.src_drv_cb.data_in<=xtn.header;
				@(sif.src_drv_cb);
				foreach(xtn.payload[i])
					begin
						while(sif.src_drv_cb.busy===1)
						@(sif.src_drv_cb);
						sif.src_drv_cb.data_in<=xtn.payload[i];
						@(sif.src_drv_cb);
					end
						while(sif.src_drv_cb.busy===1)
						@(sif.src_drv_cb);
						sif.src_drv_cb.pkt_valid<=1'b0;
						sif.src_drv_cb.data_in<=xtn.parity;
					//	source_config_xtn ++;

						repeat(2)
						@(sif.src_drv_cb);
						
			endtask
		
	
endclass						


