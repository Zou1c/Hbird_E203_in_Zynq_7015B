# Hbird_E203_in_Zynq_7015B
## 这个项目能干啥？
算是本人跟着视频教学，整了一个对移植工作做移植的小实验——通过一台Windows主机、一个ZYNQ7000的AX7015B开发板（FPGA）、一个蜂鸟官方的调试器、一个USB转TTL器件，实现在FPGA上跑一个蜂鸟E203的CPU，并让这个CPU直接运行一个helloworld模板程序，将结果通过UART输出到主机的串口终端上。

## 实验环境
### 硬件需要
- 一台配有Vivado 2024.01的windows系统（这里理论上只需要有不会版本冲突的vivado就行）
- AX7015B开发板，这个板子有核心版和开发板两部分——我们将E203 CPU烧录到核心板上的PL区域，通过开发板上的40 pin针脚扩展口来连接这个模拟出来的CPU的gpio
- ZYNQ自带的Jtag调试器和线（红红的线和一个adapter），用于将生成的bitstream文件写入PL（其实只是在“program device”这一步上用到了这个调试器，主要是我拿到这个板子的时候就已经连接好了）
- 蜂鸟调试器以及5跟杜邦线——其中有一根是接地的（GND）
- USB转TTL器以及3根杜邦线——其中有一根是接地的（GND）

### 软件环境
- 一个官方的驱动安装程序——HBird_Driver.exe
- 带有openOCD的一个IDE环境——NuceleiStudio 2022.04（这里需要注意版本太新的，例如我当时试过的2024版本的还不支持蜂鸟的sdk）
- sdk_Hbird_sdk 0.1.4（这里的环境实际上是通过NuceleiStudi下载配置的）

## 项目结构
