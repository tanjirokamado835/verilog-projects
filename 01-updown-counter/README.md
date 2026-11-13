# Design and Verification of a 4-Bit Up/Down Counter with Parallel Load and Synchronous Reset

## 📌 Project Overview
This project implements a **parameterized 4-bit synchronous Up/Down Counter** using Verilog HDL. The counter supports upward counting, downward counting, parallel data loading, count enable, and synchronous reset.

The design follows a fixed control priority: **Reset > Load > Count > Hold**. A self-checking testbench was developed to verify the functionality using directed test cases and 300 randomized clock cycles.

## ⚙️ Features
- **Up Counting:** Increments the counter by 1 on each rising clock edge.
- **Down Counting:** Decrements the counter by 1 on each rising clock edge.
- **Parallel Load:** Loads a user-defined 4-bit value into the counter.
- **Count Enable:** Enables or disables counting.
- **Synchronous Reset:** Resets the counter to zero on the rising clock edge.
- **Hold Operation:** Maintains the previous count when counting is disabled.
- **Wrap-Around:** Counts from 15 to 0 during upward counting and from 0 to 15 during downward counting.
- **Parameterized Design:** Supports different counter widths through the `WIDTH` parameter.

## 🛠️ Tools & Technologies
- Verilog HDL
- EDA Playground
- Icarus Verilog 12.0
- EPWave (Waveform Analysis)
- DigitalJS (Circuit Visualization)

## 🔍 Verification & Testing
A self-checking testbench was developed with an independent reference model to automatically compare the expected and actual counter outputs.

The following test cases were performed:

1. Up counting with wrap-around.
2. Down counting with wrap-around.
3. Parallel data loading.
4. Hold operation when enable is disabled.
5. Load priority over counting.
6. Reset priority over loading.
7. 300 randomized input cycles.

## 📊 Results
- Simulation completed successfully.
- All directed and randomized test cases passed.
- Zero mismatches were reported.
- Final simulation output: `PASS: all checks passed`.
- Synthesized circuit structure and individual operations were inspected interactively using DigitalJS.

## 📁 Repository Structure
```text
Up-Down-Counter/
│
├── updown_counter.v
├── tb_updown_counter.v
├── screenshots/
│   ├── simulation_result.png
│   ├── waveform.png
│   ├── digitaljs_circuit.png
│   └── test_cases/
│
└── README.md
```

## 📚 Concepts Learned
- Sequential Logic Design
- Clocked Processes and Flip-Flops
- Synchronous Reset
- Non-Blocking Assignments
- Parameterized Verilog Modules
- Control Priority Logic
- Testbench Development
- Self-Checking Verification
- Waveform Analysis

## 🚀 Future Enhancements
- Extend the counter width to 8 bits.
- Compare synchronous and asynchronous reset.
- Add a terminal-count detection flag.
- Integrate the counter into a timer or traffic light controller.

## 🎯 Project Objective
This project was developed as part of my journey in learning Digital Design and RTL Design using Verilog HDL, with a focus on understanding sequential circuits and functional verification.

**This is an independent learning project built using free, browser-based EDA tools.**
