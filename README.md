# 8086 AES Implementation

This project implements the 128-bit Advanced Encryption Standard (AES) algorithm on an 8086 microprocessor. The implementation includes reading 128-bit input data from the user, performing AES encryption, and printing the result to the screen.

## Project Structure

- **Procedures**: Handles user input and output using interrupts.
- **Macros**: Implements the core AES functions:
  - `SubBytes()`
  - `ShiftRows()`
  - `MixColumns()`
  - `AddRoundKey()`
- **Main Program**: Orchestrates the AES encryption process over 10 rounds.
- **Key Schedule**

## Getting Started

### Prerequisites

- An 8086 emulator such as [EMU8086](http://www.emu8086.com) or any other preferred 8086 emulator.
- Basic understanding of assembly language and the 8086 architecture.
- Familiarity with the AES algorithm. Refer to the [AES standard document](http://csrc.nist.gov/publications/fips/fips197/fips-197.pdf) for detailed information.

### Installation

1. Download and install the EMU8086 emulator from [http://www.emu8086.com](http://www.emu8086.com).
2. Clone this repository or download the project files.

### Running the Program

1. Open the EMU8086 emulator.
2. Load the assembly file into the emulator.
3. Assemble and run the program.
4. Follow the on-screen prompts to enter the 128-bit input data and key.
5. The program will output the encrypted data after completing the AES encryption process.

## Implementation Details

### SubBytes


The `SubBytes` operation replaces each byte in the input block with a corresponding byte from the S-box. The S-box is a predefined 16x16 matrix that provides a non-linear substitution.

### ShiftRows

### MixColumns

### AddRoundKey

### KeySchedule

## Testing

Use the provided test case from the AES standard to verify your implementation. Ensure the program encrypts the input correctly and produces the expected output.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## Acknowledgments

- AES standard document: [http://csrc.nist.gov/publications/fips/fips197/fips-197.pdf](http://csrc.nist.gov/publications/fips/fips197/fips-197.pdf)
- AES animation: [Rijndael Animation](https://formaestudio.com/rijndaelinspector/archivos/Rijndael_Animation_v4_enghtml5.html)
- MixColumns description: [Mix Columns](http://www.angelfire.com/biz7/atleast/mix_columns.pdf)

## Contributors

- Mohammed El Said Azab Abdelazim
- Fam Awad Louiz Awad Shihata
- Adam Mahmood mahmood elsayed

