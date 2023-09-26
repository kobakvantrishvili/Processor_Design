I increased the PC every 6 clock cycles, I could have increased PC every 4 clock cycles but I used 6 so that results are easly readable in simulation.
In these 6 clock cycles Processor has enough time to provide appropriate inputs and get correct outputs from each module.
In the images folder, I have a file called "Simplified Processor Output" where it is shown how Rd and flags change with Program Counter.

Commands am running are:

0   MOV R1, #22
1   MOV R2, #5
2   MOV R3, #3
3   ADD R0, R1, R2, LSL R3
4   ADDS R0, R1, R2, LSR #1
5   STR R0, [R1, R2]
6   SUBNES R0, R2, #2
7   BHI label   // here am adding 4 to PC to jump to Instruction Memory location "11", if condition "HI" is staisfied\n
8   MOV R2, #5
9   MOV R2, #5
10  MOV R2, #5
11  MOV R1, #22 // this is where PC jumps to
12  MOV R2, #5  // last instruction

All of the results in the simulation are correct, but make sure to check values for each instruction right before PC gets incremented.

I can't write individual explanations for each module as it would take too much time, so if you are unsure of something please message or email me.


