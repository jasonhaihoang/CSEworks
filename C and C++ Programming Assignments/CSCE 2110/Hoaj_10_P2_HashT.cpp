//*********************************************************************************
//     STUDENT:  Jason Hoang
//       CLASS:  CSCE-2110 - Dr. Burke
//
//  ASSIGNMENT:  <Program 2>
// DESCRIPTION:  Implement a Hash Table for integers using open hashing to represent sets of integers. 
//		 You may implement the hash table yourself or you may use the C++ standard template
//		 library. Your set must provide the basic set operations as discussed in class (add,
//               delete, search, show, quit). Each element of the set will be stored in a node object, i.e
// 		 you will need a separate class that handles the nodes.
//                           
//		 Upon starting your program, it will display the following prompt: 
//		 set> (followed by a space)
//                              
//		 The user can then add, delete, search, or show the set. If the element is already in 
//		 the set, then you need to create an error message. 
//		 
//		 Your hash table will have B=7 buckets and your hash function is h(x) = x^2 mod B. 
//               
// SPECIAL INSTRUCTION:  For this assignment, you must make your hash table "fool-proof", 
//		 i.e. implement error checking. Each error output must start with “Error!” 
//		 Followed by an appropriate message. It will be tested with single-character inputs 
//		 only, so it only has to work for integers 0-9. It does, however, have to provide 
//		 descriptive error messages for all non-numeric characters. 
//
//*********************************************************************************

#include <iostream>
#include <cstdlib>
#include <string>

using namespace std;

//******************************************************
// This section would be saved as <hashClass.h>

//Hash Table Class
class hash{
	private:
		static const int tableSize = 7;	//Number of Buckets
		
		//Number Nodes
		struct num{
			string check;		//bucket statud
			int value;		//number
			num* next;		//sets up the linked list within each bucket
		};

		num* HashTable[tableSize];	//Hash Table

	public:

		hash();				//Constructor
		int HashFunc(int key);		//Hash Function
		void AddNum(int value);		//Add Function
		void ShowTable();		//Show Function
		bool Search(int value);		//Search Function
		void Remove(int value);		//Remove Function
};


//******************************************************
// This section would be saved as <HashFunctions.cpp>

//HashTable Constructor
hash::hash()
{
	//traverses through each bucket
	for(int i = 0; i < tableSize; i++)
	{
		HashTable[i] = new num;			//creates bucket
		HashTable[i]->check = "Empty";		//sets bucket to empty
		HashTable[i]->value = 0;		//values are temporarily equal to 0
		HashTable[i]->next = NULL;		//sets up linked lists within each bucket
	}
}

//Given Hash Function
int hash::HashFunc(int value)
{

	int hash = 0;			
	int bucket;
	
	hash = value * value;		//(x^2)
	
	bucket = hash % tableSize;	//(x^2) mod 7 = bucket # where value will be stored
	
	return bucket;			

}

//add function
void hash::AddNum(int value)
{
	int bucket = HashFunc(value);		//bucket where the value will be stored
	bool foundValue;					
	foundValue = Search(value);		//Checks if value has already been added

	if(foundValue == true)
	{
		//error for duplicate value
		cout << "WARNING: Duplicate Input: " << value << endl;
		return;
	}
	else
	{
		//adds value to bucket in appropriate location
		if(HashTable[bucket]->check == "Empty")
		{
			//for first number in bucket
			HashTable[bucket]->check = "Used";
			HashTable[bucket]->value = value;
		}
		else
		{
			//linked list for extra numbers within a single bucket
			num* Ptr = HashTable[bucket];		//set bucket pointer
			num* NextInBucket = new num;		//create new temporary bucket
			NextInBucket->value = value;		//set value
			NextInBucket->next = NULL;		//set next node within bucket list
			
			//cycles through real bucket to find the end of the list
			while(Ptr->next != NULL)
			{	
				Ptr = Ptr->next;
			}
			Ptr->next = NextInBucket;		//adds node to Hash Table
		}
	}
}

//show function
void hash::ShowTable()
{	
	cout << endl;
	//cycles through each bucket within the table
	for(int i = 0; i < tableSize; i++)
	{
		num* Ptr = HashTable[i];	//bucket pointer
		if(i == 6)			//closing notation for last bucket
		{
			cout << "(";
			if(HashTable[i]->check == "Empty")
			{
				//closes bucket if empty
			}	
			else
			{
				//cycles through and prints bucket values
                        	while(Ptr != NULL)
                        	{
					if(Ptr->next == NULL)
					{
						cout << Ptr->value;
						Ptr = Ptr->next;
					}
					else
					{
                                		cout << Ptr->value << ",";
                                		Ptr = Ptr->next;
					}
                        	}
			}
                        cout << ")\n" << endl;		//notation
		}
		else
		{
			cout << "(";			//notation
			if(HashTable[i]->check == "Empty")
                        {
                               //moves to next bucket if empty
                        }
                        else
                        {
				//cycles through and prints bucket values
				while(Ptr != NULL)
				{
					if(Ptr->next == NULL)
                                        {
                                                cout << Ptr->value;
                                                Ptr = Ptr->next;
                                        }
                                        else
                                        {
                                                cout << Ptr->value << ",";
                                                Ptr = Ptr->next;
                                        }
				}
			}		
			cout << ")-";			//proper notation
		}
	}
}

//search function
bool hash::Search(int value)
{
	int bucket = HashFunc(value);			//find bucket where number is stored
	bool foundValue = false;			//set up boolean
	
	num* Ptr = HashTable[bucket];			//set up bucket pointer
	if(HashTable[bucket]->check == "Empty")
	{
		//basically returns false to function call
	}
	else
	{
		//cycles through the bucket values
		while(Ptr != NULL)
		{
			if(Ptr->value == value)
			{
				//returns true if value is found within bucket
				foundValue = true;
				return true;
			}
			Ptr = Ptr->next;
		}
	}
	return foundValue;
}

//delete function
void hash::Remove(int value)
{
	int bucket = HashFunc(value);		//find bucket where number is stored

	num* delPtr;
	num* TempPtr1;
	num* TempPtr2;
	
	//Case 0 - bucket is empty
	if(HashTable[bucket]->check == "Empty")
	{
		cout << "WARNING: Target value NOT found: " << value << endl;
		return;
	}
	//Case 1 - only 1 item in bucket and has matching value
	else if((HashTable[bucket]->value == value) && (HashTable[bucket]->next == NULL))
	{
		HashTable[bucket]->check = "Empty";		//removes # by changing the bucket status
		return;
	}
	//Case 2 - Match is located in the first item in the bucket and there are multiple #s in bucket
	else if(HashTable[bucket]->value == value)
	{
		delPtr = HashTable[bucket];			//pointer to hold the one being deleted
		HashTable[bucket] = HashTable[bucket]->next;	//shift pointers over to replace hole
		delete delPtr;					//delete
		return;
	}
	//Case 3 - bucket contains items but first item is not a match
	else
	{
		//set up bucket pointers
		TempPtr1 = HashTable[bucket]->next;
		TempPtr2 = HashTable[bucket];
		
		//while loop searches bucket for value
		while((TempPtr1 != NULL) && (TempPtr1->value != value))
		{
			TempPtr2 = TempPtr1;		
			TempPtr1 = TempPtr1->next;
		}
		//Case 3.1 - no match within entire
		if(TempPtr1 == NULL)
		{
			cout << "WARNING: Target value NOT found: " << value << endl;
	                return;
		}
		//Case 3.2 - find match among the additional numbers in bucket
		else
		{
			delPtr = TempPtr1;		//pointer to hold the one being deleted
			TempPtr1 = TempPtr1->next;	//shift pointers over to replace hole
			TempPtr2->next = TempPtr1;
	
			delete delPtr;			//delete
		}
	}
}


//**********************************************************
// This section would be saved as <HashMain.cpp>

int main()
{
	hash hashObj;
	bool search;
	int value;
	string choice;	

	//Keep the program running until user inputs "quit"
	do{
	//reset value
	value = 0;
	//user input indicator
	cout << "set> ";
	//store user input
	cin >> choice;
	
	if(choice == "add")
	{
		//scans the integer input by the user
		if(!(cin >> value))
		{
			//error handling
			cout << "INVALID COMMAND" << endl;
			cin.clear();
			cin.ignore(100, '\n');
		}
		else
		{
			//calls add function
			hashObj.AddNum(value);
		}
	}
	else if(choice == "delete")
        {
		//scans the integer input by the user
                if(!(cin >> value))
                {
			//error handling
                        cout << "INVALID COMMAND" << endl;
                        cin.clear();
                        cin.ignore(100, '\n');
                }		
		else
		{
			//Calls remove function
                	hashObj.Remove(value);
		}
        }
	else if(choice == "search")
        {
		//scans the integer input by the user
                if(!(cin >> value))
                {
			//error handling
                        cout << "INVALID COMMAND" << endl;
                        cin.clear();
                        cin.ignore(100, '\n');
                }		
		else
		{
			//searches hash table for value
			search = hashObj.Search(value);

			if(search == true)
        		{
                		cout << "True" << endl;
        		}
        		else
        		{
                		cout << "False" << endl;
        		}
		}
        }
	else if(choice == "show")
	{
		//prints hash table
		hashObj.ShowTable();
	}
	else if(choice == "quit")
	{
		//exits loop without going through error message
		break;
	}
	else
	{	
		//error handling
		cin.ignore(100, '\n');
		cout << "INVALID COMMAND" << endl;
	}
	
	}while(choice != "quit");   //Keeps the program running, allowing the user to input more commands	
	cout << "\nYou are QUITTING this program. Any previously input data will NOT be saved.\n" << endl;
	return 0;
	
}
