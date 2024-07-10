interface router_dst_if(input bit clock);

	bit [7:0] data_out;
	bit valid_out;
	bit read_enb;

	clocking dst_drv_cb@(posedge clock);
		default input #1 output #0;
		input valid_out;
		output read_enb;
	endclocking

	clocking dst_mon_cb@(posedge clock);
		default input #1 output #0;
		input read_enb;
		input data_out;
	endclocking
	
	modport DST_DRV_MP (clocking dst_drv_cb);
	modport DST_MON_MP (clocking dst_mon_cb);
	
endinterface
	
		
    

