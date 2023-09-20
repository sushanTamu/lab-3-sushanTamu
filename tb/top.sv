///////////////////////////////////////////////////////////////////////////
// Texas A&M University
// CSCE 616 Hardware Design Verification
// File name   : top.sv
// Created by  : Prof. Quinn and Saumil Gogri
///////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ps
module top;

	import uvm_pkg::*;
	`include "uvm_macros.svh"

	`include "htax_defines.sv"
	`include "htax_packet_c.sv"

	htax_packet_c pkt, fac_pkt; //handle for class objects
	
	bit clk=0;
	
	//Create variables to store port (4-bit) and one data packet (64-bit) 
	logic [3:0] port;
	logic [63:0] data;

//clock definition 
initial forever #5 clk = ~clk;

initial begin
//TO-DO create two instance with above handles with instructions provided below
	//system verilog instance
	//randomize pkt
	//print pkt
	//drive pkt 
	
	//Creating a new Instance of htax_packet class using system verilog instantiation method
	pkt = new();

	//Randomzing all the fields of the given htax_packet class within the given constraints 	
	pkt.randomize();
	
	//Calling the given implemented task of drive_packet. 
	drive_packet(pkt);
	
	//printing the values of the htax_packet class randomized in pkt instantiation 
	pkt.print();

	// UVM factory instantiation
	//randomize fac_pkt
	//print fac_pkt
	//drive fac_pkt
	

	//Creating a new Instance of htax_packet class using uvm factory instantiation method
	fac_pkt = htax_packet_c::type_id::create("fac_pkt");

	//Randomzing all the fields of the given htax_packet class within the given constraints 	
	fac_pkt.randomize();

	//Calling the given implemented task of drive_packet. 
	drive_packet(fac_pkt);

	//printing the values of the htax_packet class randomized in pkt instantiation 
	fac_pkt.print();

	factory.print();
	$finish;
end

//TO DO complete the below task
task drive_packet (htax_packet_c pkt);

//At every posedge of clk load each data packet from pkt.data to variable data
//The whole time the bit of variable port equal to pkt.dest_port is 1 and rest bits are 0
//Assign port = 4'bx and data = 64'bx after the last data packet


//Defining a variable i which has width same as that of the data.length
logic [5:0] i;

//Running a for loop for assigning the random data value to the 
//given data field and port value to the given dest_port field
for (i='b0; i<pkt.length; i++)  begin
	@(posedge clk);

	// The following case statement behaves as an decoder where we
	// assign the port field to choose either of the port where the bit is set
	// I.e. 0001, 0010, 0100, 1000
	case(pkt.dest_port) 
		'b00: port = 4'b0001;	
		'b01: port = 4'b0010;	
		'b10: port = 4'b0100;	
		'b11: port = 4'b1000;
		default: port = 4'b0001;
	endcase 

	// Assigning the randomized data value for each length to the given data field
	data = pkt.data[i];
end

// Assign the port and data field to X as defined in the TODO list 
port = 4'bx;
data = 64'bx;
	
endtask : drive_packet
endmodule
