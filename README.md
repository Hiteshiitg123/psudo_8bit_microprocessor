# psudo_8bit_microprocessor
This repo have a verilog code of a Psudo-8bit-microprocessor which have some basic commands which are given in attached Pdf "instrction_set.pdf".
This microprocessor have many parts which are explained as follows.
## 1. Instruction_memory
Code for instruction memory is given in the file named "instruction_memory.v". In instruction memory instructions are write through testbench which we want to perfrom through microprocessor. The format of instruction is 16 bit in which first 8 bit represents memory address at which instruction should be written and another 8 bit for instruction set in which first 4 bit are opcode or machine code and last 4 bit are according to task to be performed.
## 2. Programme_counter
Verilog code for programme_counter is given in the file "programme_counter.v". The main function of programme counter is to increase a 8bit number which is address to getting output from instruciton_memory by one on the triggering of clock. So that next instruction can be taken to the control unit to perfrom that.
## 3. Instruction_decoder
instrcution decoder decodes the instruction which is output of the instrcuiton memory and sends the decoded instrucntion to the control unit to perform it.
## 4. ALU
ALU is the Arthematic and Logical Unit of microprocessor in which basic arthematic and logical tasks like "AND, OR, XOR, ADD, SUB are performed on the demand of control unit on the data sent by control unit.
## 5. Register_block
Resistor_block is one of the most important part of any processor. It is the place where the inputs and ooutputs of a process stored before storing them into the main memory. In this processor there are four Resistro implemented. In any process you can use any of resistor to store the value (load and store are expection).
## 6. Data Memory
Data memory is the main memory block of the processor where the data of any process will be stored. In out case because there are only 4 bit address available so that only 16 different data can be stored. Processor can access the data from the memory by the load and store operation as defined in the pdf file.
## control Unit

