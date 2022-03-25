// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
//
// This program only needs to handle arguments that satisfy
// R0 >= 0, R1 >= 0, and R0*R1 < 32768.

// Put your code here.

// Initialize a variable symbol @sum to keep a running sum
// that initially starts at 0
    @sum
    M=0

// Initialize a variable symbol @i to keep a count of the iterations
// that initially starts at 1
    @i
    M=1

// Another way of thinking about multiplication is a loop of addition operations
// Perform the addition operation X number of times based on R1/RAM[1]
(LOOP)
    // Loop condition
    // if (n > R1) goto (STOP)
    // Load the value of @i into the Data register
    @i
    D=M
    // Load the value of @R1 into the Address register
    @R1
    // Update the Data register to be @i - @R1
    D=D-M
    // If @n - @R1 > 0, that means @n > @R1,
    // and the loop ran @n - 1 times
    // If this condition is met, jump to (STOP)
    @STOP
    D;JGT

    // Update the running sum
    // Load the current sum into the Data register
    @sum
    D=M
    // Load the value of @R0 into the Address register
    @R0
    // Store the updated running sum into the Data register
    D=D+M
    // Update the variable symbol @sum
    @sum
    M=D

    // Update the number of iterations
    @i
    M=M+1

    // Return to the start of the loop
    @LOOP
    0;JMP

// Once we reached the number of iterations/loops,
// store the value into R2/RAM[2]
(STOP)
    // Update R2/RAM[2] to be equal to @sum
    @sum
    D=M
    @R2
    M=D

// End
(END)
    @END
    0;JMP