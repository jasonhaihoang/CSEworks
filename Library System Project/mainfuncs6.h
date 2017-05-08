// Jason Hoang (jhh0089@my.unt.edu)
// Homework 5 - Library Management Program in C++
// CSCE 1040 - Keathly

//extra functions
#ifndef MAINFUNCS6_H_INCLUDED
#define MAINFUNCS6_H_INCLUDED

#include<iostream>
#include<string>
#include<vector>
#include<algorithm>
#include<ctime>
#include<string>
#include<fstream>
#include<sstream>

using namespace std;

void SaveFile(vector<Library>& library, vector<Patron>& plist, vector<LibraryItem*>& blist, vector<Loan>& tlist);
string LoadFile(vector<Library>& library, vector<Patron>& plist, vector<LibraryItem*>& blist, vector<Loan>& tlist);

//Main Menu
int LibrarySwitch(vector<Library>& library, vector<Patron>& plist, vector<LibraryItem*>& blist, vector<Loan>& tlist);
//Member Menu
void PatronSwitch(vector<Library>& library, vector<Patron>& plist);
//LibraryItem Menu
void ItemSwitch(vector<Library>& library, vector<LibraryItem*>& blist);
//Check-Out Menu
void LoanSwitch(vector<Patron>& plist, vector<LibraryItem*>& blist, vector<Loan>& tlist);
//add Item Menu
void ItemTypeSwitch(vector<Library>& library, vector<LibraryItem*>& blist);
#endif // MAINFUNCS6_H_INCLUDED
