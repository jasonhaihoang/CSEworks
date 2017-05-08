/*  ********************************************************

	Hash Table Routines

    ******************************************************* */

#include "defs.h"


List SymbolTable[TABLESIZE];



void initialize_symbol_table()
{
	int k;

	for( k = 0; k < TABLESIZE; k++ )
        {
                SymbolTable[k] = create_list();
        }
}


SymbolTableElement search_table(s)
	char *s;
{
	int index;
	Node node_sought;	
	SymbolTableElement dummy;

	index = h1(s);
	dummy = create_symbol_table_entry(s,0);

	node_sought =  search_list(
		SymbolTable[index],
		dummy,
		compare_symbol_table_entries);

	clear_symbol_table_entry(dummy);
	free(dummy);
	return (SymbolTableElement) node_sought;
}


void insert_in_table(this)
	SymbolTableElement this;
{
	int index;

	Node this_node;

	this_node = create_node(this);
	index = h1(this->s);
	insert_list(SymbolTable[index],this_node);
}


int h1(s)
   char *s;
{
	int hashval;

	for( hashval = 0; *s; hashval += *s++ )
		;  /*  empty for loop  */
	
	return ( hashval % TABLESIZE );
}


void print_hashtable()
{
	int k;

	printf("The Hash Table includes:\n");

	for( k = 0; k < TABLESIZE; k++ )
	{
		printf("        Table[%d] = \n",k);
		print_list(SymbolTable[k],print_symbol_table_entry);
		printf("\n\n\n");
	}

}


SymbolTableElement create_symbol_table_entry(s, offset)
	char* s;
	int offset;
{
	SymbolTableElement this_element;
	
	this_element = (SymbolTableElement)
		malloc(sizeof(struct symbol_table_element));
	
	this_element->s = (char *) malloc(strlen(s) + 1);
	strcpy(this_element->s,s);
	this_element->ID = offset;
	return this_element;
}


void print_symbol_table_entry(ste)
	SymbolTableElement ste;
{
	printf("%s\n",ste->s);
}


int compare_symbol_table_entries(nd1,nd2)
	SymbolTableElement nd1, nd2;
{
	return strcmp(nd1->s,nd2->s);
}


void clear_symbol_table_entry(nd)
	SymbolTableElement nd;
{
	free(nd->s);
}


void clear_hashtable()
{
	int k;

	for( k = 0; k < TABLESIZE; k++ )
        {
                clear_list(SymbolTable[k],clear_symbol_table_entry);
        }
}
