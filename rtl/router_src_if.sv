interface router_src_if(input bit clock);

	logic [7:0] data_in;
	bit pkt_valid;
	logic busy;
	logic resetn;
	logic error;

	clocking src_drv_cb@(posedge clock);
		default input #1 output #1;
		input error;
		input busy;
		output data_in;
		output pkt_valid;
		output resetn;
	endclocking

	clocking src_mon_cb@(posedge clock);
	     default input #1 output #1;
		input error;
		input busy;
		input data_in;
		input pkt_valid;
		input resetn;
	endclocking

	modport SRC_DRV_MP (clocking src_drv_cb);
	
	modport SRC_MON_MP (clocking src_mon_cb); 
	
endinterface
