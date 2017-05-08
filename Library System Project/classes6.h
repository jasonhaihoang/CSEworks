// Jason Hoang (jhh0089@my.unt.edu)
// Homework 5 - Library Management Program in C++
// CSCE 1040 - Keathly

//classes
#ifndef CLASSES6_H_INCLUDED
#define CLASSES6_H_INCLUDED

#include<iostream>
#include<string>
#include<vector>
#include<algorithm>
#include<ctime>
#include<string>
#include<fstream>
#include<sstream>

using namespace std;

class Library
{
    private:
        int libID;
        string libName;
        string StAddress;
        string city;
        string state;
        string zip;
        string phone;
        string email;

    public:
        Library();

        Library(string, int, string, string, string, string, string, string);

        int getLibID() const;
        string getLibName() const;
        string getStAddress() const;
        string getCity() const;
        string getState() const;
        string getZip() const;
        string getPhone() const;
        string getEmail() const;

        void setLibID(int);
        void setLibName(string);
        void setStAddress(string);
        void setCity(string);
        void setState(string);
        void setZip(string);
        void setPhone(string);
        void setEmail(string);

        void inputInfo(vector<Library>&);
        void editInfo(vector<Library>&);
        void printInfo(vector<Library>&);
        void saveLibrary(vector<Library>&);
        string loadLibrary(vector<Library>&);

};

class Patron
{
    private:
        int patronID;
        string password;
        string StAddress;
        string city;
        string state;
        string zip;
        string phone;
        string email;
        double fines;
        int libraryID;
        string patronStatus;

    public:
        Patron();

        Patron(string, int, string, string, string, string, string, string, string, double, int, string);

        //seperated from private to alphabetize the list of members easily
        string name;

        string getName() const;
        int getPatronID() const;
        string getPassword() const;
        string getStAddress() const;
        string getCity() const;
        string getState() const;
        string getZip() const;
        string getPhone() const;
        string getEmail() const;
        int getLibraryID() const;
        double getFines() const;
        string getPatronStatus() const;

        //Patron functions
        void addPatron(vector<Library>&, vector<Patron>&);
        void deletePatron(vector<Patron>&);
        void editPatron(vector<Patron>&);
        void printPatron(vector<Patron>&);
        void printAddress(vector<Patron>&);
        void sortPatrons(vector<Patron>&);
        void printSingleMember(vector<Patron>&);
        void payFines(vector<Patron>&);
        //in librarySwitch()
        void savePatrons(vector<Patron>&);
        //in main - through LoadFile()
        string loadPatrons(vector<Patron>&);

        void editFines(int, double, vector<Patron>&);
        void updateStatus(int, string, vector<Patron>&);
};

class LibraryItem
{
    private:
        int itemID;
        string title;
        string genre;
        int libraryID;
        string status;
        string itemType;

    public:
        LibraryItem();

        LibraryItem(int, string, string, string, int, string, string);

        //seperated from private to alphabetize the list of books by author easily
        string author;

        int getItemID() const;
        string getStatus() const;
        string getItemType() const;
        virtual string getProtected() const{}

        virtual void setProtected(string editedString){

        }

        //collection functions
        void addItem(vector<Library>&, vector<LibraryItem*>&, string);
        void deleteItem(vector<LibraryItem*>&);
        void editItem(vector<LibraryItem*>&);
        void printItem(vector<LibraryItem*>&);
        void sortItems(vector<LibraryItem*>&);
        void recordLost(vector<LibraryItem*>&);
        void printCatalog(vector<LibraryItem*>&);
        void printLost(vector<LibraryItem*>&);
        void recordFound(vector<LibraryItem*>&);
        //in librarySwitch()
        void saveItems(vector<LibraryItem*>&);
        //in main - through LoadFile()
        string loadItems(vector<LibraryItem*>&);

        void changeStatus(int, string, vector<LibraryItem*>&);
        virtual void printInfo(){}
};

class Book : public LibraryItem
{
    public:
        Book(int newItemID, string newTitle, string newAuthor, string newGenre, int newLibraryID, string newStatus, string newItemType) : LibraryItem(newItemID, newTitle, newAuthor, newGenre, newLibraryID, newStatus, newItemType){}

};

class Reference : public LibraryItem
{
    protected:
        string volume;
    public:
        Reference(){

        }

        Reference(int newItemID, string newTitle, string newAuthor, string newGenre, int newLibraryID, string newStatus, string newItemType, string newVolume) : LibraryItem(newItemID, newTitle, newAuthor, newGenre, newLibraryID, newStatus, newItemType){
            volume = newVolume;
        }

        virtual string getProtected() const{
            return volume;
        }

        virtual void setProtected(string editedString){
            volume = editedString;
        }

        virtual void printInfo(){
            cout << "\nVolume: " << getProtected() << endl;
        }
};

class DVD : public LibraryItem
{
    protected:
        string runtimeMinutes;
    public:
        DVD(){

        }

        DVD(int newItemID, string newTitle, string newAuthor, string newGenre, int newLibraryID, string newStatus, string newItemType, string newRuntime) : LibraryItem(newItemID, newTitle, newAuthor, newGenre, newLibraryID, newStatus, newItemType){
            runtimeMinutes = newRuntime;
        }

        virtual string getProtected() const{
            return runtimeMinutes;
        }

        virtual void setProtected(string editedString){
             runtimeMinutes = editedString;
        }

        virtual void printInfo(){
            cout << "\nRun-time in Minutes: " << getProtected() << endl;
        }

};

class Tape : public LibraryItem
{
    protected:
        string narrator;
    public:
        Tape(){

        }

        Tape(int newItemID, string newTitle, string newAuthor, string newGenre, int newLibraryID, string newStatus, string newItemType, string newNarrator) : LibraryItem(newItemID, newTitle, newAuthor, newGenre, newLibraryID, newStatus, newItemType){
            narrator = newNarrator;
        }

        virtual string getProtected() const{
            return narrator;
        }

        virtual void setProtected(string editedString){
            narrator = editedString;
        }

        virtual void printInfo(){
            cout << "\nNarrator: " << getProtected() << endl;
        }
};

class Loan
{
    private:
        int patronID;
        int itemID;
        string dateLoaned;
        string dueDate;
        int dueDateTime;
        string loanStatus;

    public:
        Loan();

        Loan(int, int, string, string, int, string);

        int getPatronID() const;
        int getItemID() const;
        string getDateLoaned() const;
        string getDueDate() const;
        int getDueDateTime() const;
        string getLoanStatus() const;

        void addLoan(vector<Patron>& , vector<LibraryItem*>& , vector<Loan>& );
        void returnLoan(vector<Patron>& , vector<LibraryItem*>& , vector<Loan>& );
        void printOut(vector<Loan>&);
        void calculateOverdue(vector<Patron>& , vector<LibraryItem*>& , vector<Loan>& );
        void printOverdue(vector<Loan>&);
        void printFined(vector<Patron>& , vector<LibraryItem*>& , vector<Loan>& );
        void printTopFines(vector<Patron>& , vector<LibraryItem*>& , vector<Loan>& );
        //in librarySwitch()
        void saveLoans(vector<Loan>&);
        //in main - through LoadFile()
        string loadLoans(vector<Loan>&);

        void editStatus(int, int, string, vector<Loan>&);
};
#endif // CLASSES_H6_INCLUDED

