`ifndef I2C_MASTER_TX_INCLUDED_
`define I2C_MASTER_TX_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: i2c_master_tx
// 
//--------------------------------------------------------------------------------------------

class i2c_master_tx extends uvm_sequence_item;
  `uvm_object_utils(i2c_master_tx)

  rand read_write_e read_write;
  rand bit [SLAVE_ADDRESS_WIDTH-1:0]slave_address;
  rand bit [REGISTER_ADDRESS_WIDTH-1:0]register_address;
  rand bit [DATA_WIDTH-1:0]wr_data[];
  rand bit [DATA_WIDTH-1:0]rd_data[$];

  bit ack;
  
  rand bit [NO_OF_SLAVES-1:0] index; 
  rand bit [7:0] raddr; 
  
  // Receiving data fields
  bit slave_add_ack = 1;
  bit reg_add_ack = 1;
  // TODO(mshariff): 
  bit wr_data_ack[$];

  i2c_master_agent_config i2c_master_agent_cfg_h;
  //-------------------------------------------------------
  // Constraints for I2C
  //-------------------------------------------------------
  
  //The register_address_arrayis of the mode of 4 because data width is 32bit 

  constraint register_addr_c{register_address%4 == 0;} 
  constraint s_addr_index_c{index inside {[0:NO_OF_SLAVES-1]};}
  //constraint s_addr_c{slave_address == i2c_master_agent_cfg_h.slave_address_array[index];solve index before slave_address;}
  //constraint s_sb_c{solve index before slave_address;}
 
  constraint r_addr_size_c{raddr inside {[0:7]};}
  //constraint r_addr_c{register_address == i2c_master_agent_cfg_h.slave_register_address_array[raddr];}
  constraint r_sb_c{solve raddr before register_address;}
  
  // Write Data
  constraint write_data_c {soft wr_data.size() %4 == 0;
                                wr_data.size() != 0; 
                           soft wr_data.size() == 4;
                                wr_data.size() <= MAXIMUM_BYTES; }
  
  
  
  //constraint slave_addr_0{slave_address==i2c_master_agent_cfg_h.slave_address_array[0];}
  //constraint slave_addr_1{slave_address==i2c_master_agent_cfg_h.slave_address_array[1];}
  //constraint slave_addr_2{slave_address==i2c_master_agent_cfg_h.slave_address_array[2];}
  //constraint slave_addr_3{slave_address==i2c_master_agent_cfg_h.slave_address_array[3];}

 //                    reg_address.size() < MAXIMUM_BITS/CHAR_LENGTH;}
 // 
 // constraint data{reg_address.size() > 0 ;
 //                    reg_address.size() < MAXIMUM_BITS/CHAR_LENGTH;}
 // 
 // constraint slave_address_width_e {slave_addr_mode == 1'b0;}
 // 
 // constraint slave_addr{
 //                       if(slave_addr_mode == 1'b0) 
 //                         {slave_address == 7'b101_0100;}
 //                       if(slave_addr_mode == 1'b1) 
 //                         {slave_address == 10'b10_1010_0101;}
 // }

//   constraint slave_addr{i2c_master_agent_cfg_h.slave_address_width.size() > 0 ;
//                     i2c_master_agent_cfg_h.slave_address_width.size() < MAXIMUM_BITS/CHAR_LENGTH;}
 // constraint slave_addr_0{
 //   if(i2c_master_agent_cfg_h.slave_address_array[0]==7'b0000000)
 //     slave_address==i2c_master_agent_cfg_h.slave_address_array[0];
 //   }

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "i2c_master_tx");
  extern function void post_randomize();
  extern function void do_copy(uvm_object rhs);
  extern function bit do_compare(uvm_object rhs, uvm_comparer comparer); 
  extern function void do_print(uvm_printer printer);

endclass : i2c_master_tx

//--------------------------------------------------------------------------------------------
//  Construct: new
//  initializes the class object
//
//  Parameters:
//  name - i2c_master_tx
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function i2c_master_tx::new(string name = "i2c_master_tx");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// do_copy method
//--------------------------------------------------------------------------------------------

function void i2c_master_tx::do_copy (uvm_object rhs);
  i2c_master_tx rhs_;
  
  if(!$cast(rhs_,rhs)) begin
    `uvm_fatal("do_copy","cast of the rhs object failed")
  end
  super.do_copy(rhs);

  slave_address= rhs_.slave_address;
  register_address= rhs_.register_address;
  wr_data = rhs_.wr_data;

endfunction : do_copy


//--------------------------------------------------------------------------------------------
// do_compare method
//--------------------------------------------------------------------------------------------
function bit  i2c_master_tx::do_compare (uvm_object rhs,uvm_comparer comparer);
  i2c_master_tx rhs_;

  if(!$cast(rhs_,rhs)) begin
  `uvm_fatal("FATAL_I2C_MASTER_TX_DO_COMPARE_FAILED","cast of the rhs object failed")
  return 0;
  end

  return super.do_compare(rhs,comparer) &&
  slave_address == rhs_.slave_address &&
  register_address == rhs_.register_address &&
  wr_data == rhs_.wr_data;
endfunction : do_compare 
//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//--------------------------------------------------------------------------------------------
function void i2c_master_tx::do_print(uvm_printer printer);
  super.do_print(printer);

  printer.print_field($sformatf("slave_address"),this.slave_address,$bits(slave_address),UVM_HEX);
  printer.print_field($sformatf("register_address"),this.register_address,8,UVM_HEX);
  printer.print_string($sformatf("read_write"),read_write.name());
  
  foreach(wr_data[i]) begin
    printer.print_field($sformatf("wr_data[%0d]",i),this.wr_data[i],8,UVM_HEX);
  end

  printer.print_field($sformatf("slave_add_ack"),this.slave_add_ack,1,UVM_BIN);
  printer.print_field($sformatf("reg_add_ack"),this.reg_add_ack,1,UVM_BIN);
  foreach(wr_data_ack[i]) begin
    printer.print_field($sformatf("wr_data_ack[%0d]",i),this.wr_data_ack[i],1,UVM_HEX);
  end

endfunction : do_print

//--------------------------------------------------------------------------------------------
// Function: post_randomize
// Used for setting slave address value based on the configurations value
//--------------------------------------------------------------------------------------------
function void i2c_master_tx::post_randomize();
  slave_address = i2c_master_agent_cfg_h.slave_address_array[index];
  `uvm_info("DEBUG_MSHA", $sformatf("index = %0d and slave_address = %0x", index, slave_address), UVM_NONE)
endfunction: post_randomize
`endif
