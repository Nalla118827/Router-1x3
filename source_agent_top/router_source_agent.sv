class router_source_agent extends uvm_agent;
	
	`uvm_component_utils(router_source_agent)

	router_src_monitor mon_h;
	router_src_driver drv_h;
	router_src_sequencer seqr_h;
	 router_src_agent_config src_agt_cfg_h;


	function new(string name = "router_source_agent", uvm_component parent);
         super.new(name, parent);
       endfunction
	
 
   function void build_phase (uvm_phase phase);
       super.build_phase(phase);
       router_config();
   endfunction
   
   function void router_config();
   //src_agt_cfg_h= router_src_agent_config::type_id::create("src_agt_cfg_h");

   if(!uvm_config_db #(router_src_agent_config) :: get(this,"","router_src_agent_config",src_agt_cfg_h))
         `uvm_fatal("getting failed","in src_agent  failed");
         
     

         mon_h=router_src_monitor::type_id::create("mon_h",this);
         if(src_agt_cfg_h.is_active==UVM_ACTIVE)
                begin
                drv_h=router_src_driver::type_id::create("drvh",this);
                seqr_h=router_src_sequencer::type_id::create("seqrh",this);
                end
    endfunction  


    function void connect_phase(uvm_phase phase);
          super.connect_phase(phase);
         if(src_agt_cfg_h.is_active==UVM_ACTIVE)
                 drv_h.seq_item_port.connect(seqr_h.seq_item_export);
    endfunction                 
    
endclass
            
  


