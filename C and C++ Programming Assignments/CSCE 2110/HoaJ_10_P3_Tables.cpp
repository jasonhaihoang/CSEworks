//***********************************************************************************
//
//	Jason Hoang
//	CSCE 2110 - Program 3: Database
//	Dr. Burke - DUE: April 21, 2015
//
//	The purpose of this program was to build a database with two tables. The
//	first table holds the student information (id, fist name, last name) while
//	the second table holds the grades and classes of these students (student id, 
//	class, letter grade). Each table has its own key(s): for students it's the 
//	student id, for the grades it's the student's id and the class name. These 
//	keys are needed to link the two tables together when adding and removing
//	tuples from the database. This program simulates the use of tuples in a
//	simple and typical educational system.
//
//	The program utilizes the class structure and the vector lists to store each 
//	tuple and organize the tables. A boolean function is also used to help sort
//	the tables according to the requirements of the program.
//
//***********************************************************************************

#include <iostream>
#include <cstdlib>
#include <string>
#include <vector>
#include <algorithm>

using namespace std;

//Structure to store student tuples
class Student{
	private:
		string FirstN;
		string LastN;
	
	public:
		Student();
		Student(int, string, string);
		
		int studentID;
	
		void stuAdd(vector<Student>&, int);
		void stuDel(vector<Student>&, int);
		void stuDisplay(vector<Student>&);
		void sortStudents(vector<Student>&);		
	
		int getStudentID() const;
};

//A temporary structure to sort the class names according to the program requirements
class Classes{
        private:
                string ClassN;

        public:
                Classes();
                Classes(string);

                string getClassN() const;
                void classAdd(vector<Classes>&, string);
};

//Structure to store the grade information for each student and class
class Grade{
	private:
		string LetterG;
	
	public:
		Grade();
		Grade(int, string, string);
		
		int studentID; 		//public for sorting
		string ClassN;

		void gradeAdd(vector<Student>&, vector<Grade>&, int, string);
		void gradeDel(vector<Grade>&, int);
		void gradeDisplay(vector<Grade>&);
		void stuDel(vector<Grade>&, int);
		void sortStudents(vector<Grade>&);
		
		int getStudentID() const;
		string getClassN() const;
};

//constructor
Student::Student(){
	int studentID = -1;
}
//overload constructor
Student::Student(int newStudentID, string newFirstN, string newLastN){
	studentID = newStudentID;
	FirstN = newFirstN;
	LastN = newLastN;
}

int Student::getStudentID() const{
	return studentID;
}
//boolean sort algorithm for student ID
bool students(const Student &lhs, const Student &rhs) { return lhs.studentID < rhs.studentID; }

void Student::sortStudents(vector<Student>& stuList)
{
    sort(stuList.begin(), stuList.end(), students);
    return;
}

//adds students to the database
void Student::stuAdd(vector<Student>& stuList, int newStudentID){
	int tempID;
	int pos = 0;
	string newFirstN, newLastN;

	cin >> newFirstN;	//reads in the additional info
	cin >> newLastN;
	//checks to see if student exists
	for(int i=0; i < stuList.size(); i++)
	{
		tempID = stuList[i].getStudentID();
		if(tempID == newStudentID)
		{
			cout << "ERROR: This student already exists." << endl;
			return;
		}
	}
	//Adds new student to database
	Student newStudent(newStudentID, newFirstN, newLastN);
	stuList.push_back(newStudent);
	//clear cin errors
        cin.clear();
        cin.ignore(10000, '\n');
        //return to input
	return;
}
//delete student from student list vector
void Student::stuDel(vector<Student>& stuList, int studentID){
	int tempID, i;
	//locates student to be deleted
	for(i=0; i < stuList.size(); i++)
	{
		tempID = stuList[i].getStudentID();
		if(tempID == studentID)
		{
			//deletes student
			stuList.erase(stuList.begin()+(i));
			return;
		}
	}
	if(i == stuList.size())	//if student not found
	{
		cout << "ERROR: This student does not exist" << endl;
		return;
	}
}
//displays all students in database
void Student::stuDisplay(vector<Student>& stuList){
	int tempSize;
	tempSize = stuList.size();	//gets number of students

	if(stuList.empty())	//if no students in database
	{      
		cout << "Empty Table" << endl;
		return;
	}
	//traverses student list
	for(int i=0; i < stuList.size(); i++)
	{	
		//prints
		cout << "(" << stuList[i].studentID << "," << stuList[i].FirstN << "," << stuList[i].LastN << ")";
		if(i == (tempSize - 1))	//return at end of list
		{
			//clear cin errors
                	cin.clear();
                	cin.ignore(10000, '\n');
                	//return to input
			cout << endl;	//proper spacing
			return;
		}
		else
		{
			cout << "-";	//proper notation
		}
	}
}

//Grade functions
//Grade constructor
Grade::Grade(){
	int studentID = -1;
}
//Grade constructor overload
Grade::Grade(int newStudentID, string newClassN, string newLetterG){
	studentID = newStudentID;
	ClassN = newClassN;
	LetterG = newLetterG;
}

int Grade::getStudentID() const{
	return studentID;
}

string Grade::getClassN() const{
	return ClassN;
}
//add grade info to database
void Grade::gradeAdd(vector<Student>& stuList, vector<Grade>& gradeList, int newStudentID, string newClassN){
	int tempID;
	int i, j;
	string tempClassN, newLetterG;

	cin >> newLetterG;	//additional info
	//checks to see if student exists
	for(i=0; i < stuList.size(); i++)
	{
		tempID = stuList[i].getStudentID();
        	if(tempID == newStudentID)
        	{
			//checks to see if student has a grade for this course
        		for(j=0; j < gradeList.size(); j++)
        		{
                		tempID = gradeList[j].getStudentID();	//student exists
                		tempClassN = gradeList[j].getClassN();	//student already has a grade
                		if((tempID == newStudentID) && (tempClassN == newClassN))
                		{
                        		cout << "ERROR: This student already has a grade for this course." << endl;
                        		return;
                		}
        		}
			//add grade
        		Grade newGrade(newStudentID, newClassN, newLetterG);
        		gradeList.push_back(newGrade);

        		//clear cin errors
        		cin.clear();
        		cin.ignore(10000, '\n');
        		//return to input
        		return;
		}
	}
	if(i == stuList.size())		// if student doesn't exist
	{
		cout << "ERROR: This student does not exist." << endl;
                return;
	}
}

//boolean function to sort student ID for grades table
bool members(const Grade &lhs, const Grade &rhs) { return lhs.studentID < rhs.studentID; }

void Grade::sortStudents(vector<Grade>& gradeList)
{
    sort(gradeList.begin(), gradeList.end(), members);
    return;
}
//deletes single tuple grade
void Grade::gradeDel(vector<Grade>& gradeList, int studentID){
	int tempID, i;
	string tempClassN, classN;
	
	cin >> classN;	//additional info
	//locates student grade to be erased
	for(i=0; i < gradeList.size(); i++)
	{
		tempID = gradeList[i].getStudentID();
		tempClassN = gradeList[i].getClassN();
		if((tempID == studentID) && (tempClassN == classN))
		{
			//delete grade
			gradeList.erase(gradeList.begin()+(i));
			return;
		}
	}
	if(i == gradeList.size())	//if student doesn't have any grades for course
	{	
		cout << "This student does not have any grades for this course." << endl;
		return;
	}
}
//prints grade database
void Grade::gradeDisplay(vector<Grade>& gradeList){
	Classes classObj;		//temporary class and vector
	vector<Classes> classList;	//mainly for grouping the classes together

	int tempGraSize, tempClaSize;
	string tempClassN, ClassN;
	int iter = 0;
	tempGraSize = gradeList.size();
	//checks if table is empty
	if(gradeList.empty())
	{
		cout << "Empty Table" << endl;
		return;
	}
	//begin class name sorting process
	ClassN = gradeList[0].getClassN();
	//add to classList to be sorted
	classObj.classAdd(classList, ClassN);
	for(int k=0; k < classList.size(); k++)
	{
		ClassN = classList[k].getClassN();	//traverses class list to print the students in the same class first
		for(int i=0; i < gradeList.size(); i++)
		{
			tempClassN = gradeList[i].getClassN();	//finds the students in the same class
			if(iter == 0)	//for proper notation
			{
				if((tempClassN == ClassN))	//prints first student overall
                       		{
                               		cout << "(" << gradeList[i].studentID << "," << gradeList[i].ClassN;
					cout << "," << gradeList[i].LetterG << ")";
					iter++;		//prevents function from displaying improper notation
                        	}	
			}
			else if(tempClassN != ClassN)	//adds other classes found while printing students in same class
			{
				classObj.classAdd(classList, tempClassN);	//adds other classes to list to be traversed
			}
			else
			{
				if((tempClassN == ClassN))	//prints all following students after the first
                        	{
                              		cout << "-";	//proper notation
					cout << "(" << gradeList[i].studentID << "," << gradeList[i].ClassN; 
					cout << "," << gradeList[i].LetterG << ")";
				}
			}
		}
	}
	//clear cin errors
        cin.clear();
        cin.ignore(10000, '\n');
        //return to input
        cout << endl;
        return;	
}
//deletes all grades for a single student that was deleted
void Grade::stuDel(vector<Grade>& gradeList, int studentID){
	int tempID;
	//traverses list of grades
	for(int i=0; i < gradeList.size(); i++)
	{
		tempID = gradeList[i].getStudentID();
		if(tempID == studentID)	//finds and deletes specified student grades
		{
			//delete student's grade
			gradeList.erase(gradeList.begin()+i);
			i--;	//corresponds to shrinking vector list to continue finding other related tuples
		}
	}
	//clear cin errors
        cin.clear();
        cin.ignore(10000, '\n');
        //return to input
	return;
}

//Class Functions
//Class constructor
Classes::Classes(){}
//Class Overload Constructor
Classes::Classes(string newClassN){
	ClassN = newClassN;
}

string Classes::getClassN() const{
	return ClassN;
}
//Adds class names to the temporary class structure
void Classes::classAdd(vector<Classes>& classList, string newClassN){
	string tempClassN;
	//checks for classes that were already added
	for(int i=0; i < classList.size(); i++)
	{
		tempClassN = classList[i].getClassN();
		if(tempClassN == newClassN)
		{	
			//Class already added
			return;
		}
	}
	//adds class name
	Classes newClasses(newClassN);
	classList.push_back(newClasses);
	return;
}

//////////MATH//////////
int main()
{
	Student stuObj;			//classes
	Grade gradeObj;
	Classes classObj;
	int value;
	string option;			//cin holders
	string choice;
	string classN;

	vector<Student> stuList;	//vectors
	vector<Grade> gradeList;
	vector<Classes> classList;	
	
	cout << endl;

	//Keep the program running until user inputs "quit"
	do{

	//set value
	value = 0;
	//user input indicator
	cout << "table> ";
	//store user input
	cin >> choice;
	
	if(choice == "students")	//STUDENTS DATABASE
	{
		//scans the option input by the user
		cin >> option;
		if(option == "add")
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
                		stuObj.stuAdd(stuList, value);
			}
		}
		else if(option == "delete")
		{
			if(!(cin >> value))
                        {
                                //error handling
                                cout << "INVALID COMMAND" << endl;
                                cin.clear();
                                cin.ignore(100, '\n');
                        }
                        else
                        {
                                //calls delete function
	                        stuObj.stuDel(stuList, value);		//deletes student
				gradeObj.stuDel(gradeList, value);	//deletes student's grades
                        }
		}
		else if(option == "display")
		{
			//calls display function - students
			stuObj.sortStudents(stuList);		//sorts students by ID
			stuObj.stuDisplay(stuList);		//prints
		}
		else
		{
			//error handling
                        cout << "INVALID COMMAND" << endl;
                        cin.clear();
                        cin.ignore(100, '\n');
		}
	}
	else if(choice == "grades")	//GRADES DATABASE
        {
		cin >> option;
		if(option == "add")
		{
                        if(!(cin >> value))
                        {
                                //error handling
                                cout << "INVALID COMMAND" << endl;
                                cin.clear();
                                cin.ignore(100, '\n');
                        }
                        else
                        {
				cin >> classN;
                                //calls add function - grades
				gradeObj.gradeAdd(stuList, gradeList, value, classN);
                        }
                }
                else if(option == "delete")
                {
                        if(!(cin >> value))
                        {
                                //error handling
                                cout << "INVALID COMMAND" << endl;
                                cin.clear();
                                cin.ignore(100, '\n');
                        }
                        else
                        {
                                //calls delete function - grades
                                gradeObj.gradeDel(gradeList, value);	//deletes single grade tuple
                        }
                }
		else if(option == "display")
		{
			//calls desiplay function - grades
			gradeObj.sortStudents(gradeList);		//sorts grade list by student ID
			gradeObj.gradeDisplay(gradeList);		//sorts table by grouping the class names together
		}							//then prints
		else
		{
			//error handling
                        cout << "INVALID COMMAND" << endl;
                        cin.clear();
                        cin.ignore(100, '\n');
                }

        }
	else if(choice == "quit")
	{
		//exits loop without going through error message
		break;
	}
	else
	{	
		//error handling
		cin.clear();
		cin.ignore(100, '\n');
		cout << "INVALID COMMAND" << endl;
	}
		
	}while(choice != "quit");   //Keeps the program running, allowing the user to input more commands	
	cout << "\nYou are QUITTING this program. Any previously input data will NOT be saved.\n" << endl;
	return 0;
	
}
