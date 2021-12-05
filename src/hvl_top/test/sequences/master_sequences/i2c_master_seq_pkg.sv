`ifndef I2C_MASTER_SEQ_PKG_INCLUDED
`define I2C_MASTER_SEQ_PKG_INCLUDED

//-----------------------------------------------------------------------------------------
// Package: i2c_master_seq_pkg
// Description:
// Includes all the files written to run the simulation
//-------------------------------------------------------------------------------------------
package i2c_master_seq_pkg;

  //-------------------------------------------------------
  // Import uvm package
  //-------------------------------------------------------
  `include "uvm_macros.svh"
  import uvm_pkg::*;
  import i2c_master_pkg::*;
<<<<<<< HEAD
  import i2c_globals_pkg::*;
  
=======
  import i2c_globals_pkg::*; 
>>>>>>> eb2c30b053f80320e7eccda8e8968ea496b86512
  //-------------------------------------------------------
  // Importing the required packages
  //-------------------------------------------------------
  
  `include "i2c_master_base_sequences.sv"
<<<<<<< HEAD
=======
  `include "i2c_write_master_seq.sv"
>>>>>>> eb2c30b053f80320e7eccda8e8968ea496b86512
endpackage : i2c_master_seq_pkg
`endif
