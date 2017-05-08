////////////////////////////////////////////////////////////////////
// Jason Hoang (jhh0089@unt.edu)
// 11/17/14
// CSCE 2100.002 Computing Foundations - Dr. Burke
//
// Program #2 - C++ Doubly Linked List
//
// Purpose - 
//	-The purpose of this program is toImplement a doubly linked list to store positive integers 
//	   (duplicate numbers are allowed). This list uses a class for the list
//	   and a class for the nodes. The node class assigns capabilities to store a single integer, 
//	   as well as pointers to the next and the previous nodes in the list. The class list will 
//	   need a LAST (TAIL) pointer (pointing at the last element of the list, a HEAD pointer, and 
//	   a CURRENT pointer. The CURRENT pointer will act as a "slider" that point to an element of 
//	   the list and can be moved to the LEFT or to the RIGHT. When the list is first initiated, 
//	   all three of the pointers are NULL. Once the first element is added, all of them will point 
//	   to this sole element in the list. 
//	  
//
///////////////////////////////////////////////////////////////////////


#include<iostream>
#include<string>

using namespace std;

class node{
        public:
                		
		int nodeValue;
		node* right;
		node* left;
		node *head;
                node *tail;
		friend class List;

}*current;


class List{		
	public:
		List();
		node *head;
		node *tail;

		void insertRoot(int);
		void insertRight(int);
                void insertLeft(int);
                void moveLeft();
                void moveRight();
                void search(int);
                void print();

}*linkedList;

//constructor
List::List()
{
	current = NULL;
}

int main()
{	
	string choice;
	int value; 	
	List* linkedList;
	
	//menu options
	cout << endl;
	cout << "\n\nSelect the one of the following LIST operations that you would like to conduct - type one of the following commands that you want to use: " << endl;
	cout << "1. addleft x\n2. addright x\n3. left\n4. right\n5. search\n6. print\n7. quit" << endl;
	cout << endl;
	//Keep the program running until user inputs "quit"
	do{
	//reset value
	value = 0;
	//user input indicator
	cout << "list> ";
	//store user input
	cin >> choice;
	
	if(choice == "addleft")
	{
		//scans the integer input by the user
		cin >> value;
		
		if(current == NULL)
		{
			//initializes the list if it is empty
			linkedList->insertRoot(value);
		}
		else
		{
			//adds a node to the left of where the CURRENT pointer is, BUT does NOT move the current pointer
			linkedList->insertLeft(value);
		}
	}
	else if(choice == "addright")
        {
		//scans the integer input by the user
                cin >> value;

		if(current == NULL)
                {
			//initializes the list if it is empty
                        linkedList->insertRoot(value);
                }
                else
                {
			//adds a node to the right of where the CURRENT pointer is, BUT does NOT move the current pointer
                        linkedList->insertRight(value);
                }
        }
	else if(choice == "left")
        {
		//moves CURRENT pointer Left 1 position
                linkedList->moveLeft();
        }
	else if(choice == "right")
        {
		//moves CURRENT pointer right 1 position
                linkedList->moveRight();
        }
	else if(choice == "search")
        {
		//scans user integer input
                cin >> value;
		//searches list from left to right
		linkedList->search(value);
        }
	else if(choice == "print")
	{
		//prints list from left to right
		linkedList->print();
	}
	else if(choice != "quit")
	{
		//error handling
		cout << "ERROR: Invalid input!" << endl;
	}
	
	}while(choice != "quit");   //Keeps the program running, allowing the user to input more commands	
	cout << "\nYou are QUITTING this program. Any previously input data will NOT be saved.\n" << endl;
	return 0;
}

//Initilazes the list with the first node
void List::insertRoot(int value){

	//creates new space
        current = new node;
	//records the user integer input into the node
        current->nodeValue = value;
	//initializes the left and right sides to the nodes
        current->right = NULL;
        current->left = NULL;
	//sets the head and tail of the list
        current->head = current;
        current->tail = current;

        return;
}

//prints the list
void List::print()
{
	//temporary node
	node *temp;
	if(current == NULL)
	{
		cout << "ERROR: This list is EMPTY!" << endl;
		return;
	}
	//start the printing from the left side
	temp = current->tail;
	//traverse the list to print
	while(temp != NULL)
	{
		cout << "-" << temp->nodeValue;
		temp = temp->right;
	}
	cout << "-" << endl;
	return;
	
}

//insert node to the left of CURRENT pointer
void List::insertLeft(int value)
{	
	node *temp;	
        temp = new node;
        temp->nodeValue = value;
	//if the left node is NULL, creates a new node to the left
	if(current->left == NULL)
	{
		temp->left = NULL;
		temp->right = current;
		current->left = temp;
		current->tail = temp;
	}
	else
	{
		//if left node is an existing node, push the nodes on the left one space to add another node to the left of Current pointer
		temp->left = current->left;
		temp->left->right = temp;
		current->left = temp;
		temp->right = current;
	}
        return;

}

//insert node to the right of CURRENT pointer
void List::insertRight(int value)
{
	node *temp;
        temp = new node;
        temp->nodeValue = value;
	//if the right node is NULL, creates a new node to the right
        if(current->right == NULL)
        {
                temp->right = NULL;
                temp->left = current;
                current->right = temp;
                current->head = temp;
        }
        else
        {
		//if right node is an existing node, push the nodes on the right one space to add another node tothe right of Current pointer
                temp->right = current->right;
                temp->right->left = temp;
                current->right = temp;
                temp->left = current;
        }
        return;

}

//move the CURRENT pointer one position to the LEFT
void List::moveLeft()
{
	node *temp;
	if(current == NULL)
        {
                cout << "ERROR: This list is EMPTY!" << endl;
                return;
        }
	else if(current->left == NULL)
	{
		//at the end of the list
		cout << "ERROR: End of list reached!" << endl;
		return;
	}
	//uses temp to move nodes around temporarily so that CURRENT can be set one position to the LEFT
	temp = current->left;
	temp->right = current;
	temp->tail = current->tail;
	temp->head = current->head;
	current = temp;
	//prints the value within the new current pointer position
	cout << current->nodeValue << endl;
	return;
}

//move the CURRENT pointer one position to the LEFT
void List::moveRight()
{
        node *temp;
        if(current == NULL)
        {
                cout << "ERROR: This list is EMPTY!" << endl;
                return;
        }
	else if(current->right == NULL)
        {
		//at the end of the list
                cout << "ERROR: End of list reached!" << endl;
                return;
        }
	//uses temp to move nodes around temporarily so that CURRENT can be set one position to the RIGHT
        temp = current->right;
        temp->left = current;
        temp->tail = current->tail;
        temp->head = current->head;
        current = temp;
	//prints the value within the new current pointer position
        cout << current->nodeValue << endl;
        return;
}

//Searches the list from LEFT to RIGHT for a specific user input integer
void List::search(int value)
{
	node *temp;
	//if the list is empty
	if(current == NULL)
	{
		cout << "False" << endl;
	        return;
	}
	//sets the search to start on the left
        temp = current->tail;
	//traverse the list to find the integer
        while(temp != NULL)
        {
                if(temp->nodeValue == value)
                {
			//print true if found
			cout << "True" << endl;
			return;
		}
		else
		{
			//check next node
			temp = temp->right;
		}
        }
	//print false if it doesn't exist
        cout << "False" << endl;
        return;

}
