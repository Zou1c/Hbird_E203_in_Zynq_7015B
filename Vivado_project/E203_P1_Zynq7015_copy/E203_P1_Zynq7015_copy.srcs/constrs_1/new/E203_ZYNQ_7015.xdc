#============================================================================
#
#
#	Jiyuan
# 
#   It seems that ONLY the first 3 part is Necessary(clock&reset, JTAG, UART)
#   But it is not what it seems like. You need to set all port to a PIN(If you dont modify verilog files)
#----------------------------------------------------------------------------

#=========================== Sys Clock & rstn ================================
## Clock Signal     50M
set_property -dict { PACKAGE_PIN Y14    IOSTANDARD LVCMOS33 } [get_ports { clk }]; #change K17 to Y14
create_clock -add -name sys_clk_pin -period 20.00 -waveform {0 10} [get_ports clk]

## mcu Rst_n
set_property -dict { PACKAGE_PIN AB12  IOSTANDARD LVCMOS33 } [get_ports { mcu_rst }]; #change PL_KEY1-M20 to PL_KEY-AB12
#----------------------------------------------------------------------------



#=========================== Debug JTAG ======================================
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets IOBUF_jtag_TCK/O]

# mcu_TCK
# mcu_TDO
# mcu_TMS
# rst
# mcu_TDI
# JTAG Debug Port
## number30 to number36


set_property -dict { PACKAGE_PIN V18  IOSTANDARD LVCMOS33 } [get_ports { mcu_TCK }]; #TCK 
set_property -dict { PACKAGE_PIN AB21  IOSTANDARD LVCMOS33 } [get_ports { mcu_TDO }]; #TDO
set_property -dict { PACKAGE_PIN AA19  IOSTANDARD LVCMOS33 } [get_ports { mcu_TMS }]; #TMS
set_property -dict { PACKAGE_PIN R17  IOSTANDARD LVCMOS33 } [get_ports { mcu_TDI }]; #TDI
set_property KEEPER true [get_ports mcu_TMS]
#----------------------------------------- ----------------------------------

#=============================== UART 0 ======================================

#3 5
set_property -dict { PACKAGE_PIN M1   IOSTANDARD LVCMOS33 } [get_ports { uart0_tx }]; #UART data output(UART_TXD)
set_property -dict { PACKAGE_PIN Y13   IOSTANDARD LVCMOS33 } [get_ports { uart0_rx }]; #UART data input(UART_RXD)

#-----------------------------------------------------------------------------


### in 7015B
### UserLed2(center_board) ---> T16
### UserLed1(base_board)--PL_LED1 ---> A5
### UserLed2(base_board)--PL_LED2 ---> A7
### UserLed3(base_board)--PL_LED3 ---> A6
### UserLed4(base_board)--PL_LED4 ---> B8
### PL_KEY ---> AB12

## GPIOA
#LEDs
set_property -dict { PACKAGE_PIN A5   IOSTANDARD LVCMOS33 } [get_ports { gpioA_0 }]; # A5-gpioA_0
set_property -dict { PACKAGE_PIN A7   IOSTANDARD LVCMOS33 } [get_ports { gpioA_1 }]; # A7-gpioA_1
set_property -dict { PACKAGE_PIN A6   IOSTANDARD LVCMOS33 } [get_ports { gpioA_2 }]; # A6-gpioA_2
set_property -dict { PACKAGE_PIN B8   IOSTANDARD LVCMOS33 } [get_ports { gpioA_3 }]; # B8-gpioA_3

#KEY
#set_property -dict { PACKAGE_PIN AB12   IOSTANDARD LVCMOS33 } [get_ports { gpioA_4 }]; # AB12-gpioA_4

# 40P
set_property -dict { PACKAGE_PIN W15   IOSTANDARD LVCMOS33 } [get_ports { gpioA_5 }]; # 19
set_property -dict { PACKAGE_PIN Y17   IOSTANDARD LVCMOS33 } [get_ports { gpioA_6 }]; # 21
set_property -dict { PACKAGE_PIN AB14   IOSTANDARD LVCMOS33 } [get_ports { gpioA_7 }]; # 23
## IO1_15p-number32
## IO1_14p-number30
## IO1_13p-number28

### OLED Display(number25-35)
#set_property -dict { PACKAGE_PIN W15   IOSTANDARD LVCMOS33 } [get_ports { gpioA_20 }]; #OLED_DC          40pin number25
#set_property -dict { PACKAGE_PIN Y17   IOSTANDARD LVCMOS33 } [get_ports { gpioA_21 }]; #OLED_RES         
#set_property -dict { PACKAGE_PIN W18   IOSTANDARD LVCMOS33 } [get_ports { gpioA_22 }]; #OLED_CLK   D0    
#set_property -dict { PACKAGE_PIN AB22   IOSTANDARD LVCMOS33 } [get_ports { gpioA_23 }]; #OLED_SDIN  D1    
#set_property -dict { PACKAGE_PIN AA20   IOSTANDARD LVCMOS33 } [get_ports { gpioA_24 }]; #VBAT             
#set_property -dict { PACKAGE_PIN T17   IOSTANDARD LVCMOS33 } [get_ports { gpioA_25 }]; #VDD              number 35