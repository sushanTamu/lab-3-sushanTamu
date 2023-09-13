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

	// UVM factory instantiation
	//randomize fac_pkt
	//print fac_pkt
	//drive fac_pkt

	factory.print();
	#10 $finish;
end

//TO DO complete the below task
task drive_packet (htax_packet_c pkt); 
//At every posedge of clk load each data packet from pkt.data to variable data
//The whole time the bit of variable port equal to pkt.dest_port is 1 and rest bits are 0
//Assign port = 4'bx and data = 64'bx after the last data packet
endtask : drive_packet
endmodule
