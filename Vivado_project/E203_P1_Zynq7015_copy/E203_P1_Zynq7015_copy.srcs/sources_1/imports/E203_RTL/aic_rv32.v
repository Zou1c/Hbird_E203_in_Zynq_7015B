`timescale 1ns/1ps
/*
*
*
*
* @Author: xiebing
*
* @Mail:binxie@stu.xidian.edu.cn
*
*
*/
module aic_rv32
(

  //----------------input clock----------------
  //  clk--->K17
  input wire clk,
  

  //----------------reset signal----------------
  //  rst_n--->M20
  input wire mcu_rst, //MCU_RESET


  // Dedicated QSPI interface
  // output wire qspi0_cs,
  // output wire qspi0_sck,
  // inout wire [3:0] qspi0_dq,
  /*
  GPIOA++FUNCTION:            GPIOB++FUNCTION:
      0--->PWM0_0                  PWM2_0
      1--->PWM0_1                  PWM2_1
      2--->PWM0_2                  PWM2_2
      3--->PWM0_3                  PWM2_3
      4--->PWM1_0                  PWM3_0
      5--->PWM1_1                  PWM3_1
      6--->PWM1_2                  PWM3_2
      7--->PWM1_3                  PWM3_3

      8--->QSPI1:SCK               QSPI2:SCK
      9--->QSPI1:CS                QSPI2:CS
      10--->QSPI1:DQ0              QSPI2:DQ0
      11--->QSPI1:DQ1              QSPI2:DQ1
      12--->QSPI1:DQ2              QSPI2:DQ2
      13--->QSPI1:DQ3              QSPI2:DQ3

      14--->I2C0:SCL               I2C1:SCL
      15--->I2C0:SDA               I2C1:SDA

      16--->UART0:RX               UART1:RX
      17--->UART0:TX               UART1:TX
      18--->UART2:RX
      19--->UART2:TX
  */                        

  //  RX--->N18
  //  TX--->N20
  inout wire uart0_rx,
  inout wire uart0_tx,

  // inout wire uart1_rx,
  // inout wire uart1_tx,

  // inout wire uart2_rx,
  // inout wire uart2_tx,

  //some leds
  //  led1---> T12
  //  led2---> U12
  //  led3---> V12
  //  led4---> W13
  inout wire gpioA_0,
  inout wire gpioA_1,
  inout wire gpioA_2,
  inout wire gpioA_3,

  // Key
  // PL_KEY2--->M19
//  inout wire gpioA_4,

  // 40P GPIO
  inout wire gpioA_5, //P18
  inout wire gpioA_6, //P19
  inout wire gpioA_7, //R19
  
  //oled display
//  inout wire gpioA_20, //OLED_DC        Y14
//  inout wire gpioA_21, //OLED_RES       V16
//  inout wire gpioA_22, //OLED_CLK       U18  
//  inout wire gpioA_23, //OLED_SDIN      T17
//  inout wire gpioA_24, //VBAT           R17
//  inout wire gpioA_25, //VDD            W20



  //some GPIO B
  // inout wire gpioB_0, // W16
  // inout wire gpioB_1, // T16
  // inout wire gpioB_2, // R16
  // inout wire gpioB_3, // P16
  // inout wire gpioB_4, // W14
  // inout wire gpioB_5, // N17
  // inout wire gpioB_6, // W19
  // inout wire gpioB_7, // Y19


  // rv_jtag
  //  MCU_TDO--->
  //  MCU_TCK--->
  //  MCU_TDI--->
  //  MCU_TMS--->
  //  mcu_TCK
  //  mcu_TDO
  //  mcu_TMS
  //  mcu_RST
  //  mcu_TDI
  inout wire mcu_TCK,
  inout wire mcu_TDO,
  inout wire mcu_TMS,
  inout wire mcu_TDI

  //pmu_wakeup

  // inout wire pmu_paden,  //PMU_VDDPADEN
  // inout wire pmu_padrst, //PMU_VADDPARST
  // inout wire mcu_wakeup  //MCU_WAKE
);

  wire pll_locked;


  wire ck_rst;

  // All wires connected to the chip top
  wire dut_clock;
  wire dut_reset;

  wire dut_io_pads_jtag_TCK_i_ival;
  wire dut_io_pads_jtag_TMS_i_ival;
  wire dut_io_pads_jtag_TMS_o_oval;
  wire dut_io_pads_jtag_TMS_o_oe;
  wire dut_io_pads_jtag_TMS_o_ie;
  wire dut_io_pads_jtag_TMS_o_pue;
  wire dut_io_pads_jtag_TMS_o_ds;
  wire dut_io_pads_jtag_TDI_i_ival;
  wire dut_io_pads_jtag_TDO_o_oval;
  wire dut_io_pads_jtag_TDO_o_oe;

  wire [31:0] gpioA;
  wire [31:0] gpioB;


  wire [32-1:0] dut_io_pads_gpioA_i_ival;
  wire [32-1:0] dut_io_pads_gpioA_o_oval;
  wire [32-1:0] dut_io_pads_gpioA_o_oe;

  wire [32-1:0] dut_io_pads_gpioB_i_ival;
  wire [32-1:0] dut_io_pads_gpioB_o_oval;
  wire [32-1:0] dut_io_pads_gpioB_o_oe;




  wire dut_io_pads_aon_erst_n_i_ival;
  wire dut_io_pads_aon_pmu_dwakeup_n_i_ival;
  wire dut_io_pads_aon_pmu_vddpaden_o_oval;
  wire dut_io_pads_aon_pmu_padrst_o_oval ;
  wire dut_io_pads_bootrom_n_i_ival;
  wire dut_io_pads_dbgmode0_n_i_ival;
  wire dut_io_pads_dbgmode1_n_i_ival;
  wire dut_io_pads_dbgmode2_n_i_ival;

  //=================================================
  // Clock & Reset
  wire clk_8388;
  wire clk_16M;
  
  //wire CLK200MHZ;//GCLK
  wire CLK32768KHZ;//RTC_CLK
  

  PLL sys_clk_gen
  (
    .resetn      (ck_rst    ),
    .CLK_I_50M   (clk       ),
    .CLK_O_16M   (clk_16M   ), // 16 MHz, this clock we set to 16MHz
    .CLK_O_8M388 (clk_8388  ),
    .locked      (pll_locked)
  );


  clkdivider rtc_clk_gen(
    .clk         (clk_8388   ),//generate 32.768KHz
    .reset       (~pll_locked),
    .clk_out     (CLK32768KHZ)
  );

  assign ck_rst = mcu_rst;

  

  //=================SPI0 Interface==================

  // //IOBUF Signal
  // wire [3:0] qspi0_ui_dq_o; 
  // wire [3:0] qspi0_ui_dq_oe;
  // wire [3:0] qspi0_ui_dq_i;

  // assign qspi0_sck = dut_io_pads_qspi0_sck_o_oval;
  // assign qspi0_cs  = dut_io_pads_qspi0_cs_0_o_oval;
  // assign qspi0_ui_dq_o = {
  //   dut_io_pads_qspi0_dq_3_o_oval,
  //   dut_io_pads_qspi0_dq_2_o_oval,
  //   dut_io_pads_qspi0_dq_1_o_oval,
  //   dut_io_pads_qspi0_dq_0_o_oval
  // };
  // assign qspi0_ui_dq_oe = {
  //   dut_io_pads_qspi0_dq_3_o_oe,
  //   dut_io_pads_qspi0_dq_2_o_oe,
  //   dut_io_pads_qspi0_dq_1_o_oe,
  //   dut_io_pads_qspi0_dq_0_o_oe
  // };
  // assign dut_io_pads_qspi0_dq_0_i_ival = qspi0_ui_dq_i[0];
  // assign dut_io_pads_qspi0_dq_1_i_ival = qspi0_ui_dq_i[1];
  // assign dut_io_pads_qspi0_dq_2_i_ival = qspi0_ui_dq_i[2];
  // assign dut_io_pads_qspi0_dq_3_i_ival = qspi0_ui_dq_i[3];

  // IOBUF qspi0_iobuf[3:0]
  // (
  //   .IO(qspi0_dq),
  //   .O(qspi0_ui_dq_i),//buffer output
  //   .I(qspi0_ui_dq_o),//buffer input
  //   .T(~qspi0_ui_dq_oe)//high---input; low---output
  // );

  // PULLUP qspi0_pullup[3:0]
  // (
  //   .O(qspi0_dq)
  // );

  //=================GPIO Interface==================
/*
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  gpioA_iobuf[31:0]
  (
    .O(dut_io_pads_gpioA_i_ival),
    .IO(gpioA),
    .I(dut_io_pads_gpioA_o_oval),
    .T(~dut_io_pads_gpioA_o_oe)
  );

  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  gpioB_iobuf[31:0]
  (
    .O(dut_io_pads_gpioB_i_ival),
    .IO(gpioB),
    .I(dut_io_pads_gpioB_o_oval),
    .T(~dut_io_pads_gpioB_o_oe)
  );
  */
  //==================JTAG Interface====================

  wire iobuf_jtag_TCK_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_jtag_TCK
  (
    .O(iobuf_jtag_TCK_o),
    .IO(mcu_TCK),
    .I(1'b0),
    .T(1'b1) //output
  );
  assign dut_io_pads_jtag_TCK_i_ival = iobuf_jtag_TCK_o ;
  PULLUP pullup_TCK 
  (
    .O(mcu_TCK)
  );

  wire iobuf_jtag_TMS_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_jtag_TMS
  (
    .O(iobuf_jtag_TMS_o),
    .IO(mcu_TMS),
    .I(1'b0),
    .T(1'b1) //output
  );
  assign dut_io_pads_jtag_TMS_i_ival = iobuf_jtag_TMS_o;
  PULLUP pullup_TMS 
  (
    .O(mcu_TMS)
  );


  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_jtag_TDI
  (
    .O(dut_io_pads_jtag_TDI_i_ival),
    .IO(mcu_TDI),
    .I(1'b0),
    .T(1'b1)
  );

  PULLUP pullup_TDI 
  (
    .O(mcu_TDI)
  );

  wire iobuf_jtag_TDO_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_jtag_TDO
  (
    .O(iobuf_jtag_TDO_o),
    .IO(mcu_TDO),
    .I(dut_io_pads_jtag_TDO_o_oval),
    .T(~dut_io_pads_jtag_TDO_o_oe)
  );


  //=================================================
  // Assignment of IOBUF "IO" pins to package pins

  // Pins IO0-IO13
  // Shield header row 0: PD0-PD7

  // Use the LEDs for some more useful debugging things.
  // assign pmu_paden  = dut_io_pads_aon_pmu_vddpaden_o_oval;  
  // assign pmu_padrst = dut_io_pads_aon_pmu_padrst_o_oval;		

  //==================model select===================
  // 0:internal ROM    (0x0000_1000)~0x0000_1FFFF
  // 1:from QSPI_FLASH (0x2000_0000)
  assign dut_io_pads_bootrom_n_i_ival  = 1'b0;
  //=================================================

  //
  assign dut_io_pads_dbgmode0_n_i_ival = 1'b1;
  assign dut_io_pads_dbgmode1_n_i_ival = 1'b1;
  assign dut_io_pads_dbgmode2_n_i_ival = 1'b1;
  //

  e203_soc_top dut
  (
    //System CLOCK
    .hfextclk(clk_16M),
    .hfxoscen(1'b1),

    //RTC CLOCK
    .lfextclk(CLK32768KHZ), 
    .lfxoscen(1'b1),

    //JTAG
    .io_pads_jtag_TCK_i_ival(dut_io_pads_jtag_TCK_i_ival),
    .io_pads_jtag_TMS_i_ival(dut_io_pads_jtag_TMS_i_ival),
    .io_pads_jtag_TDI_i_ival(dut_io_pads_jtag_TDI_i_ival),
    .io_pads_jtag_TDO_o_oval(dut_io_pads_jtag_TDO_o_oval),
    .io_pads_jtag_TDO_o_oe  (dut_io_pads_jtag_TDO_o_oe),

    //GPIO A
    .io_pads_gpioA_i_ival(dut_io_pads_gpioA_i_ival),
    .io_pads_gpioA_o_oval(dut_io_pads_gpioA_o_oval),
    .io_pads_gpioA_o_oe  (dut_io_pads_gpioA_o_oe),
    //GPIO B
    .io_pads_gpioB_i_ival(dut_io_pads_gpioB_i_ival),
    .io_pads_gpioB_o_oval(dut_io_pads_gpioB_o_oval),
    .io_pads_gpioB_o_oe  (dut_io_pads_gpioB_o_oe),

    //QPSI
    .io_pads_qspi0_sck_o_oval (),
    .io_pads_qspi0_cs_0_o_oval(),
    .io_pads_qspi0_dq_0_i_ival(),
    .io_pads_qspi0_dq_0_o_oval(),
    .io_pads_qspi0_dq_0_o_oe  (),
    .io_pads_qspi0_dq_1_i_ival(),
    .io_pads_qspi0_dq_1_o_oval(),
    .io_pads_qspi0_dq_1_o_oe  (),
    .io_pads_qspi0_dq_2_i_ival(),
    .io_pads_qspi0_dq_2_o_oval(),
    .io_pads_qspi0_dq_2_o_oe  (),
    .io_pads_qspi0_dq_3_i_ival(),
    .io_pads_qspi0_dq_3_o_oval(),
    .io_pads_qspi0_dq_3_o_oe  (),
    /*
    //QPSI
    .io_pads_qspi0_sck_o_oval (dut_io_pads_qspi0_sck_o_oval),
    .io_pads_qspi0_cs_0_o_oval(dut_io_pads_qspi0_cs_0_o_oval),

    .io_pads_qspi0_dq_0_i_ival(dut_io_pads_qspi0_dq_0_i_ival),
    .io_pads_qspi0_dq_0_o_oval(dut_io_pads_qspi0_dq_0_o_oval),
    .io_pads_qspi0_dq_0_o_oe  (dut_io_pads_qspi0_dq_0_o_oe),
    .io_pads_qspi0_dq_1_i_ival(dut_io_pads_qspi0_dq_1_i_ival),
    .io_pads_qspi0_dq_1_o_oval(dut_io_pads_qspi0_dq_1_o_oval),
    .io_pads_qspi0_dq_1_o_oe  (dut_io_pads_qspi0_dq_1_o_oe),
    .io_pads_qspi0_dq_2_i_ival(dut_io_pads_qspi0_dq_2_i_ival),
    .io_pads_qspi0_dq_2_o_oval(dut_io_pads_qspi0_dq_2_o_oval),
    .io_pads_qspi0_dq_2_o_oe  (dut_io_pads_qspi0_dq_2_o_oe),
    .io_pads_qspi0_dq_3_i_ival(dut_io_pads_qspi0_dq_3_i_ival),
    .io_pads_qspi0_dq_3_o_oval(dut_io_pads_qspi0_dq_3_o_oval),
    .io_pads_qspi0_dq_3_o_oe  (dut_io_pads_qspi0_dq_3_o_oe),
    */
    //RST_N
    .io_pads_aon_erst_n_i_ival(ck_rst),

    //PMU
    .io_pads_aon_pmu_dwakeup_n_i_ival(),
    .io_pads_aon_pmu_vddpaden_o_oval (),

    .io_pads_aon_pmu_padrst_o_oval   (),

    /*
    .io_pads_aon_pmu_dwakeup_n_i_ival(dut_io_pads_aon_pmu_dwakeup_n_i_ival),
    .io_pads_aon_pmu_vddpaden_o_oval(dut_io_pads_aon_pmu_vddpaden_o_oval),

    .io_pads_aon_pmu_padrst_o_oval    (dut_io_pads_aon_pmu_padrst_o_oval ),
    */


    .io_pads_bootrom_n_i_ival        (dut_io_pads_bootrom_n_i_ival),

    .io_pads_dbgmode0_n_i_ival       (dut_io_pads_dbgmode0_n_i_ival),
    .io_pads_dbgmode1_n_i_ival       (dut_io_pads_dbgmode1_n_i_ival),
    .io_pads_dbgmode2_n_i_ival       (dut_io_pads_dbgmode2_n_i_ival) 
    
  );

  // Assign reasonable values to otherwise unconnected inputs to chip top
/*
  wire iobuf_dwakeup_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_dwakeup_n
  (
    .O(iobuf_dwakeup_o),
    .IO(mcu_wakeup),
    .I(1'b1),
    .T(1'b1)
  );
  assign dut_io_pads_aon_pmu_dwakeup_n_i_ival = (~iobuf_dwakeup_o);

  assign dut_io_pads_aon_pmu_vddpaden_i_ival = 1'b1;
*/
//-----------------GPIO for UART-------------------
//      16--->UART0:RX               UART1:RX
//      17--->UART0:TX               UART1:TX
//      18--->UART2:RX
//      19--->UART2:TX
//UART0
  IOBUF #(.DRIVE (12), .IBUF_LOW_PWR("TRUE"),.IOSTANDARD ("DEFAULT"),.SLEW ("SLOW"))
  uart0_rx_iobuf
  (
    .O  (dut_io_pads_gpioA_i_ival[16]),   // Buffer output
    .IO (uart0_rx),                       // Buffer inout port (connect directly to top-level port)
    .I  (dut_io_pads_gpioA_o_oval[16]),   // Buffer input
    .T  (~dut_io_pads_gpioA_o_oe[16])     // 3-state enable input, high=input, low=output
  );
  IOBUF #(.DRIVE (12), .IBUF_LOW_PWR("TRUE"),.IOSTANDARD ("DEFAULT"),.SLEW ("SLOW"))
  uart0_tx_iobuf
  (
    .O  (dut_io_pads_gpioA_i_ival[17]),
    .IO (uart0_tx),
    .I  (dut_io_pads_gpioA_o_oval[17]),
    .T  (~dut_io_pads_gpioA_o_oe[17])
  );

// //UART1
//   IOBUF #(.DRIVE (12), .IBUF_LOW_PWR("TRUE"),.IOSTANDARD ("DEFAULT"),.SLEW ("SLOW"))
//   uart1_rx_iobuf
//   (
//     .O  (dut_io_pads_gpioB_i_ival[16]),
//     .IO (uart1_rx),
//     .I  (dut_io_pads_gpioB_o_oval[16]),
//     .T  (~dut_io_pads_gpioB_o_oe[16])
//   );
//   IOBUF #(.DRIVE (12), .IBUF_LOW_PWR("TRUE"),.IOSTANDARD ("DEFAULT"),.SLEW ("SLOW"))
//   uart1_tx_iobuf
//   (
//     .O  (dut_io_pads_gpioB_i_ival[17]),
//     .IO (uart1_tx),
//     .I  (dut_io_pads_gpioB_o_oval[17]),
//     .T  (~dut_io_pads_gpioB_o_oe[17])
//   );

// //UART2
//   IOBUF #(.DRIVE (12), .IBUF_LOW_PWR("TRUE"),.IOSTANDARD ("DEFAULT"),.SLEW ("SLOW"))
//   uart2_rx_iobuf
//   (
//     .O  (dut_io_pads_gpioA_i_ival[18]),
//     .IO (uart2_rx),
//     .I  (dut_io_pads_gpioA_o_oval[18]),
//     .T  (~dut_io_pads_gpioA_o_oe[18])
//   );
//   IOBUF #(.DRIVE (12), .IBUF_LOW_PWR("TRUE"),.IOSTANDARD ("DEFAULT"),.SLEW ("SLOW"))
//   uart2_tx_iobuf
//   (
//     .O  (dut_io_pads_gpioA_i_ival[19]),
//     .IO (uart2_tx),
//     .I  (dut_io_pads_gpioA_o_oval[19]),
//     .T  (~dut_io_pads_gpioA_o_oe[19])
//   );




//-----------------GPIO for LEDs-------------------
  IOBUF #(.DRIVE (12), .IBUF_LOW_PWR("TRUE"),.IOSTANDARD ("DEFAULT"),.SLEW ("SLOW"))
  gpioA_0_iobuf
  (
    .O  (dut_io_pads_gpioA_i_ival[0]),
    .IO (gpioA_0),
    .I  (dut_io_pads_gpioA_o_oval[0]),
    .T  (~dut_io_pads_gpioA_o_oe[0])
  );

  IOBUF #(.DRIVE (12), .IBUF_LOW_PWR("TRUE"),.IOSTANDARD ("DEFAULT"),.SLEW ("SLOW"))
  gpioA_1_iobuf
  (
    .O  (dut_io_pads_gpioA_i_ival[1]),
    .IO (gpioA_1),
    .I  (dut_io_pads_gpioA_o_oval[1]),
    .T  (~dut_io_pads_gpioA_o_oe[1])
  );

  IOBUF #(.DRIVE (12), .IBUF_LOW_PWR("TRUE"),.IOSTANDARD ("DEFAULT"),.SLEW ("SLOW"))
  gpioA_2_iobuf
  (
    .O  (dut_io_pads_gpioA_i_ival[2]),
    .IO (gpioA_2),
    .I  (dut_io_pads_gpioA_o_oval[2]),
    .T  (~dut_io_pads_gpioA_o_oe[2])
  );

  IOBUF #(.DRIVE (12), .IBUF_LOW_PWR("TRUE"),.IOSTANDARD ("DEFAULT"),.SLEW ("SLOW"))
  gpioA_3_iobuf
  (
    .O  (dut_io_pads_gpioA_i_ival[3]),
    .IO (gpioA_3),
    .I  (dut_io_pads_gpioA_o_oval[3]),
    .T  (~dut_io_pads_gpioA_o_oe[3])
  );

//  IOBUF #(.DRIVE (12), .IBUF_LOW_PWR("TRUE"),.IOSTANDARD ("DEFAULT"),.SLEW ("SLOW"))
//  gpioA_4_iobuf
//  (
//    .O  (dut_io_pads_gpioA_i_ival[4]),
//    .IO (gpioA_4),
//    .I  (dut_io_pads_gpioA_o_oval[4]),
//    .T  (~dut_io_pads_gpioA_o_oe[4])
//  );

  IOBUF #(.DRIVE (12), .IBUF_LOW_PWR("TRUE"),.IOSTANDARD ("DEFAULT"),.SLEW ("SLOW"))
  gpioA_5_iobuf
  (
    .O  (dut_io_pads_gpioA_i_ival[5]),
    .IO (gpioA_5),
    .I  (dut_io_pads_gpioA_o_oval[5]),
    .T  (~dut_io_pads_gpioA_o_oe[5])
  );

  IOBUF #(.DRIVE (12), .IBUF_LOW_PWR("TRUE"),.IOSTANDARD ("DEFAULT"),.SLEW ("SLOW"))
  gpioA_6_iobuf
  (
    .O  (dut_io_pads_gpioA_i_ival[6]),
    .IO (gpioA_6),
    .I  (dut_io_pads_gpioA_o_oval[6]),
    .T  (~dut_io_pads_gpioA_o_oe[6])
  );

  IOBUF #(.DRIVE (12), .IBUF_LOW_PWR("TRUE"),.IOSTANDARD ("DEFAULT"),.SLEW ("SLOW"))
  gpioA_7_iobuf
  (
    .O  (dut_io_pads_gpioA_i_ival[7]),
    .IO (gpioA_7),
    .I  (dut_io_pads_gpioA_o_oval[7]),
    .T  (~dut_io_pads_gpioA_o_oe[7])
  );



//-----------------GPIO for OLED-------------------
//  IOBUF #(.DRIVE (12), .IBUF_LOW_PWR("TRUE"),.IOSTANDARD ("DEFAULT"),.SLEW ("SLOW"))
//  gpioA_20_iobuf
//  (
//    .O  (dut_io_pads_gpioA_i_ival[20]),
//    .IO (gpioA_20),
//    .I  (dut_io_pads_gpioA_o_oval[20]),
//    .T  (~dut_io_pads_gpioA_o_oe[20])
//  );

//  IOBUF #(.DRIVE (12), .IBUF_LOW_PWR("TRUE"),.IOSTANDARD ("DEFAULT"),.SLEW ("SLOW"))
//  gpioA_21_iobuf
//  (
//    .O  (dut_io_pads_gpioA_i_ival[21]),
//    .IO (gpioA_21),
//    .I  (dut_io_pads_gpioA_o_oval[21]),
//    .T  (~dut_io_pads_gpioA_o_oe[21])
//  );

//  IOBUF #(.DRIVE (12), .IBUF_LOW_PWR("TRUE"),.IOSTANDARD ("DEFAULT"),.SLEW ("SLOW"))
//  gpioA_22_iobuf
//  (
//    .O  (dut_io_pads_gpioA_i_ival[22]),
//    .IO (gpioA_22),
//    .I  (dut_io_pads_gpioA_o_oval[22]),
//    .T  (~dut_io_pads_gpioA_o_oe[22])
//  );

//  IOBUF #(.DRIVE (12), .IBUF_LOW_PWR("TRUE"),.IOSTANDARD ("DEFAULT"),.SLEW ("SLOW"))
//  gpioA_23_iobuf
//  (
//    .O  (dut_io_pads_gpioA_i_ival[23]),
//    .IO (gpioA_23),
//    .I  (dut_io_pads_gpioA_o_oval[23]),
//    .T  (~dut_io_pads_gpioA_o_oe[23])
//  );

//  IOBUF #(.DRIVE (12), .IBUF_LOW_PWR("TRUE"),.IOSTANDARD ("DEFAULT"),.SLEW ("SLOW"))
//  gpioA_24_iobuf
//  (
//    .O  (dut_io_pads_gpioA_i_ival[24]),
//    .IO (gpioA_24),
//    .I  (dut_io_pads_gpioA_o_oval[24]),
//    .T  (~dut_io_pads_gpioA_o_oe[24])
//  );

//  IOBUF #(.DRIVE (12), .IBUF_LOW_PWR("TRUE"),.IOSTANDARD ("DEFAULT"),.SLEW ("SLOW"))
//  gpioA_25_iobuf
//  (
//    .O  (dut_io_pads_gpioA_i_ival[25]),
//    .IO (gpioA_25),
//    .I  (dut_io_pads_gpioA_o_oval[25]),
//    .T  (~dut_io_pads_gpioA_o_oe[25])
//  );











//-----------------GPIO for SD Card-------------------
  // IOBUF #(.DRIVE (12), .IBUF_LOW_PWR("TRUE"),.IOSTANDARD ("DEFAULT"),.SLEW ("SLOW"))
  // gpioA_26_iobuf
  // (
  //   .O  (dut_io_pads_gpioA_i_ival[26]),
  //   .IO (gpioA_26),
  //   .I  (dut_io_pads_gpioA_o_oval[26]),
  //   .T  (~dut_io_pads_gpioA_o_oe[26])
  // );

  // IOBUF #(.DRIVE (12), .IBUF_LOW_PWR("TRUE"),.IOSTANDARD ("DEFAULT"),.SLEW ("SLOW"))
  // gpioA_27_iobuf
  // (
  //   .O  (dut_io_pads_gpioA_i_ival[27]),
  //   .IO (gpioA_27),
  //   .I  (dut_io_pads_gpioA_o_oval[27]),
  //   .T  (~dut_io_pads_gpioA_o_oe[27])
  // );

  // IOBUF #(.DRIVE (12), .IBUF_LOW_PWR("TRUE"),.IOSTANDARD ("DEFAULT"),.SLEW ("SLOW"))
  // gpioA_28_iobuf
  // (
  //   .O  (dut_io_pads_gpioA_i_ival[28]),
  //   .IO (gpioA_28),
  //   .I  (dut_io_pads_gpioA_o_oval[28]),
  //   .T  (~dut_io_pads_gpioA_o_oe[28])
  // );

  // IOBUF #(.DRIVE (12), .IBUF_LOW_PWR("TRUE"),.IOSTANDARD ("DEFAULT"),.SLEW ("SLOW"))
  // gpioA_29_iobuf
  // (
  //   .O  (dut_io_pads_gpioA_i_ival[29]),
  //   .IO (gpioA_29),
  //   .I  (dut_io_pads_gpioA_o_oval[29]),
  //   .T  (~dut_io_pads_gpioA_o_oe[29])
  // );

  // IOBUF #(.DRIVE (12), .IBUF_LOW_PWR("TRUE"),.IOSTANDARD ("DEFAULT"),.SLEW ("SLOW"))
  // gpioA_30_iobuf
  // (
  //   .O  (dut_io_pads_gpioA_i_ival[30]),
  //   .IO (gpioA_30),
  //   .I  (dut_io_pads_gpioA_o_oval[30]),
  //   .T  (~dut_io_pads_gpioA_o_oe[30])
  // );

  // IOBUF #(.DRIVE (12), .IBUF_LOW_PWR("TRUE"),.IOSTANDARD ("DEFAULT"),.SLEW ("SLOW"))
  // gpioA_31_iobuf
  // (
  //   .O  (dut_io_pads_gpioA_i_ival[31]),
  //   .IO (gpioA_31),
  //   .I  (dut_io_pads_gpioA_o_oval[31]),
  //   .T  (~dut_io_pads_gpioA_o_oe[31])
  // );













//-----------------GPIO B-------------------
  // IOBUF #(.DRIVE (12), .IBUF_LOW_PWR("TRUE"),.IOSTANDARD ("DEFAULT"),.SLEW ("SLOW"))
  // gpioB_0_iobuf
  // (
  //   .O  (dut_io_pads_gpioB_i_ival[0]),
  //   .IO (gpioB_0),
  //   .I  (dut_io_pads_gpioB_o_oval[0]),
  //   .T  (~dut_io_pads_gpioB_o_oe[0])
  // );
  // IOBUF #(.DRIVE (12), .IBUF_LOW_PWR("TRUE"),.IOSTANDARD ("DEFAULT"),.SLEW ("SLOW"))
  // gpioB_1_iobuf
  // (
  //   .O  (dut_io_pads_gpioB_i_ival[1]),
  //   .IO (gpioB_1),
  //   .I  (dut_io_pads_gpioB_o_oval[1]),
  //   .T  (~dut_io_pads_gpioB_o_oe[1])
  // );
  // IOBUF #(.DRIVE (12), .IBUF_LOW_PWR("TRUE"),.IOSTANDARD ("DEFAULT"),.SLEW ("SLOW"))
  // gpioB_2_iobuf
  // (
  //   .O  (dut_io_pads_gpioB_i_ival[2]),
  //   .IO (gpioB_2),
  //   .I  (dut_io_pads_gpioB_o_oval[2]),
  //   .T  (~dut_io_pads_gpioB_o_oe[2])
  // );
  // IOBUF #(.DRIVE (12), .IBUF_LOW_PWR("TRUE"),.IOSTANDARD ("DEFAULT"),.SLEW ("SLOW"))
  // gpioB_3_iobuf
  // (
  //   .O  (dut_io_pads_gpioB_i_ival[3]),
  //   .IO (gpioB_3),
  //   .I  (dut_io_pads_gpioB_o_oval[3]),
  //   .T  (~dut_io_pads_gpioB_o_oe[3])
  // );
  // IOBUF #(.DRIVE (12), .IBUF_LOW_PWR("TRUE"),.IOSTANDARD ("DEFAULT"),.SLEW ("SLOW"))
  // gpioB_4_iobuf
  // (
  //   .O  (dut_io_pads_gpioB_i_ival[4]),
  //   .IO (gpioB_4),
  //   .I  (dut_io_pads_gpioB_o_oval[4]),
  //   .T  (~dut_io_pads_gpioB_o_oe[4])
  // );
  // IOBUF #(.DRIVE (12), .IBUF_LOW_PWR("TRUE"),.IOSTANDARD ("DEFAULT"),.SLEW ("SLOW"))
  // gpioB_5_iobuf
  // (
  //   .O  (dut_io_pads_gpioB_i_ival[5]),
  //   .IO (gpioB_5),
  //   .I  (dut_io_pads_gpioB_o_oval[5]),
  //   .T  (~dut_io_pads_gpioB_o_oe[5])
  // );
  // IOBUF #(.DRIVE (12), .IBUF_LOW_PWR("TRUE"),.IOSTANDARD ("DEFAULT"),.SLEW ("SLOW"))
  // gpioB_6_iobuf
  // (
  //   .O  (dut_io_pads_gpioB_i_ival[6]),
  //   .IO (gpioB_6),
  //   .I  (dut_io_pads_gpioB_o_oval[6]),
  //   .T  (~dut_io_pads_gpioB_o_oe[6])
  // );
  // IOBUF #(.DRIVE (12), .IBUF_LOW_PWR("TRUE"),.IOSTANDARD ("DEFAULT"),.SLEW ("SLOW"))
  // gpioB_7_iobuf
  // (
  //   .O  (dut_io_pads_gpioB_i_ival[7]),
  //   .IO (gpioB_7),
  //   .I  (dut_io_pads_gpioB_o_oval[7]),
  //   .T  (~dut_io_pads_gpioB_o_oe[7])
  // );



endmodule


