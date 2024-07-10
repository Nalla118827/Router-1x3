
module router_top;

	import router_pkg::*;
	
	import uvm_pkg::*;

	bit clock;
	always
		#5 clock=~clock;


	//Instatiate the interface
	router_src_if sif_0(clock);

	router_dst_if dif_0(clock);
  	router_dst_if dif_1(clock);
	router_dst_if dif_2(clock);
   



			router_top_level DUV (.router_clock(clock),   //RTL instastaion
					.resetn(sif_0.resetn),
					.pkt_valid(sif_0.pkt_valid),
					.data_in(sif_0.data_in),
					.busy(sif_0.busy),	
					.err(sif_0.error),
					.read_enb_0(dif_0.read_enb),.data_out_0(dif_0.data_out),.vld_out_0(dif_0.valid_out),
					.read_enb_1(dif_1.read_enb),.data_out_1(dif_1.data_out),.vld_out_1(dif_1.valid_out),
					.read_enb_2(dif_2.read_enb),.data_out_2(dif_2.data_out),.vld_out_2(dif_2.valid_out));        





	initial
		begin
			`ifdef VCS                      //for waveform
         		$fsdbDumpvars(0, router_top);
        		`endif
			
			//set configration
			uvm_config_db #(virtual router_src_if)::set(null,"*","sif",sif_0);
			uvm_config_db #(virtual router_dst_if)::set(null,"*","dif_0",dif_0);
			uvm_config_db #(virtual router_dst_if)::set(null,"*","dif_1",dif_1);
			uvm_config_db #(virtual router_dst_if)::set(null,"*","dif_2",dif_2);


			//run_test file
			run_test();
		end


//*************ASSERTIONS***************

property pkt_valid;
	@(posedge clock) (sif_0.busy==0) |=> (sif_0.pkt_valid==1 || sif_0.pkt_valid==0);
endproperty

property busy;
	@(posedge clock) $rose(sif_0.busy==1) |=> (sif_0.pkt_valid==1 || sif_0.pkt_valid==0) ;
endproperty

property valid_out_0;
	@(posedge clock) (dif_0.valid_out==1) |-> ##[1:30] (dif_0.read_enb==1) ;
endproperty

property valid_out_1;
	@(posedge clock) (dif_1.valid_out==1) |-> ##[1:30] dif_1.read_enb==1 ;
endproperty

property valid_out_2;
	@(posedge clock) (dif_2.valid_out==1) |-> ##[1:30] dif_2.read_enb==1 ;
endproperty

property read_enb_0;
	@(posedge clock) (dif_0.valid_out==0) |=>   dif_0.read_enb==0 ;
endproperty

property read_enb_1;
	@(posedge clock) (dif_1.valid_out==0) |=> (dif_1.read_enb==0) ;
endproperty

property read_enb_2;
	@(posedge clock) (dif_2.valid_out==0) |=> (dif_2.read_enb==0) ;
endproperty

property busy_1;
	@(posedge clock) $rose(sif_0.busy) |=> $stable(sif_0.data_in);
endproperty





A:assert property (pkt_valid)
	$display("***********PASSED BEACUSE OF PKT_VALID IS 1 OR 0");
  else
	$display("**************BEACUSE OF PKT_VALID 1 OR 0*********FAILED");


B:assert property (busy)
	$display("BUSY IS HIGH SO ***********PACTKET VALID IS ZERO****PASSED");
  else
	$display("BUSY IS HIGH SO*********PACTKET VALID IS ****NOT !ZERO***FAILED");


C:assert property (valid_out_0)
	$display("VALID_OUT_0 IS HIGH ******SO  READ_ENABLE_0 IS 1****PASSED");
  else
	$display("VALID_OUT IS HIGH &********** BUT READ_ENABLE IS NOT !0***FAILED");

D:assert property (valid_out_1)
	$display("VALID_OUT_1 IS HIGH ***SO  READ_ENABLE_1 IS 1****PASSED");
  else
	$display("VALID_OUT IS HIGH &********** BUT READ_ENABLE IS 0*****FAILED");

E:assert property (valid_out_2)
	$display("VLID_OUT_2 IS HIGH ***SO  READ_ENABLE_2 IS 1 ****PASSED");
  else
	$display("VALID_OUT IS HIGH &********** BUT READ_ENABLE IS 0*****FAILED");

F:assert property (read_enb_0)
	$display("VALID_0 IS LOW ******SO  READ_ENABLE_0 IS ==0 ****PASSED");
  else
	$display("VALID_OUT IS LOW********** BUT READ_ENABLE IS 1*****FAILED");

G:assert property (read_enb_1)
	$display("VALID_0 IS LOW ******SO  READ_ENABLE_0 IS ==0****PASSED");
  else
	$display("VALID_OUT IS LOW********** BUT READ_ENABLE IS 1*****FAILED");

H:assert property (read_enb_2)
	$display("VALID_OUT_2 IS LOW ******SO  READ_ENABLE_2 IS ==0 ***PASSED");
  else
	$display("VALID_OUT IS LOW********** BUT READ_ENABLE IS 1***FAILED");


I:assert property (busy_1)
	$display("***********PASSED BEACUSE OF BUSY_1 AND DATA_IN STABLE IS 1");
  else
	$display("****BUSY_1******BUT DATA_IN NOT SATBLE****FAILED");

endmodule
			
