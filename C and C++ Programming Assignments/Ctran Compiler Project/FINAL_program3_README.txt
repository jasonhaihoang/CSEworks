Jason Hoang
CSCE 4650 - Sweany
4/15/2016
UPDATED: 5/10/2016

Program 3 - Ctran Compiler

README:

In order to run this program successfully, simple copy all of the files included into the CSE machine:
gram.prod
lex.l
gram.tok
defs.h
symtab.c
list.c
main.c
makefile

Along with all of the Ctran programs to be tested.
Within the directory use the command "make" to compile all of the files into the compiler.
Several assignment warings will appear, but they should not affect the outcome of the programs execution.
From here, simply use "./compiler" and then pipe one of the Ctran programs into the execution, such as "< one.ct"
This should output all of the Ctran compiler code tranlated into C machine assembly code to the screen.
Repeat this process for all other Ctran programs being tested.

EXTRA NOTES:
	The exponential math logic is now implemented and working from program 2's requirements.

FINAL PROGRAM SUBMISSION NOTES 5/10/2016:
	This is my final Compiler submission for the semester and it is basically a resubmission of program 3 with a few requirement additions.
	Compatability with Chars, unsigned, and Bitwise functionalities were implemented in this build.
	Bit Shift functions were also added using loops to multiply the variable being multiplied or divided, depending on the direction, by 2.
	The readInt() and printHex() functions were also implemented in their most basic form, as can be seen in the examples.
	Finally, fixed a bug where multiple variables in different scopes were called from the same scope level instead of their actual scope levels. This is now fixed to load the correct variable via offset into the correct register.
