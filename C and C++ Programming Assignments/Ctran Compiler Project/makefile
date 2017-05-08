compiler	:gram.o lex.o symtab.o list.o main.o  
		cc gram.o lex.o symtab.o list.o main.o -o compiler -ll

gram.o		: defs.h gram.c lex.o symtab.o list.o main.o
		cc -c -g gram.c

gram.c		: gram.y
		yacc -d gram.y
		mv y.tab.c gram.c

gram.y		: gram.tok gram.prod
		cat gram.tok gram.prod > gram.y

lex.o		: defs.h gram.tok lex.c
		cc -c -g lex.c

lex.c		: lex.l
		lex lex.l
		mv lex.yy.c lex.c

symtab.o	: defs.h 
		cc -c -g symtab.c

list.o		: defs.h 
		cc -c -g list.c

main.o		: main.c defs.h 
		cc -c -g main.c

clean		:
		rm compiler *.o gram.y gram.c lex.c y.tab.h y.output
