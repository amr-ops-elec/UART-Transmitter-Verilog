# UART-Transmitter-Verilog
Parametrized UART Transmitter RTL
# UART Transmitter (UART_TX) - RTL Design & Verification

## Overview
This repository contains a parametrized, synthesizable **UART Transmitter (UART_TX)** module designed in **Verilog HDL**. The design handles 8-bit parallel-to-serial conversion, supports configurable parity (Even/Odd), and incorporates standard Start/Stop frame formatting with robust FSM control.

---

## System Architecture
The top-level transmitter integrates four modular stages:
1. **Serializer:** Converts 8-bit parallel input into a serial bitstream.
2. **Parity Generator:** Calculates Even/Odd parity bit for error detection.
3. **Multiplexer (MUX):** Routes Start bit, Serial data, Parity bit, and Stop bit sequentially.
4. **FSM Controller:** Orchestrates transmission timing, shift enable, MUX selection, and handshaking flags (`busy` / `tx_out`).

---

## Ports & Interface
| Port Name | Direction | Width | Description |
|---|---|---|---|
| `clk` | Input | 1-bit | System Clock |
| `rst_n` | Input | 1-bit | Active-Low Asynchronous Reset |
| `data_in` | Input | 8-bit | Parallel Data Payload |
| `data_valid` | Input | 1-bit | Handshake signal to trigger transmission |
| `parity_enable` | Input | 1-bit | Enable/Disable parity calculation |
| `parity_type` | Input | 1-bit | `0`: Even Parity, `1`: Odd Parity |
| `tx_out` | Output | 1-bit | Serial Data Line (Idle HIGH) |
| `busy` | Output | 1-bit | High during frame transmission |

---

## Verification & Scenarios
Verified using ModelSim / QuestaSim across 3 main testbench scenarios:
* **Scenario 1:** Normal Transmission with **Even Parity**.
* **Scenario 2:** Transmission with **Odd Parity** checking.
* **Scenario 3:** Back-to-Back transmissions & Handshake (`busy` flag) response.
* ### Unit Verification (Sub-Modules)
- `serializer_tb.v`: Validates parallel load and sequential bit shifting logic.
- `fsm_tb.v`: Tests state transitions, timing accuracy, and control signals.

---

## Documentation
- Presentation slides included: `project_NTI_UART_TX.pdf`
- Designed by: **Amr Mohamed Zhran** - *Faculty of Engineering, Kafr El-Sheikh University (NTI FPGA Program)*.
