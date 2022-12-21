# psudo_8bit_microprocessor
This repo have a verilog code of a Psudo-8bit-microprocessor which have some basic commands which are given in attached Pdf "instrction_set.pdf".
This microprocessor have many parts which are explained as follows.
## 1. Instruction_memory
Code for instruction memory is given in the file named "instruction_memory.v". In instruction memory instructions are write through testbench which we want to perfrom through microprocessor. The format of instrcution is 16 bit in which first 8 bit represents memory address at which instruction should be written and another 8 bit for instruction set in which first 4 bit are opcode or machine code and last 4 bit are according to task to be performed.
