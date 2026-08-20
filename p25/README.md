# FIFO Memory using Verilog

## Project Overview

This project implements a synchronous FIFO (First-In First-Out) memory using Verilog HDL.

FIFO memory stores data in such a way that the first data written into the memory is the first data read from it.

## Features

- 8-bit data width
- 8 data locations
- Synchronous read and write operations
- Reset functionality
- Full flag
- Empty flag
- Verilog testbench
- Simulation waveform support

## FIFO Operation

The FIFO has two main operations:

### Write

When `wr_en = 1` and the FIFO is not full, data is written into the FIFO.

### Read

When `rd_en = 1` and the FIFO is not empty, data is read from the FIFO.

## Signals

| Signal | Description |
|---|---|
| `clk` | Clock signal |
| `reset` | Reset signal |
| `wr_en` | Write enable |
| `rd_en` | Read enable |
| `data_in` | Input data |
| `data_out` | Output data |
| `full` | Indicates FIFO is full |
| `empty` | Indicates FIFO is empty |

## Files

```text
FIFO-Memory-Verilog/
│
├── README.md
├── fifo.v
├── fifo_tb.v
└── simulation_output.txt