`ifndef I2C_SLAVE_DRIVER_BFM_INCLUDED_
`define I2C_SLAVE_DRIVER_BFM_INCLUDED_
//--------------------------------------------------------------------------------------------
// Class    :i2c_slave_driver_bfm
// Description  : Connects with the HVL driver_proxy for driving the stimulus
//--------------------------------------------------------------------------------------------
import i2c_globals_pkg::*;
interface i2c_slave_driver_bfm(input pclk, 
                               input areset,
                               input scl_i,
                               output reg scl_o,
                               output reg scl_oen,
                               input sda_i,
                               output reg sda_o,
                               output reg sda_oen);

  //-------------------------------------------------------
  // Importing UVM Package 
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh" 

  //-------------------------------------------------------
  // Importing I2C Global Package and Slave package
  //-------------------------------------------------------
  import i2c_slave_pkg::i2c_slave_driver_proxy;

  //Variable : slave_driver_proxy_h
  //Creating the handle for proxy driver
  i2c_slave_driver_proxy i2c_slave_drv_proxy_h;

  
  initial begin
    $display("Slave Driver BFM");
  end

endinterface : i2c_slave_driver_bfm

`endif
