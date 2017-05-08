#include "defs.h"


/* *****************************************************************
    create_node --- builds a node with whatever nodestuff is passed
                    as a parameters. 
   ***************************************************************** */
Node create_node(nd)
	SymbolTableElement nd;
{
	Node node_ptr;

	node_ptr = (Node) malloc(sizeof(struct dlink));
	node_ptr->stuff = nd;
	node_ptr->next = node_ptr->previous = NULL;

	return node_ptr;
}




/* *****************************************************************
    create_list --- creates and returns an empty list
   ***************************************************************** */
List create_list()
{
	List list;

	list = (List) malloc(sizeof(struct dlist));
	list->head = list->head = NULL;

	return list;
}




/* *****************************************************************
    insert_list --- inserts a node at the front of a list.
   ***************************************************************** */
void insert_list(list,node_to_insert)
	List list;
	Node node_to_insert;
{
	if( list->head )
	{
		list->head->previous = node_to_insert;
		node_to_insert->next = list->head;
		list->head = node_to_insert;
	}
	else
	{
		list->head = list->tail = node_to_insert;
	}
}




/* *****************************************************************
     append_list --- adds a node to the end of a list
   ***************************************************************** */
void append_list(list,node_to_append)
	List list;
	Node node_to_append;
{
	if( list->head )
	{
		list->tail->next = node_to_append;
		node_to_append->previous = list->tail;
		list->tail = node_to_append;
	}
	else
	{
		list->head = list->tail = node_to_append;
	}
}


void clear_list(list,clear_stuff)
	List list;
	int (*clear_stuff)();
{
	Node this_node,temp;

	this_node = list->head;
	while( this_node )
	{
		temp = this_node->next;
		clear_stuff(this_node->stuff);
		free(this_node);
		this_node = temp;
	}
}




/* *****************************************************************
     print_list --- prints all elements of the list by calling
                    the routine print_node, assumed to be defined
                    elsewhere.
   ***************************************************************** */
void print_list(list, print_node)
	List list;
        int (*print_node)();
{
	Node this_node;

	this_node = list->head;
	if( ! this_node )
	{
		printf("The List is empty!!!\n");
	}
	else
	{
		printf("The List contains:\n");
	}
	while( this_node )
	{
		printf("\t");
		print_node(this_node->stuff);
		printf("\n");
		this_node = this_node->next;
	}
}




/* *****************************************************************
     search_list --- search the list for an element which is == to
                     the SymbolTableElement item (nd) passed as a parameter.
                     The routine returns a pointer to the first such
                     node found in the list, or NULL, if no such node
                     is found.  Search_list uses compare_data to compare 
		     two SymbolTableElement items.  It is assumed that compare
                     data is defined elsewhere.
   ***************************************************************** */
Node search_list( list, nd, compare )
	List list;
	SymbolTableElement nd;
	int (*compare)();
{
	Node this_node = list->head;

	while( this_node )
	{
		if( ! compare(nd,this_node->stuff) )
		{
			return this_node;
		}
		else
		{
			this_node = this_node->next;
		}
	}
	return this_node;	/*  which should be null  */
}
