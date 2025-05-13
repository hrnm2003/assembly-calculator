# Assembly Calculator Project

## Description
This Assembly language project is a simple calculator program developed by Hamidreza Nadi Moghadam. It supports basic arithmetic operations, including addition, subtraction, multiplication, division, and calculation of the Euler number raised to a power using the Taylor series approximation.

---

## Features and Implementation Details

### Main Function
The main function clears the screen, displays the menu, and waits for user input. User inputs are read via keyboard, and based on the ASCII code of the pressed key, the program branches to the respective arithmetic operation:

- `1`: Addition
- `2`: Subtraction
- `3`: Multiplication
- `4`: Division
- `5`: Exponentiation (Euler's number)
- `0`: Exit the program

### Addition
- Clears the screen and prompts users to enter two 8-digit numbers sequentially.
- Stores numbers into registers and performs addition, managing overflow between high and low order registers.
- Displays the final sum using the `show` routine.

### Subtraction
- Similar to the addition function but utilizes `sub` and `sbb` Assembly instructions to handle low and high order subtractions respectively.
- The result is displayed and then returns to the main menu upon user input.

### Multiplication
- Accepts two numbers, each split into low and high parts in registers.
- Multiplies these numbers using a dedicated multiplication routine.
- The result is stored in four separate registers for high and low parts, and displayed using `show`.

### Division
- Accepts two 4-digit numbers and ensures the second number isn't zero to avoid division errors.
- Executes division, displaying quotient and remainder separately.
- Handles floating-point calculation if there is a non-zero remainder using the `floatdiv` routine.

### Euler Exponentiation ($e^x$)
This feature calculates $e^x$ using a Taylor series approximation up to four terms:

$e^x = 1 + x + \frac{x^2}{2!} + \frac{x^3}{3!} + \frac{x^4}{4!}$

Each term calculation is handled separately, considering fixed-point arithmetic to maintain four decimal places precision:

- **Stage 1:** Computes $1 + x$
- **Stage 2:** Computes $\frac{x^2}{2!}$ with fixed-point precision.
- **Stage 3:** Computes $\frac{x^3}{3!}$.
- **Stage 4:** Computes $\frac{x^4}{4!}$.

The intermediate results are managed carefully on the stack and registers to maintain accuracy. Finally, the results are summed up and displayed.

#### Example:
For input $x = 5$:
- Stage 1: 60000
- Stage 2: 125000
- Stage 3: 208250
- Stage 4: 260000
- Final result: 653250, representing $e^5$ approximation.

*Note: Due to precision limitations, the displayed result might differ slightly from the actual mathematical calculation.*

---

## Utility Functions
- **`Clear` Function:** Clears the display using interrupt `10h`.
- **`Get_operand` Function:** Reads numerical inputs, converts ASCII characters to integers and prepares them for arithmetic operations.
- **`Multiplication` Function:** Performs multiplication of two 16-bit numbers, managing overflow into multiple registers.
- **`Print` and `Show` Functions:** Handle the display of results on the screen.
- **`Floatdiv` Function:** Handles floating-point division and displays results up to four decimal places.

---

## Prerequisites

Before using the project, make sure the following software is installed:

- Emulator for running Assembly programs ([emu8086](https://en.wikipedia.org/wiki/Intel_8086))

---

## Getting Started

Clone the repository using the command below:

```
git clone https://github.com/hrnm2003/assembly-calculator.git
```

---

## Screenshots

Here is an example of how the calculator works in DOSBox:


![Main Menu of Calculator](https://github.com/hrnm2003/demos/main-menu.jpg)

---

## Limitations
- Arithmetic precision is limited to four decimal places in floating-point operations.
- Larger values or additional terms for Euler calculations might improve accuracy but are limited due to complexity and computational constraints.

---

## Useful Resources

For a deeper understanding, consider the following resources:

- [Taylor Series Explanation](https://en.wikipedia.org/wiki/Taylor_series)
- [Fixed-point Arithmetic](https://en.wikipedia.org/wiki/Fixed-point_arithmetic)
- [Assembly Language Basics](https://en.wikibooks.org/wiki/X86_Assembly)

---

## Author
- **Hamidreza Nadi Moghadam**

---

Feel free to open an issue or submit a pull request if you encounter any problems or wish to suggest improvements.

---