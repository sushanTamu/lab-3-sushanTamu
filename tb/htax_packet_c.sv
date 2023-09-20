///////////////////////////////////////////////////////////////////////////
// Texas A&M University
// CSCE 616 Hardware Design Verification
// File name   : htax_packet_c.sv
// Created by  : Prof. Quinn and Saumil Gogri
///////////////////////////////////////////////////////////////////////////


class htax_packet_c extends uvm_sequence_item;
	
	parameter PORTS = `PORTS;
	parameter VC 		= `VC;
	parameter WIDTH = `WIDTH;
	// Defining parameters for length and delay based on the constraints value provided in the TODO list
	// This will help the design to get parameterised and help in the future
	parameter LENGTH = 6;
	parameter DELAY = 5;

//TO DO -  define class members	with below hints and rand keyword
	//Delay of the packet
	//Destination port of packet
	//Virtual channel requested. Multiple requests allowed. VC bit wide
	//Length of Data in terms of data packet 
  	rand bit [DELAY-1:0] delay;
  	rand bit [PORTS-1:0] dest_port;
  	rand bit [VC-1:0] vc;
  	rand bit [LENGTH-1:0] length;
	rand bit [WIDTH-1:0] data[] ; //Data - Each data packet is WIDTH-bit wide

	// UVM macros for built-in automation
	`uvm_object_utils_begin(htax_packet_c)
		`uvm_field_int(delay,UVM_ALL_ON)
		`uvm_field_int(dest_port,UVM_ALL_ON)
		`uvm_field_int(vc,UVM_ALL_ON)
		`uvm_field_int(length,UVM_ALL_ON)
		`uvm_field_array_int(data,UVM_ALL_ON)
	`uvm_object_utils_end

	//constructor
	function new (	string name="htax_packet_c");
		super.new(name);
	endfunction

//TO DO - Complete all below constraints
	//Constraint 1 : delay should be between 1 and 20
	constraint delay_cons {delay inside {[1:20]};}

	//Constraint 2 : dest_port should be between 0 and (PORTS-1)
	constraint dest_port_cons {dest_port inside {[0:PORTS-1]};}

	//Constraint 3 : VC should be valid VC request
	constraint vc_cons {vc!=0;}

	//Constraint 4 : Data-length should be greater than 2 and can be maximum 50 :: distribution pattern [3:20]=60%, [21:40]=35%, [41:50]=5%
	constraint length_cons {length dist {[3:20]:/60,[21:40]:/35,[41:50]:/5}; data.size() == length;}

endclass : htax_packet_c
