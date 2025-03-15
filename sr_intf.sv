/*
interface sr_intf(input clk,input rst);
  bit [1:0]sr;
  bit q;
  bit qbar;
endinterface
*/


interface sr_intf(input logic clk, input logic rst);
  logic [1:0] sr;   // SR input
  logic q;          // Output Q
  logic qbar;       // Output Q'
endinterface
