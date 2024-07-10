class router_scoreboard extends uvm_scoreboard;

	`uvm_component_utils(router_scoreboard)
		
	uvm_tlm_analysis_fifo #(router_source_xtns) fifo_src[];
	uvm_tlm_analysis_fifo #(router_dst_xtns) fifo_dst[];	

	router_env_config env_cfg_h;
	router_source_xtns xtn_h1;
	router_dst_xtns xtn_h2;
	static int header_matched_count;
	static int payload_matched_count;
	static int parity_matched_count;
	static int header_mismatched_count;
	static int payload_mismatched_count;
	static int parity_mismatched_count;

	router_source_xtns src_xtn;
	router_dst_xtns dst_xtn;

//	dst_xtn=xtn_h2;

        covergroup router_cov;
		option.per_instance=1;

			ADDRESS: coverpoint src_xtn.header[1:0] {
								 bins first={2'b00};
								 bins second={2'b01};
								 bins third={2'b10};}

			PAYLOAD: coverpoint src_xtn.header[7:2] { bins small_pkt={[1:20]};
								  bins medium_pkt={[21:40]};
								  bins high_pkt={[41:62]};}
			
			PARITY: coverpoint src_xtn.parity { bins parity={1'b1};}

		//	ERROR: coverpoint error { bins error={1'b1};}

	endgroup
		
	function new(string name = "router_scoreboard", uvm_component parent);
         super.new(name, parent);
		router_cov=new();

        endfunction


	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",env_cfg_h))
			`uvm_fatal("getting failed in scoreboard","failed")
		fifo_src=new[env_cfg_h.no_of_src_agents];
		fifo_dst=new[env_cfg_h.no_of_dst_agents];

		foreach(fifo_src[i])
			fifo_src[i]=new($sformatf("fifo_src[%0d]",i),this) ;
		foreach(fifo_dst[i])
			fifo_dst[i]=new($sformatf("fifo_dst[%0d]",i),this);
	endfunction	


	task run_phase(uvm_phase phase);
		fork		
		begin
			
				forever
				
				begin
					fifo_src[0].get(xtn_h1);
					src_xtn=xtn_h1;
					router_cov.sample();
	
                                        `uvm_info("enter into scoreboard we got the transaction","success",UVM_LOW)
						
				end
				end
				begin
					forever
						begin
							fork:B
						
				begin
					fifo_dst[0].get(xtn_h2);
					if(xtn_h1!=null && xtn_h2!=null) 
		                        user_compare(xtn_h1,xtn_h2);
				end
				begin
					fifo_dst[1].get(xtn_h2);
					if(xtn_h1!=null && xtn_h2!=null) 
		                        user_compare(xtn_h1,xtn_h2);
				end
				begin
					fifo_dst[2].get(xtn_h2);
					if(xtn_h1!=null && xtn_h2!=null) 
		                        user_compare(xtn_h1,xtn_h2);
				end
					join_any
					disable fork ;
				end
		
		end
		join
	endtask


task user_compare(router_source_xtns xtn_h1, router_dst_xtns xtn_h2);

//	begin
	begin
	if(xtn_h1.header==xtn_h2.header) 
		begin
		`uvm_info(get_type_name(),"header is matched",UVM_LOW)
		header_matched_count++;
	
		end	
	else
		begin
		`uvm_error(get_type_name(),"Header not matched")
		header_mismatched_count++;
		end
	if(xtn_h1.payload==xtn_h2.payload)
		begin
		payload_matched_count++;

		`uvm_info(get_type_name(),"payload is matched",UVM_LOW)
		end
	else
		begin
		`uvm_error(get_type_name(),"Payload not matched")
		 payload_mismatched_count++;
		end
	if(xtn_h1.parity==xtn_h2.parity)
		begin
		`uvm_info(get_type_name(),"Parity is matched",UVM_LOW)
			parity_matched_count++;
		end
	else
		begin
		`uvm_error(get_type_name(),"Parity not matched")
			parity_mismatched_count++;
		end
	end
//	end
endtask



function void report_phase(uvm_phase phase);
	$display("+++++++++++++++++++++++++++++++++++++++++++Scoreboard+++++++++++++++++++++++++++++++++++++++++++++++++++++");
	`uvm_info(get_type_name(),$sformatf("Header Data Matched Count: %d",header_matched_count),UVM_LOW)
	`uvm_info(get_type_name(),$sformatf("Header Data Mismatched count %d",header_mismatched_count),UVM_LOW)
	`uvm_info(get_type_name(),$sformatf("Payload Data Matched count %d",payload_matched_count),UVM_LOW)
	`uvm_info(get_type_name(),$sformatf("Payload Data Mismatched count %d",payload_mismatched_count),UVM_LOW)
	`uvm_info(get_type_name(),$sformatf("Parity Data Matched count %d",parity_matched_count),UVM_LOW)
	`uvm_info(get_type_name(),$sformatf("Parity Data Mismatched Count %d",parity_mismatched_count++),UVM_LOW)

	$display("+++++++++++++++++++++++++++++++++++++++++++End of Scoreboard++++++++++++++++++++++++++++++++++++++++++++++");

endfunction

endclass





      

   
