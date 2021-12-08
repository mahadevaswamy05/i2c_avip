`ifndef I2C_8B_MASTER_SEQ_INCLUDED_
`define I2C_8B_MASTER_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: i2c_8b_master_sequence
// <Description_here>
//--------------------------------------------------------------------------------------------
class i2c_8b_master_seq extends i2c_master_base_seq;
  `uvm_object_utils(i2c_8b_master_seq)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "i2c_8b_master_seq");
  extern task body();
endclass : i2c_8b_master_seq

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - i2c_8b_master_seq
//--------------------------------------------------------------------------------------------
function i2c_8b_master_seq::new(string name = "i2c_8b_master_seq");
  super.new(name);
endfunction : new

//-------------------------------------------------------
//task : body
//based on the request from the driver task will drive the transaction
//-------------------------------------------------------

task i2c_8b_master_seq::body();

  super.body();

  req = i2c_master_tx::type_id::create("req"); 
  req.i2c_master_agent_cfg_h = p_sequencer.i2c_master_agent_cfg_h;

  `uvm_info("DEBUG_MSHA", $sformatf("address = %0x",
  p_sequencer.i2c_master_agent_cfg_h.slave_address_array[0]), UVM_NONE)

  start_item(req);

  if(!req.randomize() with {read_write == WRITE;}) begin

    `uvm_fatal(get_type_name(), "Randomization failed")

  end
  
  req.print();
  finish_item(req);


endtask:body
  

`endif


