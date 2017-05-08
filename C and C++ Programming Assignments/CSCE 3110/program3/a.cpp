/***************
Name:	Jason Hoang
Course:	CSCE 3110
Assignment:	PROGRAM 3 - Binary Search Trees - PART A
Due Date:	7-17-2015
****************/

#include <iostream>
#include <time.h>	//for the clock function
#include <iomanip>	//for use of setprecision()

using namespace std;

struct node		//Data structure to hold the node info and pointers to children and parent
{
	int value;
	node* left;
	node* right;
	node* parent;
}*root;	

class BinaryTree	//Probably unecessary class to hold tree functions
{
	public:
		BinaryTree();

		void insert(int value, node*& leaf);	//insert node
		void remove(int value, node*& node);	//recursively remove node
		int LargestLeftTree(node*& node);	//Predecessor function
};

BinaryTree::BinaryTree()
{
	root = NULL;		//constructor builds the root node of the tree
}

int main()
{
	BinaryTree *ExampleA;		//called to use tree functions
	clock_t c0, c1;			//clock time holders
	float t;			//CPU time holder
	
	//The insert and remove function calls are hard coded for ease of demonstration and execution
	//feel free to alter this code for your own testing purposes
	cout << endl;
	ExampleA->insert(5, root);	//HARD CODED node inserts
	ExampleA->insert(3, root);	//These functions pass in the binary tree by reference via the root
	ExampleA->insert(7, root);
	ExampleA->insert(2, root);
	ExampleA->insert(5, root);
	ExampleA->insert(10, root);
	ExampleA->insert(6, root);
	ExampleA->insert(8, root);
	ExampleA->insert(15, root);
	ExampleA->insert(13, root);
	ExampleA->insert(9, root);
	ExampleA->insert(5, root);
	ExampleA->insert(4, root);
	ExampleA->insert(16, root);
	ExampleA->insert(17, root);
	ExampleA->insert(18, root);
	ExampleA->insert(11, root);
	ExampleA->insert(2, root);
        ExampleA->insert(1, root);
	cout << endl;
	
	c0 = clock(); //Start clock
	ExampleA->remove(3, root);	//HARD CODED node removal
	cout << "DELETED VALUE -- 3" << endl;
	ExampleA->remove(15, root);	//HARD CODED node removal
	cout << "DELETED VALUE -- 15" << endl;
	ExampleA->remove(7, root);	//HARD CODED node removal
	cout << "DELETED VALUE -- 7" << endl;
	ExampleA->remove(10, root);	//HARD CODED node removal
	cout << "DELETED VALUE -- 10" << endl;
	c1 = clock(); // Stop clock
	t = (c1-c0)/ (float) CLOCKS_PER_SEC;		//Calculate CPU time
	cout << "\nCPU Time for DELETE Strategy A:\t" << fixed << setprecision(12) << t << endl;
	cout << endl;
	
	return 0;
}

//INSERT function
void BinaryTree::insert(int value, node*& leaf)
{
	node *newLeaf = new node;	//sets up the new node being inserted
	newLeaf->value = value;		//gives the new node it's value property
	node *current = root;		//creates a pointer to keep track of traversing through the tree
	node *parent = NULL;		//pointer to keep track of who the new node's parent will be
	if(current != NULL)
	{
		while(current)		//traverse tree until the proper place for the new node is found
		{
			parent = current;	//keeps track of new node's parent
			//Then moves to the left or right to find the next empty slot in the tree
			current = (newLeaf->value > current->value) ? (current->right):(current->left);
		}
		
		if(value <= parent->value)	//inserts new node into left subtree
		{
			parent->left = newLeaf;		//connects new node to parent
			newLeaf->parent = parent;	
			newLeaf->left = NULL;
			newLeaf->right = NULL;
			cout << "INSERTED VALUE -- " << newLeaf->value << endl;
		}
		else//value > parent->value	//inserts new node into right subtree
		{
			parent->right = newLeaf;	//connects new node to parent
			newLeaf->parent = parent;
                        newLeaf->left = NULL;
                        newLeaf->right = NULL;
			cout << "INSERTED VALUE -- " << newLeaf->value << endl;
		}
	}
	else		//inserts root into tree
	{
		root = newLeaf;
		root->parent = NULL;	//root has no parent
		root->left = NULL;
		root->right = NULL;
		cout << "INSERTED ROOT VALUE -- " << value << endl;
	}
	return;
}

//DELETE Function
void BinaryTree::remove(int value, node*& leaf)
{
	int X;	//replacement value - named 'X' to satisfy problem 4.15's guidelines for the replacement node
	node *temp;	//temporary node

	//recursively locate node to be deleted
	if(value < leaf->value)			//search left tree
	{
        	remove(value, leaf->left);
        } 		
	else if(value > leaf->value)		//search right tree
	{
        	remove(value, leaf->right);
        } 
	else if((leaf->left != NULL) && (leaf->right != NULL))	//if (node->key == key) and has 2 children
	{
		leaf->value = LargestLeftTree(leaf->left);	//retrieve the predecessor value to replace the deleted node
		cout << "REPLACEMENT -- " << leaf->value << endl;
		remove(leaf->value, leaf->left);		//remove the predecessor node from original place
	}
	else 	//if (node->key == key) and 1 child or no children - DELETE
	{
		//RECURSIVE DELETION
		if(leaf->left != NULL)	//1 left child
		{
			temp = leaf->left;
			leaf->value = temp->value;	//copy over the node being deleted with the child of the deleted
			X = leaf->value;		//take the value of the node that replaced the deleted node
			//cout << "copied replacement's child to parent-thus delete replacement origin - " << X << endl;
			remove(X, leaf->left);		//recursively delete
		}
		else if(leaf->right != NULL)  //1 right child -- NOT USED IN PART A
                {
                        temp = leaf->right;		//same as left single child
                        leaf->value = temp->value;
			X = leaf->value;
			//cout << "copied replacement's child to parent-thus delete replacement origin - " << X << endl;
                        remove(X, leaf->right);
                }
		else			//FINAL DELETION -- end of recursive deletion
		{
			//cout << "parent -- " << leaf->parent->value << endl;		code to see that node were correctly
			//cout << "delete -- " << leaf->value << endl;			deleted recursively
			leaf = NULL;	//delete the last leaf
		}
        }
        return;
}

//PREDECESSOR Function
int BinaryTree::LargestLeftTree(node*& leaf)
{
	node *temp;	
	int value;
	temp = leaf;	//temporary node to find the predecessor
	
	while(temp->right != NULL)
        {
                temp = temp->right;	//traverse subtree until predecessor is found
        }
	value = temp->value;		//predecessor found, return
	return value;			//return the value of the replacement node
}

