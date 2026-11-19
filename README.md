# FPGA Reaction Timer (Nexys 4 DDR)

A hardware-based reflex and reaction time measurement game implemented in Verilog HDL for the **Digilent Nexys 4 DDR (Artix-7)** FPGA board. The design features a Moore-based Finite State Machine (FSM), a 13-bit Linear Feedback Shift Register (LFSR) for unpredictable delay generation, hardware button debouncing, and a multiplexed 7-segment display driver.

## Features

- **13-Bit LFSR Random Delay:** Generates pseudo-random wait times (~0 to 8.2 seconds) using XOR feedback taps (bits 12, 3, 2, 0). The LFSR runs continuously at 100 MHz during the `IDLE` state and freezes on the `Start` button press, leveraging **human entropy** for unpredictable timing.
- **False-Start Detection (`LOSE` State):** Pressing the `Stop` button before the LED lights up immediately triggers the `LOSE` state and displays **`LOSE`** on the 7-segment display.
- **Millisecond Precision:** Measures human reaction time in milliseconds using a 1 kHz (`1 ms`) clock tick derived from the 100 MHz system clock.
- **Hardware Debouncing:** Filters mechanical switch bounce on both `Start` and `Stop` pushbuttons.

## System Architecture

The project is organized into modular Verilog files under `src/`:

| Module | Description |
| :--- | :--- |
| `reaction_timer_wiring.v` | Top-level module interconnecting all sub-modules and physical I/O pins. |
| `Clock_Divider.v` | Divides the 100 MHz onboard clock down to a 1 ms (`1 kHz`) tick signal. |
| `Button_Debouncer.v` | Eliminates mechanical contact bounce for reliable button presses. |
| `Finite_State_Machine.v` | Core Moore FSM (`IDLE`, `WAITING`, `COUNTING`, `END`, `LOSE`) with integrated 13-bit LFSR. |
| `Binary_to_BCD.v` | Converts the 16-bit binary millisecond counter into 4-digit BCD values. |
| `Seven_Segment_Driver.v` | Time-multiplexed 7-segment display controller supporting both numeric scores and the `LOSE` text. |

## Hardware & Pin Mapping (Nexys 4 DDR)

| Signal | FPGA Pin | Board Component | Function |
| :--- | :--- | :--- | :--- |
| `clk` | `E3` | 100 MHz Oscillator | Main system clock |
| `physical_button_start` | `N17` | `BTNC` (Center Button) | Start game / Reset to `IDLE` |
| `physical_button_stop` | `M17` | `BTNR` (Right Button) | Stop timer when LED lights up |
| `suprise_led` | `H17` | `LD0` | Visual cue to press `Stop` |
| `anot[7:0]` / `katot[6:0]` | `J17–U13` / `T10–L18` | 7-Segment Display | Displays reaction time (ms) or `LOSE` |

## How to Play

1. Press **BTNC (Start)** to begin a round. The display clears and the system enters the `WAITING` state.
2. Wait for **LD0** to light up. *(Pressing **BTNR** early results in a **`LOSE`**).*
3. As soon as **LD0** turns on, press **BTNR (Stop)** as fast as possible.
4. Read your reaction time in milliseconds on the rightmost 4 digits of the 7-segment display.
5. Press **BTNC (Start)** to play again.

## Build & Run (Xilinx Vivado)

1. Create a new RTL project in Vivado targeting the **Nexys 4 DDR (`xc7a100tcsg324-1`)**.
2. Add all `.v` files from `src/` as Design Sources and set `reaction_timer_wiring.v` as the top module.
3. Add the `.xdc` file from `constraints/` as Constraints.
4. Run **Generate Bitstream** and program the board via **Hardware Manager**.
