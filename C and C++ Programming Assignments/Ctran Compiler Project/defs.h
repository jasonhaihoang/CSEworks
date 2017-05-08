/*  ********************************************************
    
    Global Defines File for the Compiler.  The different sections
    which should be separate .h files are marked.

    *******************************************************  */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>




/*  ********************************************************

	Function declarations

    ******************************************************* */
extern char *build_expression_string();


/*  ********************************************************

	Global Variables Externs

    ******************************************************* */
extern int const_value;
extern int const_value2;
int c;		//a simple int varable used to pass the register values through the grammar chain
int t;		//temporary int variable for temporary register values
int globalOffset;	//used to keep track of the offset values within the symbol table for all variables
int gOffsetTemp;	//temporary offset register variable	
int gTempInc;	//temporary increment register used for Do Loops
int gDoLoopID;	//global variable used to track the current Do Loop being parsed
int gIfLoopID;	//global variable used to track the current if Loop being parsed
char *doString;	//string variable used to store and print out do loop logic
int gEXPLoopID;	//global variable used to track the current Exponential Loop being parsed
int gOffsetCall;//global variable used to track the offset for the variable being called
int gShiftLoopID;	//global variable used to track the current SHIFT Loop being parsed

/*  ********************************************************

	General Constants

    ******************************************************* */

#define FALSE	0
#define TRUE	1


/*  ********************************************************

	Symbol Table Element  

    ******************************************************* */

/*  symbol_table_element data and functions to create a symbol_table_element,
    print a symbol_table_element and compare 2 symbol_table_element need to be
    rewritten for each type of list.  I've included example
    definitions for a list of integers.   */

struct symbol_table_element
{
	char *s;	//variable name
	char *type;	//variable type
	int ID;		//register ID number
	int Offset;	//register offset
	int min;	//list of dimensions
	int max;
	int size;
};

typedef struct symbol_table_element *SymbolTableElement;

extern SymbolTableElement create_symbol_table_entry();
extern void print_symbol_table_entry();
extern int compare_symbol_table_entries();
extern void clear_symbol_table_entry();





/*  ********************************************************

	List Routines

    ******************************************************* */

struct dlink
{
    SymbolTableElement stuff;
    struct dlink *next;
    struct dlink *previous;
};

struct dlist
{
    struct dlink *head;
    struct dlink *tail;
};


typedef struct dlist *List;
typedef struct dlink *Node;


extern Node create_node();
extern List create_list();
extern void insert_list();
extern void append_list();
extern void clear_list();
extern void print_list();
extern Node search_list();




/*  ********************************************************

	Hash Table Routines

    ******************************************************* */

#define TABLESIZE	79		/* Size of the hash table  */

extern void initialize_symbol_table();
extern Node search();
extern void insert();
extern int h1();
extern void print_hashtable();

extern List SymbolTable[TABLESIZE];
