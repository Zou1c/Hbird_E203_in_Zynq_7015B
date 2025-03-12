// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
// Date        : Thu Feb 27 18:39:06 2025
// Host        : DESKTOP-QI8EAU8 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               e:/Project/E203_P1_Zynq7015_copy/E203_P1_Zynq7015_copy.gen/sources_1/ip/PLL/PLL_stub.v
// Design      : PLL
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z015clg485-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module PLL(CLK_O_16M, CLK_O_8M388, resetn, locked, 
  CLK_I_50M)
/* synthesis syn_black_box black_box_pad_pin="resetn,locked,CLK_I_50M" */
/* synthesis syn_force_seq_prim="CLK_O_16M" */
/* synthesis syn_force_seq_prim="CLK_O_8M388" */;
  output CLK_O_16M /* synthesis syn_isclock = 1 */;
  output CLK_O_8M388 /* synthesis syn_isclock = 1 */;
  input resetn;
  output locked;
  input CLK_I_50M;
endmodule
