class router_virtual_seqs extends uvm_sequence #(uvm_sequence_item);
	
	`uvm_object_utils(router_virtual_seqs)


	router_src_sequencer src_seqr_h[];
	router_dst_sequencer dst_seqr_h[];
	router_virtual_sequencer v_seqr_h;

	
	small_packets_src src_small_pkt_h;
	medium_packets_src src_medium_pkt_h;
	high_packets_src  src_high_pkt_h;


	small_packets_dst dst_small_pkt_h;
	medium_packets_dst dst_medium_pkt_h;
	high_packets_dst  dst_high_pkt_h;


	router_env_config env_cfg_h;

	bit [1:0] addr;

	function new (string name="router_virtual_seqs");
		super.new(name);
	endfunction
	
	task body();
		if(!uvm_config_db #(router_env_config) :: get(null,get_full_name(),"router_env_config",env_cfg_h))
			`uvm_fatal("getting failed","in Virtual V_seqs");



			if(!uvm_config_db #(bit[1:0]) :: get(null,get_full_name(),"bit",addr))
			`uvm_fatal("getting failed","in Virtual V_seqs");

	src_seqr_h=new[env_cfg_h.no_of_src_agents];
	dst_seqr_h=new[env_cfg_h.no_of_dst_agents];
	
	
	assert($cast(v_seqr_h,m_sequencer)) else begin
		`uvm_error("BODY", "Error in $cast of virtual sequencer")
	end

	foreach(src_seqr_h[i])
		src_seqr_h[i]=v_seqr_h.src_seqr_h[i];
	foreach(dst_seqr_h[i])
		dst_seqr_h[i]=v_seqr_h.dst_seqr_h[i];

	endtask

endclass


class small_pkt_vseq extends router_virtual_seqs;

	`uvm_object_utils(small_pkt_vseq)

	function new(string name ="small_pkt_vseq");
		super.new(name);
	endfunction

	task body();
		super.body();


	src_small_pkt_h=small_packets_src::type_id::create("src_small_pkt_h");
	dst_small_pkt_h=small_packets_dst::type_id::create("dst_small_pkt_h");

		fork
		foreach(src_seqr_h[i])
		begin
		src_small_pkt_h.start(src_seqr_h[i]);
		#500;

		end
		
		if(addr==2'b00)
		dst_small_pkt_h.start(dst_seqr_h[0]);
		if(addr==2'b01)
		dst_small_pkt_h.start(dst_seqr_h[1]);
		if(addr==2'b10)
		dst_small_pkt_h.start(dst_seqr_h[2]);


		join
	endtask
endclass 



class medium_pkt_vseq extends router_virtual_seqs;

	`uvm_object_utils(medium_pkt_vseq)

	function new(string name ="medium_pkt_vseq");
		super.new(name);
	endfunction

	task body();
		super.body();


	src_medium_pkt_h=medium_packets_src::type_id::create("src_medium_pkt_h");
	dst_medium_pkt_h=medium_packets_dst::type_id::create("dst_medium_pkt_h");

		fork
		foreach(src_seqr_h[i])
		begin
		src_medium_pkt_h.start(src_seqr_h[i]);
		#500;

		end
		
		if(addr==2'b00)
		dst_medium_pkt_h.start(dst_seqr_h[0]);
		if(addr==2'b01)
		dst_medium_pkt_h.start(dst_seqr_h[1]);
		if(addr==2'b10)
		dst_medium_pkt_h.start(dst_seqr_h[2]);


		join
	endtask
endclass


class high_pkt_vseq extends router_virtual_seqs;

	`uvm_object_utils(high_pkt_vseq)

	function new(string name ="high_pkt_vseq");
		super.new(name);
	endfunction

	task body();
		super.body();


	src_high_pkt_h=high_packets_src::type_id::create("src_high_pkt_h");
	dst_high_pkt_h=high_packets_dst::type_id::create("dst_high_pkt_h");

		fork
		foreach(src_seqr_h[i])
		begin
		src_high_pkt_h.start(src_seqr_h[i]);
		#500;

		end
		
		if(addr==2'b00)
		dst_high_pkt_h.start(dst_seqr_h[0]);
		if(addr==2'b01)
		dst_high_pkt_h.start(dst_seqr_h[1]);
		if(addr==2'b10)
		dst_high_pkt_h.start(dst_seqr_h[2]);


		join
	endtask
endclass 
				
