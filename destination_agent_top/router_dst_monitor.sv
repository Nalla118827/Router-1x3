class router_dst_monitor extends uvm_monitor;
	
	`uvm_component_utils(router_dst_monitor)

	virtual router_dst_if.DST_MON_MP dif;
	router_dst_agent_config dst_agt_cfg_h;
	router_dst_xtns xtn;

	uvm_analysis_port #(router_dst_xtns) monitor_port;


	function new(string name = "router_dst_monitor", uvm_component parent);
         super.new(name, parent);
        endfunction

			
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		monitor_port=new("monitor_port",this);
			
		if(!uvm_config_db #(router_dst_agent_config) :: get(this,"","router_dst_agent_config",dst_agt_cfg_h))
			`uvm_fatal("getting failed","getting failed");
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
			dif=dst_agt_cfg_h.dif;
	endfunction

	task run_phase(uvm_phase phase);
		forever
				collect_data();
			
	endtask	


	task collect_data();
	xtn=router_dst_xtns::type_id::create("xtn");
//	@(dif.dst_mon_cb);
		while(dif.dst_mon_cb.read_enb!==1)
	 	@(dif.dst_mon_cb);
	//	begin
	//	$display("%t Waiting for Read_Enable to High",$time);
	//	end


		@(dif.dst_mon_cb);
	//	$display("%t Read_Enable is High",$time);
		xtn.read_enb=dif.dst_mon_cb.read_enb;
		xtn.header=dif.dst_mon_cb.data_out;
		xtn.payload=new[xtn.header[7:2]];


		@(dif.dst_mon_cb);
		$display("%t Header Collected and stareted for Palyload to monitoring",$time);
		foreach(xtn.payload[i])
			begin
			xtn.payload[i]=	dif.dst_mon_cb.data_out;
			@(dif.dst_mon_cb);
			end
			
		//	@(dif.dst_mon_cb);
			$display("%t Payload is collected",$time);
			xtn.parity=dif.dst_mon_cb.data_out;
			while(dif.dst_mon_cb.read_enb==1)
			@(dif.dst_mon_cb);
			
		`uvm_info(get_type_name(),$sformatf(xtn.sprint()),UVM_LOW);
			monitor_port.write(xtn);
	endtask


endclass

