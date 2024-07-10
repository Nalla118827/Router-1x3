class router_dst_driver extends uvm_driver #(router_dst_xtns);
	
	`uvm_component_utils(router_dst_driver)
	
	virtual router_dst_if.DST_DRV_MP dif;
	router_dst_agent_config dst_agt_cfg_h;

	function new(string name = "router_dst_driver", uvm_component parent);
         super.new(name, parent);
        endfunction
		
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
			
		if(!uvm_config_db #(router_dst_agent_config) :: get(this,"","router_dst_agent_config",dst_agt_cfg_h))
			`uvm_fatal("getting failed","getting failed");
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
			dif=dst_agt_cfg_h.dif;
	endfunction
     
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
			forever
				begin
				  seq_item_port.get_next_item(req);
				  drive_to_rtl(req);
				  seq_item_port.item_done();
				end
	endtask

	task drive_to_rtl(router_dst_xtns xtn);
		`uvm_info(get_type_name(),$sformatf(xtn.sprint()),UVM_LOW);

		@(dif.dst_drv_cb);
		while(dif.dst_drv_cb.valid_out===0)
		@(dif.dst_drv_cb);
		
			repeat(req.no_of_cycle)
			@(dif.dst_drv_cb);
			$display("Valid_out became 1");
			dif.dst_drv_cb.read_enb<=1'b1;
			$display("Read_Enable is made 1 from Dst_Driver");
			
			//	@(dif.dst_drv_cb);             // no uise of delay
			while(dif.dst_drv_cb.valid_out===1)
			@(dif.dst_drv_cb);
			dif.dst_drv_cb.read_enb<=1'b0;
			@(dif.dst_drv_cb);

	endtask





endclass

	


