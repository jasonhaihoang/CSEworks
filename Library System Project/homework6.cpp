// Jason Hoang (jhh0089@my.unt.edu)
// Homework 5 - Library Management Program in C++
// CSCE 1040 - Keathly

//main
#include<iostream>
#include<vector>
#include<string>
#include<algorithm>
#include<ctime>
#include<string>
#include<fstream>
#include<sstream>
#include "classes6.h"
#include "mainfuncs6.h"

using namespace std;

int main()
{
    //initialize classes
    Library lib;
    Patron patron;
    LibraryItem libraryitem;
    Loan loan;
    //initialize vectors
    vector<Library> library;
    vector<Patron> plist;
    vector<LibraryItem*> blist;
    vector<Loan> tlist;
    int choice;
    string results;

    do
    {
        cout << endl;
        cout << "\nWelcome to the Library Management System" << endl;
        cout << "NOTE: If you choose to exit this program without saving to a file, any unsaved data will not be recorded and this Library Database program will begin writing a new file the next time it is opened if an old Library Database file is not loaded." << endl;
        cout << endl;
        cout << "Before you can access the Members, Books, and Book Check-Outs within the Library Database..." << endl;
        cout << "You must Input the Library's Info into the System (Only if this is the FIRST time using this program, OR you did NOT SAVE the Library Info before you quit from the last time that you used this program.)" << endl;
        cout << "OR you can LOAD a saved file of the Library Database." << endl;
        cout << "Menu: Enter in the numerical choice of what you would like to do" << endl;
        cout << "1. Input New Library Info\n2. Load previously saved Library Database\n3. QUIT" << endl;
        // scan in user input
        cout << "\nEnter your choice: ";
        cin >> choice;
        cout << endl;
        cout << endl;

        switch(choice)
        {
            case 1:
                lib.inputInfo(library);
                //run main menu after inputing library info
                choice = LibrarySwitch(library, plist, blist, tlist);
                break;
            case 2:
                results = LoadFile(library, plist, blist, tlist);
                if(results == "SUCCESS")
                {
                    //run main menu after inputing library info
                    choice = LibrarySwitch(library, plist, blist, tlist);
                    break;
                }
                else
                {
                    //if failed to load library database
                    break;
                }
        }

    }while(choice != 3);    //keep running until user asks to quit

    return 0;
}


///Menu Functions
//Main Menu
int LibrarySwitch(vector<Library>& library, vector<Patron>& plist, vector<LibraryItem*>& blist, vector<Loan>& tlist)
{
    Library lib;
    int choice;

    do
    {
        cout << endl;
        cout << "\nLibrary Management System" << endl;
        cout << "NOTE: If you choose to exit this program without saving to a file, any unsaved data will not be recorded and this Library Database program will begin writing a new file the next time it is opened if an old Library Database file is not loaded." << endl;
        cout << endl;
        cout << "Main Menu: Enter in the numerical choice of what you would like to do within this Library Management System" << endl;
        cout << "1. To Member Menu\n2. To Books Menu\n3. To Check-Out Menu\n4. Edit Library Info\n5. Print Library Info";
        cout << "\n6. Save Library Database\n7. QUIT" << endl;
        // scan in user input
        cout << "\nEnter your choice: ";
        cin >> choice;
        cout << endl;
        cout << endl;

        switch(choice)
        {
            case 1:
                //Member Menu
                PatronSwitch(library, plist);
                break;
            case 2:
                //Book Menu
                ItemSwitch(library, blist);
                break;
            case 3:
                //Check-Out Menu
                LoanSwitch(plist, blist, tlist);
                break;
            case 4:
                lib.editInfo(library);
                break;
            case 5:
                lib.printInfo(library);
                break;
            case 6:
                SaveFile(library, plist, blist, tlist);
                break;
        }

    }while(choice != 7);
    return (3);
}

//Member Menu
void PatronSwitch(vector<Library>& library, vector<Patron>& plist)
{
    Patron patron;
    int choice;

    do
    {
        cout << endl;
        cout << "\nLibrary Management System" << endl;
        cout << "NOTE: If you choose to exit this program without saving to a file, any unsaved data will not be recorded and this Library Database program will begin writing a new file the next time it is opened if an old Library Database file is not loaded." << endl;
        cout << endl;
        cout << "Members Menu:" << endl;
        cout << "Enter in the numerical choice of what you would like to do with Members" << endl;
        cout << "1. Add a New Member\n2. Remove a Member\n3. Edit Member Info\n4. Print a List of all Members\n5. Sort the List of Members Alphabetically";
        cout << "\n6. Print an Address Label of a Member\n7. Print a Single Member's Info\n8. Pay Fines";
        cout << "\n9. << BACK" << endl;
        // scan in user input
        cout << "\nEnter your choice: ";
        cin >> choice;
        cout << endl;
        cout << endl;

        switch(choice)
        {
            case 1:
                patron.addPatron(library, plist);
                break;
            case 2:
                patron.deletePatron(plist);
                break;
            case 3:
                patron.editPatron(plist);
                break;
            case 4:
                patron.printPatron(plist);
                break;
            case 5:
                patron.sortPatrons(plist);
                break;
            case 6:
                patron.printAddress(plist);
                break;
            case 7:
                patron.printSingleMember(plist);
                break;
            case 8:
                patron.payFines(plist);
                break;
        }

    }while(choice != 9);
    return;
}

//LibraryItem Menu
void ItemSwitch(vector<Library>& library, vector<LibraryItem*>& blist)
{
    LibraryItem item;
    int choice;

    do
    {
        cout << endl;
        cout << "\nLibrary Management System" << endl;
        cout << "NOTE: If you choose to exit this program without saving to a file, any unsaved data will not be recorded and this Library Database program will begin writing a new file the next time it is opened if an old Library Database file is not loaded." << endl;
        cout << endl;
        cout << "Library Items Menu:" << endl;
        cout << "Enter in the numerical choice of what you would like to do with Library Items" << endl;
        cout << "1. Add a New Item\n2. Delete an Item\n3. Edit Item Info\n4. Print Item Info\n5. Sort the Catalog of Books Alphabetically by Author";
        cout << "\n6. Print the Item Catalog\n7. Record a LOST Item\n8. Print a list of LOST Books\n9. Record a FOUND Item";
        cout << "\n10. << BACK" << endl;
        // scan in user input
        cout << "\nEnter your choice: ";
        cin >> choice;
        cout << endl;
        cout << endl;

        switch(choice)
        {
            case 1:
                ItemTypeSwitch(library, blist);
                break;
            case 2:
                item.deleteItem(blist);
                break;
            case 3:
                item.editItem(blist);
                break;
            case 4:
                item.printItem(blist);
                break;
            case 5:
                item.sortItems(blist);
                break;
            case 6:
                item.printCatalog(blist);
                break;
            case 7:
                item.recordLost(blist);
                break;
            case 8:
                item.printLost(blist);
                break;
            case 9:
                item.recordFound(blist);
                break;
        }

    }while(choice != 10);
    return;
}

//Check-Out Menu
void LoanSwitch(vector<Patron>& plist, vector<LibraryItem*>& blist, vector<Loan>& tlist)
{
    Loan loan;
    int choice;

    do
    {
        cout << endl;
        cout << "\nLibrary Management System" << endl;
        cout << "NOTE: If you choose to exit this program without saving to a file, any unsaved data will not be recorded and this Library Database program will begin writing a new file the next time it is opened if an old Library Database file is not loaded." << endl;
        cout << endl;
        cout << "Transactions Menu:" << endl;
        cout << "Enter in the numerical choice of what you would like to do with Transactions" << endl;
        cout << "1. Check-Out a Book\n2. Return a Book\n3. Calculate Overdue Books\n4. Print Members with Fines\n5. Print Members with Outstanding Fines";
        cout << "\n6. Print Books that are currently Checked-Out\n7. Print a list of Overdue Books";
        cout << "\n8. << BACK" << endl;
        // scan in user input
        cout << "\nEnter your choice: ";
        cin >> choice;
        cout << endl;
        cout << endl;

        switch(choice)
        {
            case 1:
                loan.addLoan(plist, blist, tlist);
                break;
            case 2:
                loan.returnLoan(plist, blist, tlist);
                break;
            case 3:
                loan.calculateOverdue(plist, blist, tlist);
                break;
            case 4:
                loan.printFined(plist, blist, tlist);
                break;
            case 5:
                loan.printTopFines(plist, blist, tlist);
                break;
            case 6:
                loan.printOut(tlist);
                break;
            case 7:
                loan.printOverdue(tlist);
                break;
        }

    }while(choice != 8);
    return;
}

//add Item Menu
void ItemTypeSwitch(vector<Library>& library, vector<LibraryItem*>& blist)
{
    LibraryItem item;
    int choice;
    string newItemType;

    do
    {
        cout << endl;
        cout << "Add Items Menu:" << endl;
        cout << "Enter in the numerical choice of which item you would like to add" << endl;
        cout << "1. Add a New Book\n2. Add a New Reference Book\n3. Add a New DVD\n4. Add a New Book-on-Tape";
        cout << "\n5. << BACK" << endl;
        // scan in user input
        cout << "\nEnter your choice: ";
        cin >> choice;
        cout << endl;
        cout << endl;

        switch(choice)
        {
            case 1:
                newItemType = "Book";
                item.addItem(library, blist, newItemType);
                break;
            case 2:
                newItemType = "Reference";
                item.addItem(library, blist, newItemType);
                break;
            case 3:
                newItemType = "DVD";
                item.addItem(library, blist, newItemType);
                break;
            case 4:
                newItemType = "Tape";
                item.addItem(library, blist, newItemType);
                break;
        }

    }while(choice != 5);
    return;
}
