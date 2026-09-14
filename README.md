# 8-bit ALU (Verilog)

A synthesizable 8-bit Arithmetic Logic Unit (ALU) designed in Verilog HDL, built and simulated in Xilinx Vivado (2023.2), targeting the Artix-7 (xc7a35tcpg236-1) FPGA.

## Overview

This project implements an 8-bit ALU that performs eight different arithmetic, logical, and shift operations on two 8-bit operands, selected via a 3-bit control signal. The design includes a registered output stage, making it suitable for integration into synchronous digital systems such as processors, datapaths, or custom control logic.

## Features

- 8-bit wide operands (`A`, `B`)
- 8 selectable operations via a 3-bit `sel` control line
- Registered (clocked) output for synchronous designs
- Synchronous active-high reset
- Fully simulated and verified with a self-checking testbench

## Block Diagram

```
        A[7:0] ─────┐
                     │
        B[7:0] ─────┤   Combinational   result[7:0]   ┌──────────┐   Y[7:0]
                     │──►    ALU Logic    ──────────►  │ Register │ ──────►
        sel[2:0] ────┘      (case block)                │ (posedge │
                                                          │  clk)    │
        clk ─────────────────────────────────────────►  │          │
        rst ─────────────────────────────────────────►  └──────────┘
```

## Supported Operations

| sel (binary) | Operation              | Expression |
|:------------:|------------------------|:----------:|
| 000          | Addition                | A + B      |
| 001          | Subtraction              | A - B      |
| 010          | Bitwise AND              | A & B      |
| 011          | Bitwise OR               | A \| B     |
| 100          | Bitwise XOR              | A ^ B      |
| 101          | Bitwise NOT              | ~A         |
| 110          | Logical Shift Left      | A << 1     |
| 111          | Logical Shift Right     | A >> 1     |

## Repository Structure

```
ALU_8bit_Verilog/
├── src/
│   └── alu_8bit.v          # RTL design
├── sim/
│   └── tb_alu_8bit.v       # Testbench
├── docs/
│   └── waveform.png        # Simulation waveform screenshot
├── README.md
├── .gitignore
└── LICENSE
```

## Module Interface

| Signal | Direction | Width | Description                    |
|--------|-----------|:-----:|---------------------------------|
| clk    | input     | 1     | Clock signal                    |
| rst    | input     | 1     | Synchronous active-high reset   |
| A      | input     | 8     | First operand                   |
| B      | input     | 8     | Second operand                  |
| sel    | input     | 3     | Operation select                |
| Y      | output    | 8     | Registered ALU result           |

## How to Simulate

### Using Vivado
1. Create a new RTL project in Vivado.
2. Add `src/alu_8bit.v` as a design source.
3. Add `sim/tb_alu_8bit.v` as a simulation source.
4. Run **Behavioral Simulation** and observe the waveform in the simulation window.

### Using Icarus Verilog (free, open-source alternative)
```bash
iverilog -o alu_sim src/alu_8bit.v sim/tb_alu_8bit.v
vvp alu_sim
```

### Using EDA Playground
Paste `alu_8bit.v` and `tb_alu_8bit.v` into separate files, select **Icarus Verilog** as the simulator, and run.

## Sample Simulation Output

```
time    sel   A     B    Y
0       000   0     0    0
15      000   15    10   25
25      001   20    8    12
35      010   240   15   0
45      011   240   15   255
55      100   170   85   255
65      101   170   0    85
75      110   1     0    2
85      111   128   0    64
```

## Target Device

- **Part:** xc7a35tcpg236-1 (Artix-7, Basys 3 / Arty A7-compatible)
- **Tool:** Xilinx Vivado 2023.2

## Possible Extensions

- Add a carry-out / overflow flag for arithmetic operations
- Add a zero flag for branch/comparison logic
- Pipeline the design for higher clock frequencies
- Wrap into a larger datapath with an instruction decoder

## Author

**Devam Patel**
M.Tech — VLSI & Embedded Systems

## License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.