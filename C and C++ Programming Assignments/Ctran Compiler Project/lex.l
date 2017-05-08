Digit		[0-9]
Letter		[a-zA-Z]
IntLit		{Digit}+

%{
#include "defs.h"
#include "y.tab.h"
%}

%%
[ \t\n]+				{ /* delete */ }

"main"					{ return (MAIN); }	//tokens
"begin"					{ return (BEGINT); }
"end"					{ return (END); }

"printi"				{ return (PRINTI); }
"printLine"				{ return (PRINTLINE); }
"prints"				{ return (PRINTS); }
"printChar"				{ return (PRINTC); }
"printInt"				{ return (PRINTI); }
"printString"				{ return (PRINTS); }
"printHex"				{ return (PRINTH); }
"readInt"				{ return (READI); }

"if"					{ return (IF); }
"do"					{ return (DO); }
"continue"				{ return (CONTINUE); }
"else"					{ return (ELSE); }

"and"					{ return (ANDT); }
"or"					{ return (ORT); }
"not"					{ return (NOT); }
"quit"					{ return (QUIT); }
"return"				{ return (RETURN); }

"int"					{ return (INT); }
"char"					{ return (CHAR); }
"boolean"				{ return (BOOL); }
"void"					{ return (VOID); }
"unsigned"				{ return (UNSIGNED); }
".gt."					{ return (gt); }
".ge."					{ return (ge); }
".le."					{ return (le); }
".lt."					{ return (lt); }
".eq."					{ return (eq); }
".neq."					{ return (neq); }

"true"					{ return (TBOOL); }
"false"					{ return (FBOOL); }
			
L?\"(\\.|[^\\"])*\"			{ yylval.stringstuff = yytext;
					  return (stringLiteral); }	//parses strings

{Letter}({Letter}|{Digit}|_)*		{ process_id();	//since output is the only function being used for this exercise, it is parsed here
					  return (name);		}

{IntLit}				{ yylval.intstuff = atoi(yytext);
				          return (intLiteral); }

"="					{ return (ASG);	}	//operators and operator tokens
";"					{ return (';');	}
":"					{ return (':'); }
"("					{ return ('('); }	
")"					{ return (')'); }
"**"					{ return (EXP); }
"%"					{ return ('%'); }
"/"					{ return ('/');	}
"*"					{ return ('*');	}
"-"					{ return ('-');	}
"+"					{ return ('+'); }

"["					{ return ('['); }
"]"					{ return (']'); }
","					{ return (','); }

"&"					{ return (AMP); }
"|"					{ return (BOR); }
"^"					{ return (XOR); }
"<<"					{ return (LSHIFT); }
">>"					{ return (RSHIFT); }
"++"					{ return (INCREMENT); }
"--"					{ return (DECREMENT); }
"~"					{ return (TILDA); }
%%
process_id()
{
	/*  I decided to stick with Seany's symbol table for better results. trying to implent mine from c++
	    was too difficult to iron out the bugs and figure out all of the memory allocation errors.*/

	Node list_node;
	SymbolTableElement symbol_table_node;
	if( ! (list_node = (Node) search_table(yytext) ) )
	{
	   //stores the symbol entry with the proper register offset values

		symbol_table_node = create_symbol_table_entry(
			yytext,assign_next_register());
		insert_in_table(symbol_table_node);
	}
	else
	{
	    //basically returns the same node that is already in the register

		symbol_table_node = list_node->stuff;
	}
	yylval.symbolstuff = symbol_table_node;
}

int assign_next_register()
{
	/* The compiler allocates each variable to a different machine
           register.  This routine just chooses the next register in
           the range r4 to r31.  Registers r0-r3 are reserved for other
           purposes  */

	static int register_number;
	register_number = (register_number + 1) % 28;
	return register_number + 4;
}
