`ifndef I2C_WRITE_MASTER_SEQ_INCLUDED_
`define I2C_WRITE_MASTER_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// class: extended class from base class
//--------------------------------------------------------------------------------------------
<<<<<<< HEAD
class i2c_write_master_seq extends i2c_master_base_seq;
=======
class i2c_write_master_seq extends i2c_master_base_sequences;
>>>>>>> eb2c30b053f80320e7eccda8e8968ea496b86512

  
  //register with factory so can use create uvm_method 
  //and override in future if necessary 
  `uvm_object_utils(i2c_write_master_seq)

  // master_tx req;

  //---------------------------------------------
  // Externally defined tasks and functions
  //---------------------------------------------

  extern function new (string name="i2c_write_master_seq");
  extern virtual task body();

endclass:i2c_write_master_seq

//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the master_sequence class object
//
// Parameters:
//  name - instance name of the config_template
//-----------------------------------------------------------------------------

function i2c_write_master_seq::new(string name="i2c_write_master_seq");
  super.new(name);
endfunction:new

//-----------------------------------------------------------------------------
//task:body
//based on the request from driver task will drive the transaction
//-----------------------------------------------------------------------------
task i2c_write_master_seq::body();
  req = i2c_master_tx::type_id::create("req");

  start_item(req);

<<<<<<< HEAD
  if(!req.randomize() with {req.data.size() == 1;
                            req.reg_address == 0;
                           }) begin
    `uvm_fatal(get_type_name(),"Randomization failed")
  end

=======
//  if(!req.randomize() with {req.data.size() == 1;
//                            req.reg_address.size() == 1;
//                           }) begin
//    `uvm_fatal(get_type_name(),"Randomization failed")
//  end
 //if(!req.randomize() with {req.reg_address.size() == 1;
>>>>>>> eb2c30b053f80320e7eccda8e8968ea496b86512
  req.print();
  finish_item(req);

endtask:body

`endif
