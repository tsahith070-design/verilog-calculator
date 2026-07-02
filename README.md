# verilog-calculator
# 8-bit ALU Based Calculator using Verilog HDL

## Overview
This project implements an **8-bit ALU based calculator** using **Verilog HDL**.

The design performs arithmetic and logical operations on two 8-bit operands. The result is updated only when the **equalto button** is pressed.

The design was developed and verified using **Xilinx Vivado**.

---

## Features

* 8-bit ALU implementation
* Result register triggered using equal button
* Asynchronous reset support
* Sign flag generation
* Division-by-zero detection
* Verilog testbench for functional verification

---

## Supported Operations

| Select (`sel`) | Operation           |
| -------------- | ------------------- |
| 000            | Addition            |
| 001            | Subtraction         |
| 010            | Multiplication      |
| 011            | Division            |
| 100            | Bitwise AND         |
| 101            | Bitwise OR          |
| 110            | Bitwise XOR         |
| 111            | Logical Right Shift |

## Inputs

| Signal | Width |
| ------ | ----- |
| A      | 8-bit |
| B      | 8-bit |
| sel    | 3-bit |
| eqlto  | 1-bit |
| reset  | 1-bit |

## Outputs

| Signal           | Width  |
| ---------------- | ------ |
| RESULT           | 16-bit |
| sign_flag        | 1-bit  |
| div_by_zero_flag | 1-bit  |

## Design Architecture

* Combinational ALU implemented using `case` statement.
* Sequential output register updates result only on positive edge of `eqlto`.
* Reset clears outputs and flags.

## Tools Used

* Verilog HDL
* Xilinx Vivado

## Simulation Waveform

![Waveform](docs/waveform.png)

## Future Improvements

* Parameterized ALU
* Overflow and carry flags
* Accumulator mode
* FPGA implementation


B.Tech ECE, NIT Calicut

