
B
Command: %s
53*	vivadotcl2
phys_opt_designZ4-113h px� 

@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
Implementation2	
xc7z015Z17-347h px� 
o
0Got license for feature '%s' and/or device '%s'
310*common2
Implementation2	
xc7z015Z17-349h px� 
R

Starting %s Task
103*constraints2
Initial Update TimingZ18-103h px� 
}

%s
*constraints2]
[Time (s): cpu = 00:00:04 ; elapsed = 00:00:02 . Memory (MB): peak = 2490.711 ; gain = 8.559h px� 
�
^PhysOpt_Tcl_Interface Runtime Before Starting Physical Synthesis Task | CPU: %ss |  WALL: %ss
566*	vivadotcl2
4.002
2.11Z4-1435h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0032

2490.7622
0.051Z17-268h px� 
O

Starting %s Task
103*constraints2
Physical SynthesisZ18-103h px� 
^

Phase %s%s
101*constraints2
1 2#
!Physical Synthesis InitializationZ18-101h px� 
n
EMultithreading enabled for phys_opt_design using a maximum of %s CPUs380*physynth2
2Z32-721h px� 
q
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-2.8562
-2.856Z32-619h px� 
[
%s*common2B
@Phase 1 Physical Synthesis Initialization | Checksum: 15e09d930
h px� 
�

%s
*constraints2a
_Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.755 . Memory (MB): peak = 2493.070 ; gain = 2.309h px� 
q
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-2.8562
-2.856Z32-619h px� 
V

Phase %s%s
101*constraints2
2 2
DSP Register OptimizationZ18-101h px� 
j
FNo candidate cells for DSP register optimization found in the design.
274*physynthZ32-456h px� 
�
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
22
02
net or cell2
02
cell2
02
cell2
02
cellZ32-775h px� 
S
%s*common2:
8Phase 2 DSP Register Optimization | Checksum: 15e09d930
h px� 
�

%s
*constraints2a
_Time (s): cpu = 00:00:02 ; elapsed = 00:00:00.827 . Memory (MB): peak = 2493.070 ; gain = 2.309h px� 
W

Phase %s%s
101*constraints2
3 2
Critical Path OptimizationZ18-101h px� 
q
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-2.8562
-2.856Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2�
zdut/u_e203_subsys_top/u_e203_subsys_main/u_e203_subsys_perips/u_perips_apb_pwm/u_tim2/u_in_stage/r_ls_clk_sync_reg_n_0_[0]zdut/u_e203_subsys_top/u_e203_subsys_main/u_e203_subsys_perips/u_perips_apb_pwm/u_tim2/u_in_stage/r_ls_clk_sync_reg_n_0_[0]8Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2F
 sys_clk_gen/inst/CLK_O_8M388_PLL sys_clk_gen/inst/CLK_O_8M388_PLL8Z32-702h px� 
�
'Processed net %s. Replicated %s times.
81*physynth24
rtc_clk_gen/CLK32768KHZrtc_clk_gen/CLK32768KHZ2
18Z32-81h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth24
rtc_clk_gen/CLK32768KHZrtc_clk_gen/CLK32768KHZ8Z32-735h px� 
q
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-2.8452
-2.845Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2>
rtc_clk_gen/CLK32768KHZ_repNrtc_clk_gen/CLK32768KHZ_repN8Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2�
zdut/u_e203_subsys_top/u_e203_subsys_main/u_e203_subsys_perips/u_perips_apb_pwm/u_tim2/u_in_stage/r_ls_clk_sync_reg_n_0_[0]zdut/u_e203_subsys_top/u_e203_subsys_main/u_e203_subsys_perips/u_perips_apb_pwm/u_tim2/u_in_stage/r_ls_clk_sync_reg_n_0_[0]8Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2F
 sys_clk_gen/inst/CLK_O_8M388_PLL sys_clk_gen/inst/CLK_O_8M388_PLL8Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2>
rtc_clk_gen/CLK32768KHZ_repNrtc_clk_gen/CLK32768KHZ_repN8Z32-702h px� 
q
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-2.8452
-2.845Z32-619h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0052

2493.0702
0.000Z17-268h px� 
T
%s*common2;
9Phase 3 Critical Path Optimization | Checksum: 15e09d930
h px� 
}

%s
*constraints2]
[Time (s): cpu = 00:00:02 ; elapsed = 00:00:01 . Memory (MB): peak = 2493.070 ; gain = 2.309h px� 
W

Phase %s%s
101*constraints2
4 2
Critical Path OptimizationZ18-101h px� 
q
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-2.8452
-2.845Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2�
zdut/u_e203_subsys_top/u_e203_subsys_main/u_e203_subsys_perips/u_perips_apb_pwm/u_tim2/u_in_stage/r_ls_clk_sync_reg_n_0_[0]zdut/u_e203_subsys_top/u_e203_subsys_main/u_e203_subsys_perips/u_perips_apb_pwm/u_tim2/u_in_stage/r_ls_clk_sync_reg_n_0_[0]8Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2F
 sys_clk_gen/inst/CLK_O_8M388_PLL sys_clk_gen/inst/CLK_O_8M388_PLL8Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2>
rtc_clk_gen/CLK32768KHZ_repNrtc_clk_gen/CLK32768KHZ_repN8Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2�
zdut/u_e203_subsys_top/u_e203_subsys_main/u_e203_subsys_perips/u_perips_apb_pwm/u_tim2/u_in_stage/r_ls_clk_sync_reg_n_0_[0]zdut/u_e203_subsys_top/u_e203_subsys_main/u_e203_subsys_perips/u_perips_apb_pwm/u_tim2/u_in_stage/r_ls_clk_sync_reg_n_0_[0]8Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2F
 sys_clk_gen/inst/CLK_O_8M388_PLL sys_clk_gen/inst/CLK_O_8M388_PLL8Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2>
rtc_clk_gen/CLK32768KHZ_repNrtc_clk_gen/CLK32768KHZ_repN8Z32-702h px� 
q
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-2.8452
-2.845Z32-619h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0042

2493.0702
0.000Z17-268h px� 
T
%s*common2;
9Phase 4 Critical Path Optimization | Checksum: 15e09d930
h px� 
}

%s
*constraints2]
[Time (s): cpu = 00:00:03 ; elapsed = 00:00:01 . Memory (MB): peak = 2493.070 ; gain = 2.309h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0042

2493.0702
0.000Z17-268h px� 
v
>Post Physical Optimization Timing Summary | WNS=%s | TNS=%s |
318*physynth2
-2.8452
-2.845Z32-603h px� 
B
-
Summary of Physical Synthesis Optimizations
*commonh px� 
B
-============================================
*commonh px� 


*commonh px� 


*commonh px� 
�
�-------------------------------------------------------------------------------------------------------------------------------------------------------------
*commonh px� 
�
�|  Optimization   |  WNS Gain (ns)  |  TNS Gain (ns)  |  Added Cells  |  Removed Cells  |  Optimized Cells/Nets  |  Dont Touch  |  Iterations  |  Elapsed   |
-------------------------------------------------------------------------------------------------------------------------------------------------------------
*commonh px� 
�
�|  DSP Register   |          0.000  |          0.000  |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  Critical Path  |          0.011  |          0.011  |            1  |              0  |                     1  |           0  |           2  |  00:00:00  |
|  Total          |          0.011  |          0.011  |            1  |              0  |                     1  |           0  |           3  |  00:00:00  |
-------------------------------------------------------------------------------------------------------------------------------------------------------------
*commonh px� 


*commonh px� 


*commonh px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0042

2493.0702
0.000Z17-268h px� 
P
%s*common27
5Ending Physical Synthesis Task | Checksum: 16ccbc2aa
h px� 
}

%s
*constraints2]
[Time (s): cpu = 00:00:03 ; elapsed = 00:00:01 . Memory (MB): peak = 2493.070 ; gain = 2.309h px� 
H
Releasing license: %s
83*common2
ImplementationZ17-83h px� 

G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
1182
12
02
0Z4-41h px� 
O
%s completed successfully
29*	vivadotcl2
phys_opt_designZ4-42h px� 
H
&Writing timing data to binary archive.266*timingZ38-480h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Write ShapeDB Complete: 2

00:00:002
00:00:00.0162

2493.0702
0.000Z17-268h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Wrote PlaceDB: 2

00:00:022
00:00:00.8412

2493.0702
0.000Z17-268h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Wrote PulsedLatchDB: 2

00:00:002

00:00:002

2493.0702
0.000Z17-268h px� 
=
Writing XDEF routing.
211*designutilsZ20-211h px� 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px� 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Wrote RouteStorage: 2

00:00:002
00:00:00.0272

2493.0702
0.000Z17-268h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Wrote Netlist Cache: 2

00:00:002
00:00:00.0142

2493.0702
0.000Z17-268h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Wrote Device Cache: 2

00:00:002
00:00:00.0052

2493.0702
0.000Z17-268h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Write Physdb Complete: 2

00:00:022
00:00:00.8962

2493.0702
0.000Z17-268h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2Y
WE:/Project/E203_P1_Zynq7015_copy/E203_P1_Zynq7015_copy.runs/impl_1/aic_rv32_physopt.dcpZ17-1381h px� 


End Record