// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

// Load the address of @KBD to the Address register
@KBD
// Store the last screen address to the Data register
// (one before the @KBD variable)
D=A-1
// Create a new variable @n to store the last screen address
@n
M=D

(RESTART)
    // Create a new variable @i to store current screen address
    // and set it to the first screen address initially
    @SCREEN
    D=A
    @i
    M=D

    // Load RAM address for keyboard into Address register
    @KBD
    // Store keyboard character code into Data register
    D=M
    // Create a new variable @pressedkey to store the
    // character code of the key that was pressed
    @pressedkey
    M=D

    // Jump to (BLACK) if the character code is not equal to zero
    @BLACK
    D;JNE

    // Jump to (WHITE) if the character code is equal to zero
    @WHITE
    D;JEQ

(BLACK)
    @color
    M=-1
    @UPDATESCREEN
    0;JMP

(WHITE)
    @color
    M=0
    @UPDATESCREEN
    0;JMP

(UPDATESCREEN)
    // Load the value of @i into the Data register
    @i
    D=M
    // Load the value of @n into the Address register
    @n
    // Update the Data register to be @i - @n
    D=D-M
    // The screen is fully updated once @i > @n
    // So jump back to (RESTART) to start over
    @RESTART
    D;JGT

    // Load the color into the Data register
    @color
    D=M

    // Load the current screen address to the Address register
    @i
    A=M
    // Set the value at the current screen address
    // to the color stored in the Data register
    M=D

    // Increment @i
    @i
    M=M+1

    // Check if @pressedkey has changed
    @KBD
    D=M
    @pressedkey
    D=D-M
    // If changed, jump to (RESTART)
    @RESTART
    D;JNE

    // Repeat the loop
    @UPDATESCREEN
    0;JMP