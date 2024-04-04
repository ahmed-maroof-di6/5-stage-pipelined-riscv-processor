# 5 Stage Pipelined RISCV processor with forwarding unit


![PP RISC-V](https://github.com/ahmed-maroof-di6/5-stage-pipelined-riscv-processor/blob/main/pipelined-riscv-datapath.png)

This repository contains the Verilog source code and documentation for a 32 bit pipelined RISC-V processor designed to support I, S, R, & SB type instructions. The processor is implemented in Verilog and is intended for educational and research purposes.

## Simulation GTKwave
![Wave PPRV32](https://github.com/ahmed-maroof-di6/5-stage-pipelined-riscv-processor/blob/main/pipelined%20riscv.png))

## Features

- Support for I, S, R, & SB type instructions as per the RISC-V ISA.
- 5 stages architecture for simplicity and ease of understanding.
- Fetch > Decode > Execute > Mem > Writeback
- Clear and well-documented Verilog code for each module.
- Testbench and sample programs to demonstrate the functionality.

## Prerequisites

Before you begin, ensure you have met the following requirements:

- A Verilog simulator (e.g., ModelSim, iverilog, or any other compatible tool).
- [Optional] FPGA synthesis tools if you want to implement the processor on hardware.

## Getting Started

All blocks are made as design files with test benche written in Verilog with the same name as the design file.
- Run and simulate Pipeline_RSCV_tb.v
- To run your desired instructions, store them to instuction memory then simulate to check outcome

Follow these steps to get the processor up and running:

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/ahmed-maroof-di6/5-stage-pipelined-riscv-processor/


