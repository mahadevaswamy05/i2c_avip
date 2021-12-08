`ifndef I2C_MASTER_AGENT_CONFIG_INCLUDED_
`define I2C_MASTER_AGENT_CONFIG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: i2c_master_agent_config
// <Description_here>
//--------------------------------------------------------------------------------------------
class i2c_master_agent_config extends uvm_object;
  `uvm_object_utils(i2c_master_agent_config)

  // Variable: is_active
  // Used for creating the agent in either passive or active mode
  uvm_active_passive_enum is_active=UVM_ACTIVE;  

  // Variable: no_of_slaves
  // Used for specifying the number of slaves connected to 
  // this master over i2c interface
  int no_of_slaves;
  
  // MSHA:// Variable:read_write_e
  // MSHA:// Enables read or write operation 
  //read_write_e read_write;

  // Variable: shift_dir
  // Tells the direction of data to be shifted
  // MSB first or LSB first
  shift_direction_e shift_dir;

  // Variable: slave_address_array
  // Stores the addresses of different slaves
  bit [SLAVE_ADDRESS_WIDTH-1:0] slave_address_array[];

  // Variable: register_address_array
  // Stores the register addresses for each slave
  //bit [31:0] register_address_array[int];

  bit [7:0] slave_register_address_array[];

  // Variable: has_coverage
  // Used for enabling the master agent coverage
  bit has_coverage;

  // MSHA: //-------------------------------------------------------
  // MSHA: // Constraints 
  // MSHA: //-------------------------------------------------------
  // MSHA: constraint slave_addr{slave_address_array.size() inside {[1:no_of_slaves]};}
  // MSHA: 
  // MSHA: constraint register_addr{register_address_array.size() inside {[0:3]};}
  // MSHA: 
  // MSHA: constraint slave_addr_0{slave_address_array[0] == 7'b0000000;}
  // MSHA: constraint slave_addr_1{slave_address_array[1] == 7'b0000001;}
  // MSHA: constraint slave_addr_2{slave_address_array[2] == 7'b0000010;}
  // MSHA: constraint slave_addr_3{slave_address_array[3] == 7'b0000011;}


  // MSHA: constraint register_addr_0{
  // MSHA:   if(slave_address_array[0] == 7'b0000000)
  // MSHA:    register_address_array[0]==8'b00000000;
  // MSHA:    register_address_array[1]==8'b00001000;
  // MSHA:    register_address_array[2]==8'b00001001;
  // MSHA:    register_address_array[3]==8'b10000000;
  // MSHA:  }
  // MSHA:   
  // MSHA: constraint register_addr_1{
  // MSHA:   if(slave_address_array[1] == 7'b0000001)
  // MSHA:    register_address_array[0]==8'b00010000;
  // MSHA:    register_address_array[1]==8'b00101000;
  // MSHA:    register_address_array[2]==8'b01001001;
  // MSHA:    register_address_array[3]==8'b11000000;}
  
 // constraint register_addr{
 //   foreach(slave_address_array[i])begin
 //    register_address_array[i].size()>8'h00;
 //    register_address_array[i].size()<8'hff;
 //  end
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "i2c_master_agent_config");
  extern function void do_print(uvm_printer printer);
endclass : i2c_master_agent_config

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - i2c_master_agent_config
//--------------------------------------------------------------------------------------------
function i2c_master_agent_config::new(string name = "i2c_master_agent_config");
  super.new(name);

endfunction : new


//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//--------------------------------------------------------------------------------------------
function void i2c_master_agent_config::do_print(uvm_printer printer);
  super.do_print(printer);


  printer.print_string ("is_active",is_active.name());
  printer.print_field ("no_of_slaves",no_of_slaves,$bits(no_of_slaves), UVM_DEC);
  printer.print_string ("shift_dir",shift_dir.name());
  //printer.print_string ("read_write",read_write.name());
  printer.print_field ("has_coverage",has_coverage, 1, UVM_DEC);
  
endfunction : do_print

// TODO(mshariff): Function for checking if the values in the slave_address_array are unique
`endif
