////////////////////////////////////////////////////////////////////
// Jason Hoang (jhh0089@unt.edu)
// 9/24/14
// CSCE 2100.002 Computing Foundations - Dr. Burke
//
// Program #1 - C++ Tutorial
//
// Purpose - 
//	-The purpose of this program is to ensure that I have the ability to write,
//	  edit, test, and submit C++ programs in the UNT infrastructure
//
// Enhancements - 
//	-I implemented a simple menu screen that is recalled after performing the math.
//	-I also implemented two extra math operations: Subtraction and Division.
//	-Finally, added an option for the user to go back and pick two new numbers.
//
//////////////////////////////////////////////////////////////////////

#include<iostream>

using namespace std;

//function prototypes
void add(double num1, double num2);
void multiply(double num1, double num2);
void subtract(double num1, double num2);
void divide(double num1, double num2);

int main()
{
	// number holders
	double num1, num2;
	int choice;

	//prompts
	cout << "Type in a number: " << endl;
	cin >> num1;

	cout << "Now type in a second number" << endl;
	cin >> num2;

	//Keep the MATH operations menu open until the user is done with the program
	do{

	cout << "\n\nSelect the one of the following MATH operations that you would like to conduct with these two numbers - (" << num1 << " and " << num2 << ") - input the corresponding number next to the operation that you want to use: " << endl;
	cout << "1. ADD\n2. MULTIPLY\n3. SUBTRACT\n4. DIVIDE\n5. Pick NEW Numbers\n6. QUIT" << endl;
	cin >> choice;

	//switch statement to apply the menu
	switch(choice)
	{
		case 1:
			add(num1, num2);
			break;
		case 2:
			multiply(num1, num2);
			break;
		case 3:
			subtract(num1, num2);
			break;
		case 4:
			divide(num1, num2);
			break;
		case 5:
			//User inputs new numbers for the program
			cout << "Type in a NEW number: " << endl;
		        cin >> num1;
        		cout << "Now type in a NEW second number" << endl;
        		cin >> num2;
			break;
		case 6:
			cout << "\nYou chose to QUIT the Program!\n" << endl;
			return 0;
	}

	}while(choice != 6); //Keep the menu running

	return 0;
}

//functions
void add(double num1, double num2)
{
	double result;
	result = num1 + num2;
	cout << "The result from ADDING these numbers is: " << result << endl;
	return;
}

void multiply(double num1, double num2)
{
        double result;
        result = num1 * num2;
        cout << "The result from MULTIPLYING these numbers is: " << result << endl;
        return;
}

void subtract(double num1, double num2)
{
        double result;
        result = num1 - num2;
        cout << "The result from SUBTRACTING these numbers is: " << result << endl;
        return;
}

void divide(double num1, double num2)
{
        double result;
        result = num1 / num2;
        cout << "The result from DIVIDING these numbers is: " << result << endl;
        return;
}

