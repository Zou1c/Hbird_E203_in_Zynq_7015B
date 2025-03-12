# Hbird_E203_in_Zynq_7015B
## 这个项目能干啥？
算是本人跟着视频教学，整了一个对移植工作做移植的小实验——通过一台Windows主机、一个ZYNQ7000的AX7015B开发板（FPGA）、一个蜂鸟官方的调试器、一个USB转TTL器件，实现在FPGA上跑一个蜂鸟E203的CPU，并让这个CPU直接运行一个helloworld模板程序，将结果通过UART输出到主机的串口终端上。

## 来源
```
https://www.bilibili.com/video/BV1ia411U76P/?spm_id_from=333.1391.0.0&vd_source=2e347744adefa61fe331f93e747e09b5
```

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
文件夹：
- 7015B_reference——包含了AX7015B的用户手册和两个板的原理图，主要用来看看引脚绑定到哪里，可以方便改xdc约束文件
- E203_P1——视频中的基于AX7010做的移植项目的打包，因为暂时没整好，所以先放个链接
- NuceiStudio(IDE)——也是链接
- Vivado_project——*本项目主要的代码修改*。与原视频中的相比，稍微对xdc文件和verilog顶层做了修改，顶层文件主要是删去了几个没有连接的gpio
- driver_install——用以下载蜂鸟驱动

文件：
exp_record.md——用来记录实验过程中的想法和记录，里面有许多遇到的问题（但是抽象了）。现在觉得如果遇到棘手的问题可以去这个文件里找找有没有类似的问题，但不适合作为一步步的实验指导步骤

## 其他要注意的地方
1. NuceleiStudio 2022.04可以新建helloworld模板项目，这里并没有放入项目中，就是注意下载程序的模式ILM，以及修改openocd的cfg文件，使其将程序直接下载到CPU的ROM中（我理解的是这样的）
2. 如果有不明白的地方，也可以参考《手把手教你RISC-V CPU 上 处理器设计》与《手把手教你RISC-V CPU 下 工程与实践》
3. 一般你的USB转TTL器也需要一个特定的驱动，主机才能检测到它
4. 如果缺少合适的硬件调试器的话（首先确保openocd能检测到设备），我真的不确定能不能成功下载程序。本人试过一个为BL 702 CPU设计的调试器（debugger），但是没成；后来也用sipeed的debugger试了一试，但是在下载程序时会出现类似以下的错误：
```
Info : Using libusb driver
Info : clock speed 1000 kHz
Error: JTAG scan chain interrogation failed: all ones
Error: Check JTAG interface, timings, target power, etc.
Error: Trying to use configured scan chain anyway...
Error: riscv.cpu: IR capture error; saw 0x1f not 0x01
Warn : Bypassing JTAG setup events due to errors
Error: Unsupported DTM version: 15
Warn : target riscv.cpu examination failed
Info : starting gdb server for riscv.cpu on 3333
Info : Listening on port 3333 for gdb connections
Error: Target not examined yet
Error: Unsupported DTM version: 15
```
然后本人之后换上了蜂鸟调试器就直接跑通了（我也不清楚到底是硬件还是驱动还是连接的问题，这在当时都检查了好多遍了）  
5. 后续直接跑FreeRTOS和CoreMark的模板(NuceleiStudio提供的)都是没有问题的  

...  

...

## 快速开始
（这里假设你的环境和本项目的一模一样的话）

### 第零步
先把线都连接好（只是想知道连哪里的话，看xdc文件和用户手册就够了）

### 第一步
将Vivado_project中的bitstream文件program device到你的FPGA上（直接烧到Flash中也不错，但这里的项目没有做更改）

### 第二步
新建一个helloworld的模板(new Nucelei RISC-V C/C++ Project)，build这个项目，修改cfg文件删去flash相关部分

### 第三步
在NuceleiStudio中打开一个新的Serial Terminal，选择UART部分连接对应的Serial port

### 第四步
点击run
