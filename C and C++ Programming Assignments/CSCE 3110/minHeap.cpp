/***************
Name:	Jason Hoang
Course:	CSCE 3110
Assignment:	PROGRAM 4 - MinHeaps
Due Date:	7-31-2015
NOTE: I implemented both versions of the DELETE Function. 
      To use the one desired, simply comment out/in the correct function calls in case 'D': of the switch block.
****************/

#include <iostream>
#include <fstream>

using namespace std;

void insertHeap(int *minHeap, int &numNodes, int value);
void deleteHeap(int *minHeap, int &numNodes, int value);	// ORIGINAL Delete Function
void deleteMin(int *minHeap, int &numNodes, int value);		// REVISED Delete Function
void changeHeap(int *minHeap, int &numNodes, int value, int newValue);
void printPOSTheap(int *minHeap, int numNodes, int index, ofstream& printed);
int leftChildi(int index);
int rightChildi(int index);
void minHeapify(int *minHeap, int i, int &numNodes);

// MAIN
int main()
{
	char choice;
	int value, newValue;
	int minHeap[501];	// 501 to accomodate for index starting at 1 instead of 0
	int numNodes = 0;
	ofstream printed("MinHeap_Output.txt");
	// input is redirected from another file provided by the user
	while(cin >> choice)	// INSERT, DELETE, CHANGE, or PRINT
	{
		switch(choice)
		{
			case 'C': // CHANGE
				cin >> value;		// value to be changed
				cin >> newValue;	// replacement value
				changeHeap(minHeap, numNodes, value, newValue);
				break;
			case 'P': // PRINT the heap after POSTORDER traversal
				if(printed.is_open())
				{
					printPOSTheap(minHeap, numNodes, 1, printed);	// Pass 1 as the root index of the heap
					printed << endl;	// line break
				}
				break;
			case 'I': // INSERT
				cin >> value;
				insertHeap(minHeap, numNodes, value);
				break;
			case 'D': // DELETE
				cin >> value;	// **This cin is only needed for the original Delete Function** //
				deleteHeap(minHeap, numNodes, value);		// ORIGINAL Delete Function
				//deleteMin(minHeap, numNodes, value);		// REVISED Delete Function
				break;
		}
		//cout << "Number of Nodes: " << numNodes << endl;
	}		
	printed.close();	// close output file
	return 0;
}

// INSERT FUNCTION
void insertHeap(int *minHeap, int &numNodes, int value)
{
	int i;	//index holder
	minHeap[numNodes+1] = value;	// put value in the next node
	i = numNodes+1;		// record new index
	while((i > 1) && (minHeap[i/2] > value))	// while the tree is not empty, there is a root
	{						// if new value is larger than parent
		minHeap[i] = minHeap[i/2];		// switch new value with the parent value
		i = (i/2);				// traverse up to next parent for next comparison
	}
	minHeap[i] = value;				// set the new node in position
	numNodes++;					// increment the number of nodes
}

// ORIGINAL - DELETE VALUES FUNCTION
void deleteHeap(int *minHeap, int &numNodes, int value)
{
	int i;
	if(numNodes == 0)
	{
		cout << "ERROR: Heap is EMPTY." << endl;
		return;
	}

	// SEARCH
	for(i=1; i<=numNodes; i++)
	{
		if(minHeap[i] == value)
		{
			//DELETE
			minHeap[i] = minHeap[numNodes];			// DELETE node with value
			numNodes--;                                     // decrement number of nodes
			for(int j=numNodes/2; j>=1; j--)
			{
				minHeapify(minHeap, i, numNodes);	// adjust the heap to satisfy MinHeap
			}
		}
		// else continue for loop until all nodes with the value are deleted
	}
	return;
}

// REVISED - DELETE VALUES FUNCTION
void deleteMin(int *minHeap, int &numNodes, int value)
{
        if(numNodes == 0)
        {
                cout << "ERROR: Heap is EMPTY." << endl;
                return;
        }
	
        //DELETE
        minHeap[1] = minHeap[numNodes];                 // DELETE the root because it is the MINIMUM value
        numNodes--;                                     // decrement number of nodes
        minHeapify(minHeap, 1, numNodes);       	// adjust the heap to satisfy MinHeap
	return;
}

// CHANGE VALUES FUNCTION
void changeHeap(int *minHeap, int &numNodes, int value, int newValue)
{
	int i;
        if(numNodes == 0)
        {
                cout << "ERROR: Heap is EMPTY." << endl;
                return;
        }

        // SEARCH AND DELETE
        for(i=1; i<=numNodes; i++)
        {
                if(minHeap[i] == value)
                {
                        // CHANGE
                        minHeap[i] = newValue;                 // CHANGE node with value to new value
                        for(int j=numNodes/2; j>=1; j--)
                        {
                                minHeapify(minHeap, i, numNodes);       // adjust the heap to satisfy MinHeap
                        }
                }
                // else continue for loop until all nodes with the value are changed
        }
	return;
}

// PRINT HEAP FUNCTION IN POSTORDER
void printPOSTheap(int *minHeap, int numNodes, int index, ofstream& printed)
{
        if(printed.is_open())
        {
		if((index <= numNodes) && (index >= 1))				// L-R-V
		{
			printPOSTheap(minHeap, numNodes, leftChildi(index), printed);		// Traverse LEFT subtree
			printPOSTheap(minHeap, numNodes, rightChildi(index), printed);		// Traverse RIGHT subtree
			printed << minHeap[index] << ", ";			// PRINT Value
		}
	}
	return;
}

int leftChildi(int index)	// returns index of the next LEFT child
{
	int nextIndex;
	nextIndex = ((2*index));
	return nextIndex;
}

int rightChildi(int index)	// returns index of the next RIGHT child
{
	int nextIndex;
	nextIndex = ((2*index)+1);
        return nextIndex;
}

// HEAPIFY FUNCTION IN MINIMUM FORM
void minHeapify(int *minHeap, int i, int &numNodes)
{
	int temp;	// temporary value holder
	int j;		// index holder
	j = 2*i;	// set subtrees to index
	temp = minHeap[i];	// temporarily hold the root node
	while(j <= numNodes)
	{
		if((j < numNodes) && (minHeap[j] > minHeap[j+i]))
		{
			j++;			// traverse the tree to find the lesser of the two nodes
		}
		if(temp < minHeap[j])
		{
			break;			// break if the root is less than it's children
		}
		else if(temp >= minHeap[j])
		{
			minHeap[j/2] = minHeap[j];	// j indexed value replaces it's parent's value
			j = 2*j;			// traverse subtree to find replacements and adjust the heap
		}
	}	
	minHeap[j/2] = temp;	// set parent of j indexed node to the root value
	return;
}
