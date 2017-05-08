#include "defs.h"


/*  global variable(s), used in the compiler  */
int const_value;
int const_value2;

main()
{
	//begins writing the program with the C initialization variables and such
	printf("\nint r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19;\n");
	printf("int r20, r21, r22, r23, r24, r25, r26, r27, r28, r29;\n");
	printf("int r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49;\n");
	printf("int r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69;\n");
	printf("int r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88, r89;\n");
	printf("int r90, r91, r92, r93, r94, r95, r96, r97, r98, r99;\n");
	printf("int r100, r101, r102, r103, r104, r105, r106, r107, r108, r109, r110, r111, r112, r113, r114, r115, r116, r117;\n");
	printf("int *iptr1;\n");
	printf("char *cptr1;\n");
	printf("char *fp, *sp;\n");
	printf("char globalData[1024];\n");
	printf("char moreGlobalData[1024];\n\n");
	//end initializations block

        int yyparse();

	/*  first we set up any initialization necessary for the compiler  */

	initialize_symbol_table();

	/*  We MIGHT have some code here to spit out any "formatting" that
            the output (assembler ?) requires  before the "real" code
            things like .csect commands, .text,  etc. */

	/*  yyparse is the name of the parser.  It parses the program, and
            allows us to spit out code during the parse.  */

	return(yyparse());

	/*  Having compiled the program an spit out the code, we might need
	    to add some postscript to the assembler output --- space statements,
	    etc.  */
}
