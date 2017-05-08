// Jason Hoang (jhh0089@my.unt.edu)
// Homework 5 - Library Management Program in C++
// CSCE 1040 - Keathly

//functions
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

///Library Functions
Library::Library(){
    int libID = 0;
}
//Overloaded Constructor
Library::Library(string newLibName, int newLibID, string newStAddress, string newCity, string newState, string newZip, string newPhone, string newEmail){
    libName = newLibName;
    libID = newLibID;
    StAddress = newStAddress;
    city = newCity;
    state = newState;
    zip = newZip;
    phone = newPhone;
    email = newEmail;
}

//get variable functions
string Library::getLibName() const{
    return libName;
}

int Library::getLibID() const{
    return libID;
}

string Library::getStAddress() const{
    return StAddress;
}

string Library::getCity() const
{
    return city;
}
string Library::getState() const
{
    return state;
}
string Library::getZip() const
{
    return zip;
}

string Library::getPhone() const{
    return phone;
}

string Library::getEmail() const{
    return email;
}

//set variable functions
void Library::setLibID(int editedInt){
    libID = editedInt;
}

void Library::setLibName(string editedString){
    libName = editedString;
}

void Library::setStAddress(string editedString){
    StAddress = editedString;
}

void Library::setCity(string editedString){
    city = editedString;
}

void Library::setState(string editedString){
    state = editedString;
}

void Library::setZip(string editedString){
    zip = editedString;
}

void Library::setPhone(string editedString){
    phone = editedString;
}

void Library::setEmail(string editedString){
    email = editedString;
}

//Main Library Functions
void Library::inputInfo(vector<Library>& library)
{
    int newLibID;
    string newLibName, newStAddress, newCity, newState, newZip, newPhone, newEmail;

    cout << "\nEnter the following information for the Library:" << endl;
    cout << "Enter library's unique 8 digit ID number (not starting with 0): ";
    cin >> newLibID;
    cout << endl;

    if((newLibID < 100000000) && (newLibID > 9999999))
    {
        //clear cin errors
        cin.clear();
        cin.ignore(10000, '\n');
        //return to input
        cout << "\nEnter library's name: ";
        getline(cin, newLibName);
        cout << "\nEnter library's address details:\n";
        cout << "Street Address: ";
        getline(cin, newStAddress);
        cout << "\nCity: ";
        getline(cin, newCity);
        cout << "\nState: ";
        getline(cin, newState);
        cout << "\nZip: ";
        cin >> newZip;
        //clear cin errors
        cin.clear();
        cin.ignore(10000, '\n');
        //return to input
        cout << "\nEnter library's phone number: ";
        getline(cin, newPhone);
        cout << "\nEnter library's email: ";
        cin >> newEmail;

        Library newLibrary(newLibName, newLibID, newStAddress, newCity, newState, newZip, newPhone, newEmail);  //overload constructor
        library.push_back(newLibrary);  //new vector element
        cout << endl;
        return;
    }
    else
    {
        cout << "Invalid Input." << endl;
        return;
    }
}

void Library::editInfo(vector<Library>& library)
{
    string editedString;
    int editedInt;
    int selection;

    do
    {
        cout << "\nWhat information would you like to edit?(enter the numerical value corresponding to the info)" << endl;
        cout << "1. Name: " << library[0].getLibName() << "\n2. Library ID: " << library[0].getLibID() << "\n3. Street Address: " << library[0].getStAddress() << "\n4. City: " << library[0].getCity();
        cout << "\n5. State: " << library[0].getState() << "\n6. Zip: " << library[0].getZip() << "\n7. Phone Number: " << library[0].getPhone() << "\n8. Email Address: " << library[0].getEmail();
        cout << "\n9. Exit" << endl;
        cout << "Enter your numerical selection: ";
        cin >> selection;
        //clear cin errors
        cin.clear();
        cin.ignore(10000, '\n');
        //return to input
        switch(selection)
        {
            case 1:
                cout << "\nNew Name: ";
                getline(cin, editedString);
                library[0].setLibName(editedString);
                cout << "Name EDITED!" << endl;
                break;
            case 2:
                cout << "\nNew Library ID: ";
                cin >> editedInt;
                library[0].setLibID(editedInt);
                cout << "Password EDITED!" << endl;
                break;
            case 3:
                cout << "\nNew Street Address: ";
                getline(cin, editedString);
                library[0].setStAddress(editedString);
                cout << "Street Address EDITED!" << endl;
                break;
            case 4:
                cout << "\nNew City: ";
                getline(cin, editedString);
                library[0].setCity(editedString);
                cout << "City EDITED!" << endl;
                break;
            case 5:
                cout << "\nNew State: ";
                cin >> editedString;
                library[0].setState(editedString);
                cout << "State EDITED!" << endl;
                break;
            case 6:
                cout << "\nNew Zip: ";
                cin >> editedString;
                library[0].setZip(editedString);
                cout << "Zip EDITED!" << endl;
                break;
            case 7:
                cout << "\nNew Phone Number: ";
                getline(cin, editedString);
                library[0].setPhone(editedString);
                cout << "Phone Number EDITED!" << endl;
                break;
            case 8:
                cout << "\nNew Email Address: ";
                cin >> editedString;
                library[0].setEmail(editedString);
                cout << "Email Address EDITED!" << endl;
                break;
        }
    }while(selection != 9);
    return;
}

void Library::printInfo(vector<Library>& library)
{
    cout << "Library Info within the Library Database: " << endl;

    cout << "\nName: " << library[0].libName << "\nLibrary ID: " << library[0].libID << "\nStreet Address: " << library[0].StAddress << "\nCity: " << library[0].city;
    cout << "\nState: " << library[0].state << "\nZip: " << library[0].zip << "\nPhone Number: " << library[0].phone << "\nEmail Address: " << library[0].email;
    cout << endl;

    return;
}

void Library::saveLibrary(vector<Library>& library)
{
    ofstream outfileLibrary;
    outfileLibrary.open("LibraryDatabaseLIBRARY.txt");

    if ( !outfileLibrary.is_open() )
    {
        cout << "ERROR: Unable to open Library Database LIBRARY File." << endl;
        return;
    }
    else
    {
        outfileLibrary << library[0].libName << ' ' << library[0].libID << '\n' << library[0].StAddress << '\n' << library[0].city << '\n'
        << library[0].state << '\n' << library[0].zip << '\n' << library[0].phone << '\n' << library[0].email << endl;

        outfileLibrary.close();
        cout << "Library Info SAVED." << endl;
        return;
    }
}

string Library::loadLibrary(vector<Library>& library)
{
    int newLibID;
    string newLibName, newStAddress, newCity, newState, newZip, newPhone, newEmail;

    ifstream infileLibrary;
    infileLibrary.open("LibraryDatabaseLIBRARY.txt");

    if ( !infileLibrary.is_open() )
    {
        cout << "ERROR: Unable to open Library Database LIBRARY File." << endl;
        return "FAIL";
    }
    else
    {
        while(infileLibrary >> newLibName >> newLibID >> newStAddress >> newCity >> newState >> newZip >> newPhone >> newEmail)
        {
            Library newLibrary(newLibName, newLibID, newStAddress, newCity, newState, newZip, newPhone, newEmail);
            library.push_back(newLibrary);
            infileLibrary.close();
            cout << "Library Info LOADED." << endl;
            return "SUCCESS";
        }
    }
}



///Patron Functions
Patron::Patron(){
    int patronID = 0;
    double fines = 0.00;
    int libraryID = 0;
}

//Overloaded Constructor
Patron::Patron(string newName, int newPatronID, string newPassword, string newStAddress, string newCity, string newState, string newZip, string newPhone, string newEmail, double newFines, int newLibraryID, string newPatronStatus){
    name = newName;
    patronID = newPatronID;
    password = newPassword;
    StAddress = newStAddress;
    city = newCity;
    state = newState;
    zip = newZip;
    phone = newPhone;
    email = newEmail;
    fines = newFines;
    libraryID = newLibraryID;
    patronStatus = newPatronStatus;
}

//get variable functions
string Patron::getName() const{
    return name;
}

int Patron::getPatronID() const{
    return patronID;
}

string Patron::getPassword() const{
    return password;
}

string Patron::getStAddress() const{
    return StAddress;
}

string Patron::getCity() const
{
    return city;
}
string Patron::getState() const
{
    return state;
}
string Patron::getZip() const
{
    return zip;
}

string Patron::getPhone() const{
    return phone;
}

string Patron::getEmail() const{
    return email;
}

double Patron::getFines() const{
    return fines;
}

int Patron::getLibraryID() const{
    return libraryID;
}

string Patron::getPatronStatus() const{
    return patronStatus;
}

//Main Member Functions
void Patron::addPatron(vector<Library>& library, vector<Patron>& plist)
{
    int temp;
    string newName, newPassword, newStAddress, newCity, newState, newZip, newEmail, newPhone, newPatronStatus;
    int newPatronID, newLibraryID;
    double newFines;

    if(plist.empty())   //check if vector is empty
    {
        cout << "\nEnter the following information for the new library member:" << endl;
        cout << "Enter member's unique 6 digit ID number (not starting with 0): ";
        cin >> newPatronID;
        cout << endl;

        if((newPatronID < 1000000) && (newPatronID > 99999))
        {
            //clear cin errors
            cin.clear();
            cin.ignore(10000, '\n');
            //return to input
            cout << "\nEnter member's name: ";
            getline(cin, newName);
            cout << "\nEnter member's password: ";
            cin >> newPassword;
            //clear cin errors
            cin.clear();
            cin.ignore(10000, '\n');
            //return to input
            cout << "\nEnter member's address details:\n";
            cout << "Street Address: ";
            getline(cin, newStAddress);
            cout << "\nCity: ";
            getline(cin, newCity);
            cout << "\nState: ";
            getline(cin, newState);
            cout << "\nZip: ";
            cin >> newZip;
            //clear cin errors
            cin.clear();
            cin.ignore(10000, '\n');
            //return to input
            cout << "\nEnter member's phone number: ";
            getline(cin, newPhone);
            cout << "\nEnter member's email: ";
            cin >> newEmail;

            newPatronStatus = "CLEAR";
            newFines = 0.00;
            newLibraryID = library[0].getLibID();

            Patron newPatron(newName, newPatronID, newPassword, newStAddress, newCity, newState, newZip, newPhone, newEmail, newFines, newLibraryID, newPatronStatus);
            plist.push_back(newPatron);
            cout << endl;
            return;
        }
        else
        {
            cout << "Invalid Input." << endl;
            return;
        }
    }
    else
    {
        cout << "\nEnter the following information for the new library member:" << endl;
        cout << "Enter member's unique 6 digit ID number (not starting with 0): ";
        cin >> newPatronID;

        if((newPatronID < 1000000) && (newPatronID > 99999))
        {
            for(int i = 0; i < plist.size(); i++)
            {
                temp = plist[i].getPatronID();
                if(temp == newPatronID)
                {
                    cout << "This member has already been added to the Library Database." << endl;
                    return;
                }
                else
                {
                    //clear cin errors
                    cin.clear();
                    cin.ignore(10000, '\n');
                    //return to input

                    cout << "\nEnter member's name: ";
                    getline(cin, newName);
                    cout << "\nEnter member's password: ";
                    cin >> newPassword;
                    //clear cin errors
                    cin.clear();
                    cin.ignore(10000, '\n');
                    //return to input
                    cout << "\nEnter member's address details:\n";
                    cout << "Street Address: ";
                    getline(cin, newStAddress);
                    cout << "\nCity: ";
                    getline(cin, newCity);
                    cout << "\nState: ";
                    getline(cin, newState);
                    cout << "\nZip: ";
                    cin >> newZip;
                    //clear cin errors
                    cin.clear();
                    cin.ignore(10000, '\n');
                    //return to input
                    cout << "\nEnter member's phone number: ";
                    getline(cin, newPhone);
                    cout << "\nEnter member's email: ";
                    cin >> newEmail;

                    newPatronStatus = "CLEAR";
                    newFines = 0.00;
                    newLibraryID = library[0].getLibID();

                    Patron newPatron(newName, newPatronID, newPassword, newStAddress, newCity, newState, newZip, newPhone, newEmail, newFines, newLibraryID, newPatronStatus);
                    plist.push_back(newPatron);
                    cout << endl;
                    return;
                }
            }

        }
        else
        {
            cout << "Invalid Input." << endl;
            return;
        }
    }
    return;

}

void Patron::deletePatron(vector<Patron>& plist)
{
    int i;
    int tempID;
    double tempFines;
    int patronID;
    string tempStatus;

    if(plist.empty())
    {
        cout << "There are no members to delete!" << endl;
    }
    else
    {
        cout << "Enter member's unique 6 digit ID number (not starting with 0): ";
        cin >> patronID;

        if((patronID < 1000000) && (patronID > 99999))
        {
            for(i = 0; i < plist.size(); i++)
            {
                tempID = plist[i].getPatronID();
                if(tempID == patronID)
                {
                    tempStatus = plist[i].getPatronStatus();
                    tempFines = plist[i].getFines();
                    if(tempFines == 0.00)
                    {
                        if(tempStatus == "IN")
                        {
                            plist.erase(plist.begin()+(i));
                            cout << "Member has been REMOVED from the Library Database." << endl;
                            return;
                        }
                        else
                        {
                            cout << "WARNING: Unable to remove member from the Library Database due to having a book Checked-Out" << endl;
                            return;
                        }
                    }
                    else
                    {
                        cout << "WARNING: Cannot remove member from the Library Database due to having an unpaid fine of: $" << tempFines << endl;
                        return;
                    }
                }
            }
            if(i == plist.size())
            {
                cout << "This member does not exist within the Library Database." << endl;
                return;
            }

        }
        else
        {
            cout << "Invalid Input." << endl;
            return;
        }
    }
    return;
}

void Patron::editPatron(vector<Patron>& plist)
{
    int i;
    int tempID;
    double tempFines;
    int patronID;
    int selection;
    string editedString;
    int editedInt;

    if(plist.empty())
    {
        cout << "There are no members to edit!" << endl;
    }
    else
    {
        cout << "Enter member's unique 6 digit ID number (not starting with 0): ";
        cin >> patronID;

        if((patronID < 1000000) && (patronID > 99999))
        {
            for(i = 0; i < plist.size(); i++)
            {
                tempID = plist[i].getPatronID();
                if(tempID == patronID)
                {
                    do
                    {
                        cout << "\nWhat information would you like to edit?(enter the numerical value corresponding to the info)" << endl;
                        cout << "1. Name: " << plist[i].name << "\n2. Password: " << plist[i].password << "\n3. Street Address: " << plist[i].StAddress << "\n4. City: " << plist[i].city;
                        cout << "\n5. State: " << plist[i].state << "\n6. Zip: " << plist[i].zip << "\n7. Phone Number: " << plist[i].phone << "\n8. Email Address: " << plist[i].email;
                        cout << "\n9. Exit" << endl;
                        cout << "Enter your numerical selection: ";
                        cin >> selection;
                        //clear cin errors
                        cin.clear();
                        cin.ignore(10000, '\n');
                        //return to input
                        switch(selection)
                        {
                            case 1:
                                cout << "\nNew Name: ";
                                getline(cin, editedString);
                                plist[i].name = editedString;
                                cout << "Name EDITED!" << endl;
                                break;
                            case 2:
                                cout << "\nNew Password: ";
                                cin >> editedString;
                                plist[i].password = editedString;
                                cout << "Password EDITED!" << endl;
                                break;
                            case 3:
                                cout << "\nNew Street Address: ";
                                getline(cin, editedString);
                                plist[i].StAddress = editedString;
                                cout << "Street Address EDITED!" << endl;
                                break;
                            case 4:
                                cout << "\nNew City: ";
                                getline(cin, editedString);
                                plist[i].city = editedString;
                                cout << "City EDITED!" << endl;
                                break;
                            case 5:
                                cout << "\nNew State: ";
                                cin >> editedString;
                                plist[i].state = editedString;
                                cout << "State EDITED!" << endl;
                                break;
                            case 6:
                                cout << "\nNew Zip: ";
                                cin >> editedString;
                                plist[i].zip = editedString;
                                cout << "Zip EDITED!" << endl;
                                break;
                            case 7:
                                cout << "\nNew Phone Number: ";
                                getline(cin, editedString);
                                plist[i].phone = editedString;
                                cout << "Phone Number EDITED!" << endl;
                                break;
                            case 8:
                                cout << "\nNew Email Address: ";
                                cin >> editedString;
                                plist[i].email = editedString;
                                cout << "Email Address EDITED!" << endl;
                                break;
                        }
                    }while(selection != 9);
                    return;
                }
            }
            if(i == plist.size())
            {
                cout << "This member does not exist within the Library Database." << endl;
                return;
            }

        }
        else
        {
            cout << "Invalid Input." << endl;
            return;
        }
    }
    return;
}

void Patron::editFines(int patronID, double newFine, vector<Patron>& plist)
{
    int tempPatronID;

    for(int i = 0; i < plist.size(); i++)
    {
        tempPatronID = plist[i].getPatronID();
        if(tempPatronID == patronID)
        {
            plist[i].fines = newFine;
            return;
        }
    }
    return;
}

void Patron::printPatron(vector<Patron>& plist)
{
    int i;

    cout << "Here is a list of all the Members and their info currently within the Library Database: " << endl;
    for(i = 0; i < plist.size(); i++)
    {
        cout << "\nName: " << plist[i].name << "\nMember ID: " << plist[i].patronID << "\nPassword: " << plist[i].password << "\nStreet Address: " << plist[i].StAddress << "\nCity: " << plist[i].city;
        cout << "\nState: " << plist[i].state << "\nZip: " << plist[i].zip << "\nPhone Number: " << plist[i].phone << "\nEmail Address: " << plist[i].email;
        cout << "\nFines: $" << plist[i].fines << endl;
        cout << endl;
    }
    cout << "END OF LIST" << endl;
    return;
}

void Patron::printAddress(vector<Patron>& plist)
{
    int i;
    int tempPatronID, patronID;

    cout << "To print a member's Address - " << endl;
    cout << "Enter member's unique 6 digit ID number (not starting with 0): ";
    cin >> patronID;
    cout << endl;

    if((patronID < 1000000) && (patronID > 99999))
    {
        cout << "This member's Address: " << endl;
        for(i = 0; i < plist.size(); i++)
        {
            tempPatronID = plist[i].getPatronID();
            if(patronID == tempPatronID)
            {
                //printed in address label form
                cout << plist[i].name << endl;
                cout << plist[i].StAddress << endl;
                cout << plist[i].city << ", " << plist[i].state << endl;
                cout << plist[i].zip << endl;
                cout << endl;
                return;
            }
        }
    }
    else
    {
        cout << "Invalid Input." << endl;
        return;
    }
    return;
}

bool members(const Patron &lhs, const Patron &rhs) { return lhs.name < rhs.name; }

void Patron::sortPatrons(vector<Patron>& plist)
{
    sort(plist.begin(), plist.end(), members);
    cout << "The Members List has been SORTED alphabetically by First Name." << endl;
    return;
}

void Patron::printSingleMember(vector<Patron>& plist)
{
    int i;
    int tempPatronID, patronID;

    cout << "To print a member's Info -" << endl;
    cout << "Enter member's unique 6 digit ID number (not starting with 0): ";
    cin >> patronID;
    cout << endl;

    if((patronID < 1000000) && (patronID > 99999))
    {
        cout << "This member's Info: " << endl;
        for(i = 0; i < plist.size(); i++)
        {
            tempPatronID = plist[i].getPatronID();
            if(patronID == tempPatronID)
            {
                cout << "\nName: " << plist[i].name << "\nMember ID: " << plist[i].patronID << "\nPassword: " << plist[i].password << "\nStreet Address: " << plist[i].StAddress << "\nCity: " << plist[i].city;
                cout << "\nState: " << plist[i].state << "\nZip: " << plist[i].zip << "\nPhone Number: " << plist[i].phone << "\nEmail Address: " << plist[i].email;
                cout << "\nFines: $" << plist[i].fines << "\nLibraryID: " << plist[i].libraryID << endl;
                cout << endl;
                return;
            }
        }
        if(i == plist.size())
        {
            cout << "This member does not exist within the Library Database." << endl;
            return;
        }
    }
    else
    {
        cout << "Invalid Input." << endl;
        return;
    }
    return;
}

void Patron::savePatrons(vector<Patron>& plist)
{
    ofstream outfilePatrons;
    outfilePatrons.open("LibraryDatabasePATRONS.txt");

    if ( !outfilePatrons.is_open() )
    {
        cout << "ERROR: Unable to open Library Database PATRONS File." << endl;
        return;
    }
    else
    {
        for(int i = 0; i < plist.size(); i++)
        {
            outfilePatrons << plist[i].name << ' ' << plist[i].patronID << ' ' << plist[i].password << ' ' << plist[i].StAddress << ' ' << plist[i].city << ' '
            << plist[i].state << ' ' << plist[i].zip << ' ' << plist[i].phone << ' ' << plist[i].email << ' ' << plist[i].fines << ' ' << plist[i].libraryID << ' ' << plist[i].patronStatus << endl;
        }
    }
    outfilePatrons.close();
    cout << "Patrons Database SAVED." << endl;
    return;
}

string Patron::loadPatrons(vector<Patron>& plist)
{
    string newName, newPassword, newStAddress, newCity, newState, newZip, newEmail, newPhone, newPatronStatus;
    int newPatronID, newLibraryID;
    double newFines;

    ifstream infilePatrons;
    infilePatrons.open("LibraryDatabasePATRONS.txt");

    if ( !infilePatrons.is_open() )
    {
        cout << "ERROR: Unable to open Library Database PATRONS File." << endl;
        return "FAIL";
    }
    else
    {
        while(infilePatrons >> newName >> newPatronID >> newPassword >> newStAddress >> newCity >> newState >> newZip >> newPhone >> newEmail >> newFines >> newLibraryID >> newPatronStatus)
        {
            Patron newPatron(newName, newPatronID, newPassword, newStAddress, newCity, newState, newZip, newPhone, newEmail, newFines, newLibraryID, newPatronStatus);
            plist.push_back(newPatron);
        }
    }
    infilePatrons.close();
    cout << "Patron Database LOADED." << endl;
    return "SUCCESS";
}

void Patron::payFines(vector<Patron>& plist)
{
    Patron temppatron;
    char choice;
    double newFine, tempFine, payAmount;
    int tempPatronID, patronID;
    int i;

    cout << "To pay a member's Fines - ";
    cout << "Enter member's unique 6 digit ID number (not starting with 0): ";
    cin >> patronID;
    cout << endl;

    if((patronID < 1000000) && (patronID > 99999))
    {
        cout << "This member's Info: " << endl;
        for(i = 0; i < plist.size(); i++)
        {
            tempPatronID = plist[i].getPatronID();
            if(patronID == tempPatronID)
            {
                tempFine = plist[i].getFines();
                cout << "This member currently has a fine of: $" << tempFine << endl;
                cout << "Would you like to pay it off now? (y/n)" << endl;
                cout << "Enter your choice: ";
                cin >> choice;

                if(choice == 'y')
                {
                    cout << "Excellent! How much would you like to pay off?" << endl;
                    cout << "Amount: ";
                    cin >> payAmount;
                    newFine = tempFine - payAmount;
                    temppatron.editFines(patronID, newFine, plist);

                    cout << "Your current fine is now: $" << newFine << endl;
                }
                else if(choice == 'n')
                {
                    cout << "Very well. NOTE: This member will NOT be able to check out any future items from this Library until their fine has been paid off." << endl;
                    return;
                }
            }
        }
        if(i == plist.size())
        {
            cout << "This member does not exist within the Library Database." << endl;
            return;
        }
    }
    else
    {
        cout << "Invalid Input." << endl;
        return;
    }
    return;
}

void Patron::updateStatus(int patronID, string editedStatus, vector<Patron>& plist)
{
    int tempPatronID;

    for(int i = 0; i < plist.size(); i++)
    {
        tempPatronID = plist[i].getPatronID();
        if(tempPatronID == patronID)
        {
            plist[i].patronStatus = editedStatus;
            return;
        }
    }
    return;
}



/// Book Functions
LibraryItem::LibraryItem(){
    int itemID = 0;
    int libraryID = 0;
}

//Overloaded Constructor
LibraryItem::LibraryItem(int newItemID, string newTitle, string newAuthor, string newGenre, int newLibraryID, string newStatus, string newItemType){
    itemID = newItemID;
    title = newTitle;
    author = newAuthor;
    genre = newGenre;
    status = newStatus;
    libraryID = newLibraryID;
    itemType = newItemType;
}

//get variable functions
int LibraryItem::getItemID() const{
    return itemID;
}

string LibraryItem::getStatus() const{
    return status;
}

string LibraryItem::getItemType() const{
    return itemType;
}

//Main Book Functions
void LibraryItem::addItem(vector<Library>& library, vector<LibraryItem*>& blist, string newItemType)
{
    int temp;
    string newTitle, newAuthor, newGenre, newStatus, newVolume, newNarrator, newRuntime;
    int newItemID, newLibraryID;

    if(blist.empty())
    {
        cout << "\nEnter the following information for the new library item:" << endl;
        cout << "Enter item's unique 4 digit ID number (not starting with 0): ";
        cin >> newItemID;

        if((newItemID < 10000) && (newItemID > 999))
        {
            //clear cin errors
            cin.clear();
            cin.ignore(10000, '\n');
            //return to input
            cout << "\nEnter " << newItemType << "'s Title: ";
            getline(cin, newTitle);

            if(newItemType == "DVD")
            {
                cout << "\nEnter " << newItemType << "'s Director: ";
                getline(cin, newAuthor);
            }
            else
            {
                cout << "\nEnter " << newItemType << "'s Author: ";
                getline(cin, newAuthor);
            }

            cout << "\nEnter " << newItemType << "'s Genre: ";
            getline(cin, newGenre);

            newStatus = "IN";
            newLibraryID = library[0].getLibID();

            if(newItemType == "Reference")
            {
                cout << "\nEnter " << newItemType << "'s Volume Number: ";
                cin >> newVolume;

                blist.push_back(new Reference(newItemID, newTitle, newAuthor, newGenre, newLibraryID, newStatus, newItemType, newVolume));
            }
            else if(newItemType == "DVD")
            {
                cout << "\nEnter " << newItemType << "'s Run-time in Minutes(number): ";
                cin >> newRuntime;

                blist.push_back(new DVD(newItemID, newTitle, newAuthor, newGenre, newLibraryID, newStatus, newItemType, newRuntime));
            }
            else if(newItemType == "Tape")
            {
                cout << "\nEnter " << newItemType << "'s Narrator: ";
                getline(cin, newNarrator);

                blist.push_back(new Tape(newItemID, newTitle, newAuthor, newGenre, newLibraryID, newStatus, newItemType, newNarrator));
            }
            else
            {
                blist.push_back(new Book(newItemID, newTitle, newAuthor, newGenre, newLibraryID, newStatus, newItemType));
            }
            cout << endl;
            return;
        }
        else
        {
            cout << "Invalid Input." << endl;
            return;
        }
    }
    else
    {
        cout << "\nEnter the following information for the new library item:" << endl;
        cout << "Enter item's unique 4 digit ID number (not starting with 0): ";
        cin >> newItemID;

        if((newItemID < 10000) && (newItemID > 999))
        {
            for(int i = 0; i < blist.size(); i++)
            {
                temp = blist[i]->getItemID();
                if(temp == newItemID)
                {
                    cout << "This item has already been added to the Library Database." << endl;
                    return;
                }
                else
                {
                    //clear cin errors
                    cin.clear();
                    cin.ignore(10000, '\n');
                    //return to input
                    cout << "\nEnter" << newItemType << "'s Title: ";
                    getline(cin, newTitle);

                    if(newItemType == "DVD")
                    {
                        cout << "\nEnter " << newItemType << "'s Director: ";
                        getline(cin, newAuthor);
                    }
                    else
                    {
                        cout << "\nEnter " << newItemType << "'s Author: ";
                        getline(cin, newAuthor);
                    }

                    cout << "\nEnter " << newItemType << "'s Genre: ";
                    getline(cin, newGenre);

                    newStatus = "IN";
                    newLibraryID = library[0].getLibID();

                    if(newItemType == "Reference")
                    {
                        cout << "\nEnter " << newItemType << "'s Volume Number: ";
                        cin >> newVolume;

                        blist.push_back(new Reference(newItemID, newTitle, newAuthor, newGenre, newLibraryID, newStatus, newItemType, newVolume));
                    }
                    else if(newItemType == "DVD")
                    {
                        cout << "\nEnter " << newItemType << "'s Run-time in Minutes: ";
                        cin >> newRuntime;

                        blist.push_back(new DVD(newItemID, newTitle, newAuthor, newGenre, newLibraryID, newStatus, newItemType, newRuntime));
                    }
                    else if(newItemType == "Tape")
                    {
                        cout << "\nEnter " << newItemType << "'s Narrator: ";
                        getline(cin, newNarrator);

                        blist.push_back(new Tape(newItemID, newTitle, newAuthor, newGenre, newLibraryID, newStatus, newItemType, newNarrator));
                    }
                    else
                    {
                        blist.push_back(new Book(newItemID, newTitle, newAuthor, newGenre, newLibraryID, newStatus, newItemType));
                    }
                    cout << endl;
                    return;
                }
            }

        }
        else
        {
            cout << "Invalid Input." << endl;
            return;
        }
    }
    return;

}

void LibraryItem::deleteItem(vector<LibraryItem*>& blist)
{
    int i;
    int tempID;
    int itemID;
    string tempStatus;
    char answer;

    if(blist.empty())
    {
        cout << "There are no items to delete!" << endl;
    }
    else
    {
        cout << "Enter item's unique 4 digit ID number (not starting with 0): ";
        cin >> itemID;

        if((itemID < 10000) && (itemID > 999))
        {
            for(i = 0; i < blist.size(); i++)
            {
                tempID = blist[i]->getItemID();
                if(tempID == itemID)
                {
                    tempStatus = blist[i]->getStatus();
                    if(tempStatus == "IN")
                    {
                        blist.erase(blist.begin()+(i));
                        cout << "Item has been REMOVED from the Library Database." << endl;
                        return;
                    }
                    else if(tempStatus == "OUT")
                    {
                        cout << "WARNING: Cannot remove book from the Library Database due to being checked-OUT." << endl;
                        return;
                    }
                    else if(tempStatus == "LOST")
                    {
                        cout << "WARNING: This item has been marked as LOST. Do you still want to remove it from the Library Database? (y/n)" << endl;
                        cin >> answer;
                        if((answer == 'y'))
                        {
                            blist.erase(blist.begin()+(i));
                            cout << "Item has been REMOVED from the Library Database." << endl;
                            return;
                        }
                        else if((answer == 'n'))
                        {
                            cout << "Item was NOT REMOVED from the Library Database." << endl;
                            return;
                        }
                    }
                }
            }
            if(i == blist.size())
            {
                cout << "This item does not exist within the Library Database." << endl;
                return;
            }

        }
        else
        {
            cout << "Invalid Input." << endl;
            return;
        }
    }
    return;
}

void LibraryItem::editItem(vector<LibraryItem*>& blist)
{
    Reference refer;
    DVD dvd;
    Tape tape;
    int i;
    int tempID;
    string tempStatus, tempProtected;
    int itemID;
    int selection;
    string editedString;
    int editedInt;

    if(blist.empty())
    {
        cout << "There are no items to edit!" << endl;
    }
    else
    {
        cout << "Enter item's unique 4 digit ID number (not starting with 0): ";
        cin >> itemID;

        if((itemID < 10000) && (itemID > 999))
        {
            for(i = 0; i < blist.size(); i++)
            {
                tempID = blist[i]->getItemID();
                if(tempID == itemID)
                {
                    do
                    {
                        tempProtected = blist[i]->getProtected();
                        cout << "\nWhat information would you like to edit?(enter the numerical value corresponding to the info)" << endl;
                        cout << "<<" << blist[i]->itemType << ">>";
                        cout << "1. Title: " << blist[i]->title << "\n2. Author: " << blist[i]->author << "\n3. Genre: " << blist[i]->genre << "\n4. Status: " << blist[i]->status;

                        if(blist[i]->itemType == "Reference")
                        {
                            cout << "\n5. Volume: " << tempProtected;
                            cout << "\n6. Exit" << endl;
                        }
                        else if(blist[i]->itemType == "DVD")
                        {
                            cout << "\n5. Run-Time: " << tempProtected << " min.";
                            cout << "\n6. Exit" << endl;
                        }
                        else if(blist[i]->itemType == "Tape")
                        {
                            cout << "\n5. Narrator: " << tempProtected;
                            cout << "\n6. Exit" << endl;
                        }
                        else
                        {
                            cout << "\n5. Exit" << endl;
                        }

                        cout << "Enter your numerical selection: ";
                        cin >> selection;
                        //clear cin errors
                        cin.clear();
                        cin.ignore(10000, '\n');
                        //return to input
                        switch(selection)
                        {
                            case 1:
                                cout << "\nNew Title: ";
                                getline(cin, editedString);
                                blist[i]->title = editedString;
                                cout << "Title EDITED!" << endl;
                                break;
                            case 2:
                                if(blist[i]->itemType == "DVD")
                                {
                                    cout << "\nNew Director: ";
                                    cin >> editedString;
                                    blist[i]->author = editedString;
                                    cout << "Director EDITED!" << endl;
                                }
                                else
                                {
                                    cout << "\nNew Author: ";
                                    cin >> editedString;
                                    blist[i]->author = editedString;
                                    cout << "Author EDITED!" << endl;
                                }
                                break;
                            case 3:
                                cout << "\nNew Genre: ";
                                getline(cin, editedString);
                                blist[i]->genre = editedString;
                                cout << "Genre EDITED!" << endl;
                                break;
                            case 4:
                                cout << "\nNew Status: ";
                                getline(cin, editedString);
                                blist[i]->status = editedString;
                                cout << "Status EDITED!" << endl;
                                break;
                            case 5:
                                if(blist[i]->itemType == "Reference")
                                {
                                    cout << "\nNew Volume: ";
                                    cin >> editedString;
                                    blist[i]->setProtected(editedString);
                                    cout << "Volume EDITED!" << endl;
                                }
                                else if(blist[i]->itemType == "DVD")
                                {
                                    cout << "\nNew Run-Time: ";
                                    cin >> editedString;
                                    blist[i]->setProtected(editedString);
                                    cout << "Run-time EDITED!" << endl;
                                }
                                else if(blist[i]->itemType == "Tape")
                                {
                                    cout << "\nNew Narrator: ";
                                    getline(cin, editedString);
                                    blist[i]->setProtected(editedString);
                                    cout << "Narrator EDITED!" << endl;
                                }
                                else
                                {
                                    selection = 6;
                                }
                        }
                    }while(selection != 6);
                    return;
                }
            }
            if(i == blist.size())
            {
                cout << "This item does not exist within the Library Database." << endl;
                return;
            }

        }
        else
        {
            cout << "Invalid Input." << endl;
            return;
        }
    }
    return;
}

bool items(const LibraryItem* lhs, const LibraryItem* rhs) { return lhs->author < rhs->author; }

void LibraryItem::sortItems(vector<LibraryItem*>& blist)
{
    sort(blist.begin(), blist.end(), items);
    cout << "The Library Item Catalog has been SORTED alphabetically by Author." << endl;
    return;
}

void LibraryItem::printItem(vector<LibraryItem*>& blist)
{
    int i;
    int tempItemID, itemID;
    string newStatus;

    cout << "To Print the Info of a specific item - " << endl;
    cout << "Enter item's unique 4 digit ID number (not starting with 0): ";
    cin >> tempItemID;

    if((tempItemID < 10000) && (tempItemID > 999))
    {
        for(i = 0; i < blist.size(); i++)
        {
            itemID = blist[i]->getItemID();
            if(tempItemID == itemID)
            {
                if(blist[i]->itemType == "Book")
                {
                    cout << blist[i]->itemType;
                    cout << "\nItem ID:" << blist[i]->itemID << "\nTitle: " << blist[i]->title << "\nAuthor: " << blist[i]->author << "\nGenre: " << blist[i]->genre << "\nStatus: " << blist[i]->status << endl;
                    cout << endl;
                    return;
                }
                else if(blist[i]->itemType == "Reference")
                {
                    cout << blist[i]->itemType;
                    cout << "\nItem ID:" << blist[i]->itemID << "\nTitle: " << blist[i]->title << "\nAuthor: " << blist[i]->author << "\nGenre: " << blist[i]->genre << "\nStatus: " << blist[i]->status;
                    blist[i]->printInfo();
                    cout << endl;
                    return;
                }
                else if(blist[i]->itemType == "DVD")
                {
                    cout << blist[i]->itemType;
                    cout << "\nItem ID:" << blist[i]->itemID << "\nTitle: " << blist[i]->title << "\nDirector: " << blist[i]->author << "\nGenre: " << blist[i]->genre << "\nStatus: " << blist[i]->status;
                    blist[i]->printInfo();
                    cout << endl;
                    return;
                }
                else if(blist[i]->itemType == "Tape")
                {
                    cout << blist[i]->itemType;
                    cout << "\nItem ID:" << blist[i]->itemID << "\nTitle: " << blist[i]->title << "\nAuthor: " << blist[i]->author << "\nGenre: " << blist[i]->genre << "\nStatus: " << blist[i]->status;
                    blist[i]->printInfo();
                    cout << endl;
                    return;
                }
            }
        }
        if(i == blist.size())
        {
            cout << "This Item does not exist within the Library Database." << endl;
            return;
        }
    }
    else
    {
        cout << "Invalid Input." << endl;
        return;
    }
}

void LibraryItem::recordLost(vector<LibraryItem*>& blist)
{
    int i;
    int tempItemID, itemID;
    string newStatus;
    LibraryItem tempitem;

    cout << "To record a LOST Item - " << endl;
    cout << "Enter Item's unique 4 digit ID number (not starting with 0): ";
    cin >> tempItemID;

    if((tempItemID < 10000) && (tempItemID > 999))
    {
        for(i = 0; i < blist.size(); i++)
        {
            itemID = blist[i]->getItemID();
            if(tempItemID == itemID)
            {
                newStatus = "LOST";
                tempitem.changeStatus(tempItemID, newStatus, blist);
                cout << "This Item is now marked as LOST." << endl;
                return;
            }
        }
        if(i == blist.size())
        {
            cout << "This Item does not exist within the Library Database." << endl;
            return;
        }
    }
    else
    {
        cout << "Invalid Input." << endl;
        return;
    }
}

void LibraryItem::printCatalog(vector<LibraryItem*>& blist)
{
    int i;

    cout << "Here is the Catalog of all the Books and their info currently within the Library Database: " << endl;
    cout << endl;

    cout << "<<Books>>" << endl;
    cout << endl;
    for(i = 0; i < blist.size(); i++)
    {
        if(blist[i]->itemType == "Book")
        {
            cout << "Item ID:" << blist[i]->itemID << "\nTitle: " << blist[i]->title << "\nAuthor: " << blist[i]->author << "\nGenre: " << blist[i]->genre << "\nStatus: " << blist[i]->status << endl;
            cout << endl;
        }
    }

    cout << "<<Reference Books>>" << endl;
    cout << endl;
    for(i = 0; i < blist.size(); i++)
    {
        if(blist[i]->itemType == "Reference")
        {
            cout << "Item ID:" << blist[i]->itemID << "\nTitle: " << blist[i]->title << "\nAuthor: " << blist[i]->author << "\nGenre: " << blist[i]->genre << "\nStatus: " << blist[i]->status;
            blist[i]->printInfo();
            cout << endl;
        }
    }

    cout << "<<DVDs>>" << endl;
    cout << endl;
    for(i = 0; i < blist.size(); i++)
    {
        if(blist[i]->itemType == "DVD")
        {
            cout << "Item ID:" << blist[i]->itemID << "\nTitle: " << blist[i]->title << "\nDirector: " << blist[i]->author << "\nGenre: " << blist[i]->genre << "\nStatus: " << blist[i]->status;
            blist[i]->printInfo();
            cout << endl;
        }
    }

    cout << "<<Books-On-Tape>>" << endl;
    cout << endl;
    for(i = 0; i < blist.size(); i++)
    {
        if(blist[i]->itemType == "Tape")
        {
            cout << "Item ID:" << blist[i]->itemID << "\nTitle: " << blist[i]->title << "\nAuthor: " << blist[i]->author << "\nGenre: " << blist[i]->genre << "\nStatus: " << blist[i]->status;
            blist[i]->printInfo();
            cout << endl;
        }
    }
    cout << "END OF LIST" << endl;
    return;
}

void LibraryItem::printLost(vector<LibraryItem*>& blist)
{
    int i;
    string tempStatus;

    cout << "Here is a list of all the Items and their info currently marked as LOST: " << endl;
    for(i = 0; i < blist.size(); i++)
    {
        tempStatus = blist[i]->getStatus();
        if(tempStatus == "LOST")
        {
            if(blist[i]->itemType == "Book")
            {
                cout << blist[i]->itemType;
                cout << "\nItem ID:" << blist[i]->itemID << "\nTitle: " << blist[i]->title << "\nAuthor: " << blist[i]->author << "\nGenre: " << blist[i]->genre << "\nStatus: " << blist[i]->status << endl;
                cout << endl;
                return;
            }
            else if(blist[i]->itemType == "Reference")
            {
                cout << blist[i]->itemType;
                cout << "\nItem ID:" << blist[i]->itemID << "\nTitle: " << blist[i]->title << "\nAuthor: " << blist[i]->author << "\nGenre: " << blist[i]->genre << "\nStatus: " << blist[i]->status;
                blist[i]->printInfo();
                cout << endl;
                return;
            }
            else if(blist[i]->itemType == "DVD")
            {
                cout << blist[i]->itemType;
                cout << "\nItem ID:" << blist[i]->itemID << "\nTitle: " << blist[i]->title << "\nDirector: " << blist[i]->author << "\nGenre: " << blist[i]->genre << "\nStatus: " << blist[i]->status;
                blist[i]->printInfo();
                cout << endl;
                return;
            }
            else if(blist[i]->itemType == "Tape")
            {
                cout << blist[i]->itemType;
                cout << "\nItem ID:" << blist[i]->itemID << "\nTitle: " << blist[i]->title << "\nAuthor: " << blist[i]->author << "\nGenre: " << blist[i]->genre << "\nStatus: " << blist[i]->status;
                blist[i]->printInfo();
                cout << endl;
                return;
            }
        }
    }
    cout << "END OF LIST" << endl;
    return;
}


void LibraryItem::changeStatus(int itemID, string newStatus, vector<LibraryItem*>& blist)
{
    int tempItemID;

    for(int i = 0; i < blist.size(); i++)
    {
        tempItemID = blist[i]->getItemID();
        if(tempItemID == itemID)
        {
            blist[i]->status = newStatus;
            return;
        }
    }
    return;
}

void LibraryItem::saveItems(vector<LibraryItem*>& blist)
{
    string tempType, tempProtected;

    ofstream outfileItems;
    outfileItems.open("LibraryDatabaseITEMS.txt");

    if ( !outfileItems.is_open() )
    {
        cout << "ERROR: Unable to open Library Database ITEMS File." << endl;
        return;
    }
    else
    {
        for(int i = 0; i < blist.size(); i++)
        {
            tempType = blist[i]->getItemType();

            if(tempType == "Book")
            {
                outfileItems << blist[i]->itemID << ' ' << blist[i]->title << ' ' << blist[i]->author << ' ' << blist[i]->genre << ' ' << blist[i]->libraryID << ' ' << blist[i]->status << ' ' << blist[i]->itemType << endl;
            }
            else if(tempType == "Reference")
            {
                outfileItems << blist[i]->itemID << ' ' << blist[i]->title << ' ' << blist[i]->author << ' ' << blist[i]->genre << ' ' << blist[i]->libraryID << ' ' << blist[i]->status << ' ' << blist[i]->itemType << ' ' << blist[i]->getProtected() << endl;
            }
            else if(tempType == "DVD")
            {
                outfileItems << blist[i]->itemID << ' ' << blist[i]->title << ' ' << blist[i]->author << ' ' << blist[i]->genre << ' ' << blist[i]->libraryID << ' ' << blist[i]->status << ' ' << blist[i]->itemType << ' ' << blist[i]->getProtected() << endl;
            }
            else if(tempType == "Tape")
            {
                outfileItems << blist[i]->itemID << ' ' << blist[i]->title << ' ' << blist[i]->author << ' ' << blist[i]->genre << ' ' << blist[i]->libraryID << ' ' << blist[i]->status << ' ' << blist[i]->itemType << ' ' << blist[i]->getProtected() << endl;
            }
        }
    }
    outfileItems.close();
    cout << "Books Database SAVED." << endl;
    return;
}

string LibraryItem::loadItems(vector<LibraryItem*>& blist)
{
    string newTitle, newAuthor, newGenre, newStatus, newVolume, newNarrator, newItemType, newRuntime;
    int newItemID, newLibraryID;

    ifstream infileItems;
    infileItems.open("LibraryDatabaseITEMS.txt");

    if ( !infileItems.is_open() )
    {
        cout << "ERROR: Unable to open Library Database ITEMS File." << endl;
        return "FAIL";
    }
    else
    {
        while(infileItems >> newItemID >> newTitle >> newAuthor >> newGenre >> newLibraryID >> newStatus >> newItemType)
        {
            if(newItemType == "Reference")
            {
                infileItems >> newVolume;
                blist.push_back(new Reference(newItemID, newTitle, newAuthor, newGenre, newLibraryID, newStatus, newItemType, newVolume));
            }
            else if(newItemType == "DVD")
            {
                infileItems >> newRuntime;
                blist.push_back(new DVD(newItemID, newTitle, newAuthor, newGenre, newLibraryID, newStatus, newItemType, newRuntime));
            }
            else if(newItemType == "Tape")
            {
                infileItems >> newNarrator;
                blist.push_back(new Tape(newItemID, newTitle, newAuthor, newGenre, newLibraryID, newStatus, newItemType, newNarrator));
            }
            else
            {
                blist.push_back(new Book(newItemID, newTitle, newAuthor, newGenre, newLibraryID, newStatus, newItemType));
            }

        }
    }
    infileItems.close();
    cout << "Item Database LOADED." << endl;
    return "SUCCESS";
}

void LibraryItem::recordFound(vector<LibraryItem*>& blist)
{
    int i;
    int tempItemID, itemID;
    string newStatus;
    LibraryItem tempitem;

    cout << "To record a FOUND item - " << endl;
    cout << "Enter item's unique 4 digit ID number (not starting with 0): ";
    cin >> tempItemID;

    if((tempItemID < 10000) && (tempItemID > 999))
    {
        for(i = 0; i < blist.size(); i++)
        {
            itemID = blist[i]->getItemID();
            if(tempItemID == itemID)
            {
                newStatus = "IN";
                tempitem.changeStatus(tempItemID, newStatus, blist);
                cout << "This item is now marked as IN." << endl;
                return;
            }
        }
        if(i == blist.size())
        {
            cout << "This item does not exist within the Library Database." << endl;
            return;
        }
    }
    else
    {
        cout << "Invalid Input." << endl;
        return;
    }
}



/// Loan Functions
Loan::Loan(){
    int patronID = 0;
    int bookID = 0;
}

//Overloaded Constructor
Loan::Loan(int newPatronID, int newBookID, string newDateLoaned, string newDueDate, int newDueDateTime, string newStatus)
{
    patronID = newPatronID;
    itemID = newBookID;
    dateLoaned = newDateLoaned;
    dueDate = newDueDate;
    dueDateTime = newDueDateTime;
    loanStatus = newStatus;
}

//get variable functions
int Loan::getPatronID() const{
    return patronID;
}

int Loan::getItemID() const{
    return itemID;
}

string Loan::getDateLoaned() const{
    return dateLoaned;
}

string Loan::getDueDate() const{
    return dueDate;
}

string Loan::getLoanStatus() const{
    return loanStatus;
}

int Loan::getDueDateTime() const{
    return dueDateTime;
}

//Main Check-Out Functions
void Loan::addLoan(vector<Patron>& plist, vector<LibraryItem*>& blist, vector<Loan>& tlist)
{
    Patron temppatron;
    LibraryItem item;
    Loan tempLoan;
    int i, j;   //counters
    int tempPatron, tempItem;
    string newDateLoaned, newDueDate, newStatus;
    int newPatronID, newItemID, newDueDateTime, timeDue;
    stringstream dateM1, dateM2, dateD1, dateD2, dateY1, dateY2;
    double tempFine, newFine, payAmount;
    string tempStatus, tempType;
    char choice;

    tempLoan.calculateOverdue(plist, blist, tlist);

    cout << "\nEnter the following information for Checking Out an item:" << endl;

    cout << "Enter member's unique 6 digit ID number (not starting with 0): ";
    cin >> newPatronID;
    cout << endl;

    if((newPatronID < 1000000) && (newPatronID > 99999))
    {

        for(i = 0; i < plist.size(); i++)
        {
            tempPatron = plist[i].getPatronID();
            if(tempPatron == newPatronID)
            {
                tempFine = plist[i].getFines();
                if(tempFine == 0)
                {
                    cout << "Enter item's unique 4 digit ID number (not starting with 0): ";
                    cin >> newItemID;

                    if((newItemID < 10000) && (newItemID > 999))
                    {
                        for(j = 0; j < blist.size(); j++)
                        {
                            tempItem = blist[j]->getItemID();
                            if(tempItem == newItemID)
                            {
                                tempStatus = blist[j]->getStatus();
                                if(tempStatus == "IN")
                                {
                                    //clear cin errors
                                    cin.clear();
                                    cin.ignore(10000, '\n');
                                    //return to input
                                    tempType = blist[j]->getItemType();
                                    if(tempType == "Reference")
                                    {
                                        cout << "You are NOT ALLOWED to Check-Out a REFERENCE Book." << endl;
                                        cout << endl;
                                        return;
                                    }
                                    else if(tempType == "DVD")
                                    {
                                        timeDue = 2;
                                    }
                                    else if(tempType == "Tape")
                                    {
                                        timeDue = 7;
                                    }
                                    else if(tempType == "Book")
                                    {
                                        timeDue = 14;
                                    }

                                    time_t date = time(0);   // get time now
                                    struct tm * timeNow = localtime( & date );

                                    cout << "\nThis member is allowed to check out this book for " << timeDue << " days." << endl;
                                    cout << "\nThis book is being checked out today: ";
                                    cout << (timeNow->tm_mon + 1) << '/' << (timeNow->tm_mday) << '/' << (timeNow->tm_year + 1900) << endl;

                                    dateM1 << (timeNow->tm_mon + 1); dateD1 << (timeNow->tm_mday); dateY1 << (timeNow->tm_year + 1900);
                                    newDateLoaned = dateM1.str() + '/' + dateD1.str() + '/' + dateY1.str();

                                    cout << "\nThis book will be DUE: ";
                                    timeNow->tm_mday += timeDue;
                                    mktime(timeNow);
                                    cout << (timeNow->tm_mon + 1) << '/' << (timeNow->tm_mday) << '/' <<(timeNow->tm_year + 1900) << endl;

                                    newDueDateTime = timeNow->tm_yday;
                                    dateM2 << (timeNow->tm_mon + 1); dateD2 << (timeNow->tm_mday); dateY2 << (timeNow->tm_year + 1900);
                                    newDueDate = dateM2.str() + '/' + dateD2.str() + '/' + dateY2.str();

                                    newStatus = "OUT";

                                    Loan newLoan(newPatronID, newItemID, newDateLoaned, newDueDate, newDueDateTime, newStatus);
                                    tlist.push_back(newLoan);

                                    temppatron.updateStatus(newPatronID, newStatus, plist);
                                    item.changeStatus(newItemID, newStatus, blist);
                                    cout << endl;
                                    return;
                                }
                                else if(tempStatus == "OUT")
                                {
                                    cout << "\nWARNING: Cannot check out another Item to this member due to it already being CHECKED OUT." << endl;
                                    return;
                                }
                                else if(tempStatus == "LOST")
                                {
                                    cout << "\nWARNING: Cannot check out another Item to this member due to it being LOST." << endl;
                                    return;
                                }
                            }
                            else if(j == blist.size())
                            {
                                cout << "\nThis Item does not exist in the Library Database." << endl;
                                return;
                            }
                        }
                    }
                    else
                    {
                        cout << "\nInvalid Input." << endl;
                        return;
                    }
                }
                else
                {
                    cout << "\nWARNING: Cannot check out another Item to this member due to an unpaid overdue fine." << endl;
                    cout << "This member currently owes: $" << tempFine << endl;
                    cout << "Would you like to pay it off now? (y/n)" << endl;
                    cout << "choice: ";
                    cin >> choice;

                    if(choice == 'y')
                    {
                        cout << "Excellent! How much would you like to pay off?" << endl;
                        cout << "Amount: ";
                        cin >> payAmount;
                        newFine = tempFine - payAmount;
                        temppatron.editFines(tempPatron, newFine, plist);

                        cout << "Your current fine is now: $" << newFine << endl;
                    }
                    else if(choice == 'n')
                    {
                        cout << "Very well. NOTE: This member will NOT be able to check out any future items from this Library until their fine has been paid off." << endl;
                    }
                    return;
                }
            }
            else if(i == plist.size())
            {
                cout << "\nThis member does not exist in the Library Database." << endl;
                return;
            }
        }
    }
    else
    {
        cout << "\nInvalid Input." << endl;
        return;
    }

    return;
}

void Loan::returnLoan(vector<Patron>& plist, vector<LibraryItem*>& blist, vector<Loan>& tlist)
{
    int i, j;   //counters
    int PatronID, ItemID;
    string newDateLoaned, newDueDate, tempLoanStatus, newStatus;
    int tempPatronID, tempItemID;
    double tempFine, newFine, payAmount;
    Loan tempLoan;
    LibraryItem item;
    Patron temppatron;
    char choice;

    tempLoan.calculateOverdue(plist, blist, tlist);

    if(tlist.empty())
    {
        cout << "There is nothing to delete!" << endl;
        return;
    }
    else
    {
        cout << "\nEnter the following information for Checking Out an Item:" << endl;

        cout << "Enter member's unique 6 digit ID number (not starting with 0): ";
        cin >> tempPatronID;
        cout << endl;

        if((tempPatronID < 1000000) && (tempPatronID > 99999))
        {
            cout << "Enter Item's unique 4 digit ID number (not starting with 0): ";
            cin >> tempItemID;

            if((tempItemID < 10000) && (tempItemID > 999))
            {
                for(i = 0; i < tlist.size(); i++)
                {
                    PatronID = tlist[i].getPatronID();
                    ItemID = tlist[i].getItemID();
                    if((PatronID == tempPatronID)&&(ItemID == tempItemID))
                    {
                        tempLoanStatus = tlist[i].getLoanStatus();
                        if(tempLoanStatus == "OUT")
                        {
                            tlist.erase(tlist.begin()+(i));
                            newStatus = "IN";
                            item.changeStatus(tempItemID, newStatus, blist);
                            temppatron.updateStatus(tempPatronID, newStatus, plist);
                            cout << "This Item has been RETURNED to the Library." << endl;
                            return;
                        }
                        else if(tempLoanStatus == "OVERDUE")
                        {
                            cout << "WARNING: This member needs to pay their OVERDUE FINE for returning this Item LATE." << endl;
                            for(j = 0; j < plist.size(); j++)
                            {
                                PatronID = plist[i].getPatronID();
                                if(PatronID == tempPatronID)
                                {
                                    tempFine = plist[i].getFines();
                                    cout << "This member currently owes: $" << tempFine << endl;
                                    cout << "Would you like to pay it off now? (y/n)" << endl;
                                    cout << "choice: ";
                                    cin >> choice;

                                    if(choice == 'y')
                                    {
                                        cout << "Excellent! How much would you like to pay off?" << endl;
                                        cout << "Amount: ";
                                        cin >> payAmount;
                                        newFine = tempFine - payAmount;
                                        temppatron.editFines(tempPatronID, newFine, plist);

                                        cout << "Your current fine is now: $" << newFine << endl;
                                    }
                                    else if(choice == 'n')
                                    {
                                        cout << "Very well. NOTE: This member will NOT be able to check out any future items from this Library until their fine has been paid off." << endl;
                                    }

                                    tlist.erase(tlist.begin()+(i));
                                    newStatus = "IN";
                                    item.changeStatus(tempItemID, newStatus, blist);
                                    temppatron.updateStatus(tempPatronID, newStatus, plist);
                                    cout << "This Item has been RETURNED to the Library." << endl;
                                    return;
                                }
                            }
                        }
                    }
                }
                if(i == tlist.size())
                {
                    cout << "This member is not checking out this Item." << endl;
                    return;
                }
            }
            else
            {
                cout << "Invalid Input." << endl;
                return;
            }
        }
        else
        {
            cout << "Invalid Input." << endl;
            return;
        }
    }
}

void Loan::printOut(vector<Loan>& tlist)
{
    int i;
    string tempStatus;

    cout << "Here is a list of all the Books currently marked as OUT(OVERDUE is also considered OUT since it has not been returned yet.) and the member who have them checked OUT: " << endl;
    for(i = 0; i < tlist.size(); i++)
    {
        tempStatus = tlist[i].getLoanStatus();
        if((tempStatus == "OUT")||(tempStatus == "OVERDUE"))
        {
            cout << "\nPatron ID: " << tlist[i].patronID << "\nBook ID: " << tlist[i].itemID;
            cout << "\nDay Checked-Out: " << tlist[i].dateLoaned << "\nDue Date: " << tlist[i].dueDate;
            cout << "\nStatus: " << tlist[i].loanStatus << endl;
            cout << endl;
        }
    }
    cout << "END OF LIST" << endl;
    return;
}

void Loan::calculateOverdue(vector<Patron>& plist, vector<LibraryItem*>& blist, vector<Loan>& tlist)
{
    int tempDueDate, today, daysOver;
    string newStatus, tempType;
    double newFine;
    int tempPatronID, tempItemID, itemID;
    LibraryItem item;
    Patron temppatron;
    Loan temploan;

    time_t date = time(0);   // get time now
    struct tm * timeNow = localtime( & date );
    today = timeNow->tm_yday;


    for(int i = 0; i < tlist.size(); i++)
    {
        tempDueDate = tlist[i].getDueDateTime();
        if(today < tempDueDate)
        {
            break;
        }
        else if(today > tempDueDate)
        {
            tempItemID = tlist[i].getItemID();
            for(int j = 0; j < blist.size(); j++)
            {
                itemID = blist[j]->getItemID();
                if(tempItemID == itemID)
                {
                    tempType = blist[j]->getStatus();
                    tempPatronID = tlist[i].getPatronID();
                    newStatus = "OVERDUE";
                    daysOver = today - tempDueDate;

                    if(tempType == "DVD")
                    {
                        newFine = (daysOver*2);     //$2.00/day Fine
                    }
                    else if(tempType == "Tape")
                    {
                        newFine = (daysOver*0.5);   //$0.50/day Fine
                    }
                    else if(tempType == "Book")
                    {
                        newFine = (daysOver*0.25);  //$0.25/day Fine
                    }

                    temploan.editStatus(tempPatronID, tempItemID, newStatus, tlist);
                    item.changeStatus(tempItemID, newStatus, blist);
                    temppatron.editFines(tempPatronID, newFine, plist);
                }
            }
        }
    }
    cout << "All OVERDUE books have been calculated." << endl;
    return;
}

void Loan::printOverdue(vector<Loan>& tlist)
{
    int i;
    string tempStatus;

    cout << "Here is a list of all the Books currently marked as OUT(OVERDUE is also considered OUT since it has not been returned yet.) and the member who have them checked OUT: " << endl;
    for(i = 0; i < tlist.size(); i++)
    {
        tempStatus = tlist[i].getLoanStatus();
        if(tempStatus == "OVERDUE")
        {
            cout << "\nPatron ID: " << tlist[i].patronID << "\nBook ID: " << tlist[i].itemID;
            cout << "\nDay Checked-Out: " << tlist[i].dateLoaned << "\nDue Date: " << tlist[i].dueDate;
            cout << "\nStatus: " << tlist[i].loanStatus << endl;
            cout << endl;
        }
    }
    cout << "END OF LIST" << endl;
    return;
}

void Loan::printFined(vector<Patron>& plist, vector<LibraryItem*>& blist, vector<Loan>& tlist)
{
    int i;
    double tempFine;
    Loan temploan;

    temploan.calculateOverdue(plist, blist, tlist);
    cout << "Here is a list of all the Members that currently have fines: " << endl;
    for(i = 0; i < plist.size(); i++)
    {
        tempFine = plist[i].getFines();
        if(tempFine > 0.00)
        {
            cout << "Name: " << plist[i].getName() << "\nMember ID: " << plist[i].getPatronID();
            cout << "\nFine: $" << tempFine << endl;
            cout << "\nPhone Number: " << plist[i].getPhone() << "\nEmail Address: " << plist[i].getEmail() << endl;
            cout << endl;
        }
    }
    cout << "END OF LIST" << endl;
    return;
}

void Loan::printTopFines(vector<Patron>& plist, vector<LibraryItem*>& blist, vector<Loan>& tlist)
{
    int i;
    double tempFine;
    Loan temploan;

    temploan.calculateOverdue(plist, blist, tlist);
    cout << "Here is a list of all the Members that currently have OUTSTANDING fines: " << endl;
    for(i = 0; i < plist.size(); i++)
    {
        tempFine = plist[i].getFines();
        if(tempFine >= 3.50)
        {
            cout << "Name: " << plist[i].getName() << "\nMember ID: " << plist[i].getPatronID();
            cout << "\nFine: $" << tempFine << endl;
            cout << "\nPhone Number: " << plist[i].getPhone() << "\nEmail Address: " << plist[i].getEmail() << endl;
            cout << endl;
        }
    }
    cout << "END OF LIST" << endl;
    return;
}

void Loan::editStatus(int tempItemID, int tempPatronID, string newStatus, vector<Loan>& tlist)
{
    int itemID, patronID;

    for(int i = 0; i < tlist.size(); i++)
    {
        patronID = tlist[i].getPatronID();
        itemID = tlist[i].getItemID();
        if((patronID == tempPatronID)&&(itemID == tempItemID))
        {
            tlist[i].loanStatus = newStatus;
            return;
        }
    }
    return;
}

void Loan::saveLoans(vector<Loan>& tlist)
{
    ofstream outfileLoans;
    outfileLoans.open("LibraryDatabaseLOANS.txt");

    if ( !outfileLoans.is_open() )
    {
        cout << "ERROR: Unable to open Library Database LOANS File." << endl;
        return;
    }
    else
    {
        for(int i = 0; i < tlist.size(); i++)
        {
            outfileLoans << tlist[i].patronID << ' ' << tlist[i].itemID << ' ' << tlist[i].dateLoaned << ' ' << tlist[i].dueDate << ' ' << tlist[i].dueDateTime << ' ' << tlist[i].loanStatus << endl;
        }
    }
    outfileLoans.close();
    cout << "Loans Database SAVED." << endl;
    return;
}

string Loan::loadLoans(vector<Loan>& tlist)
{
    int newPatronID, newBookID, newDueDateTime;
    string newDateLoaned, newDueDate, newStatus;

    ifstream infileLoans;
    infileLoans.open("LibraryDatabaseLOANS.txt");

    if ( !infileLoans.is_open() )
    {
        cout << "ERROR: Unable to open Library Database LOANS File." << endl;
        return "FAIL";
    }
    else
    {
        while(infileLoans >> newPatronID >> newBookID >> newDateLoaned >> newDueDate >> newDueDateTime >> newStatus)
        {
            Loan newLoan(newPatronID, newBookID, newDateLoaned, newDueDate, newDueDateTime, newStatus);
            tlist.push_back(newLoan);
        }
    }
    infileLoans.close();
    cout << "Loans Database LOADED." << endl;
    return "SUCCESS";
}



///File Functions
void SaveFile(vector<Library>& library, vector<Patron>& plist, vector<LibraryItem*>& blist, vector<Loan>& tlist)
{
    Library lib;
    Patron patron;
    LibraryItem item;
    Loan loan;

    lib.saveLibrary(library);
    patron.savePatrons(plist);
    item.saveItems(blist);
    loan.saveLoans(tlist);
    cout << "The Library Database has been SAVED into 4 seperate FILES - ";
    cout << "'LibraryDatabaseLIBRARY.txt' 'LibraryDatabasePATRONS.txt' 'LibraryDatabaseBOOKS.txt' 'LibraryDatabaseLOANS.txt'" << endl;
    return;
}

string LoadFile(vector<Library>& library, vector<Patron>& plist, vector<LibraryItem*>& blist, vector<Loan>& tlist)
{
    Library lib;
    Patron patron;
    LibraryItem item;
    Loan loan;
    string Rlibrary, Rpatrons, Rbooks, Rloans;   //R = Results
    int numofR = 0;

    //count the number of successfully loaded .txt files
    Rlibrary = lib.loadLibrary(library);
    if(Rlibrary == "SUCCESS")
    {
        numofR++;
    }

    Rpatrons = patron.loadPatrons(plist);
    if(Rpatrons == "SUCCESS")
    {
        numofR++;
    }

    Rbooks = item.loadItems(blist);
    if(Rbooks == "SUCCESS")
    {
        numofR++;
    }

    Rloans = loan.loadLoans(tlist);
    if(Rloans == "SUCCESS")
    {
        numofR++;
    }

    //Report Results
    if(numofR == 0)
    {
        cout << "The Library Database was NOT LOADED due to corrupted or non-existent FILES." << endl;
        return "FAIL";
    }
    else
    {
        cout << "The Library Database has been LOADED from " << numofR << " separate FILES" << endl;
        //print the successfully loaded .txt files
        if(Rlibrary == "SUCCESS")
        {
            cout << " - 'LibraryDatabaseLIBRARY.txt'";
        }
        if(Rlibrary == "SUCCESS")
        {
            cout << " - 'LibraryDatabasePATRONS.txt'";
        }
        if(Rlibrary == "SUCCESS")
        {
            cout << " - 'LibraryDatabaseBOOKS.txt'";
        }
        if(Rlibrary == "SUCCESS")
        {
            cout << " - 'LibraryDatabaseLOANS.txt'";
        }

        if(Rlibrary == "SUCCESS")
        {
            cout << endl;
            return "SUCCESS";
        }
        else
        {
            cout << "WARNING: Some FILES were loaded, but the LIBRARY FILE was not." << endl;
            cout << "You need to input new Library Info into the Database System before you can proceed to the rest of the program." << endl;
            cout << endl;
            return "FAIL";
        }
    }
}
