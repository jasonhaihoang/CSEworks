//********************************************************
//
//	Name: JASON HOANG
//	Course: CSCE 3110 - Dr. O'Neill
//	Assignment: Program 2 - Sorting - MERGESORT
//	Due Date: 6/30/2015 at 11:55pm
//
//********************************************************

#include <iostream>
#include <ctime>		//for use of clock_t
#include <string>
#include <fstream>		//file i/o
#include <iomanip>		//for use of setprecision() to display full decimals

using namespace std;

typedef struct{			//data structure used for array of meteors and their stats
	string MetName;		// meteor designmtion/name
	double impactProb;	// impact probability
}Meteor;

//pre-build functions
void merge_sort(Meteor list[], int low, int high);
void merge(Meteor list[], int low, int mid, int high);

//MAIN
int main(){
	clock_t t;			//function used for clock()
	Meteor list[585];		//hardcoded 585 meteors, otherwise array size not specified
	int i;
	int low = 0, high = 584;	//index (p and r)

	for(i=0; i<585; i++)		//build and define array of meteors
	{
		cin >> list[i].MetName;
		cin >> list[i].impactProb;
	}
	
	t = clock();			//start time number of clicks
	merge_sort(list, low, high);	//call mergesort algorithm
	t = clock() - t;		//stop time number of clicks
	
	// Open the file
    	ofstream sorted ("neo_sorted.txt");

    	if(sorted.is_open())
    	{
		// Print contents after sorting
                for(i = 0; i < 585; i++)
                {
                        sorted << list[i].MetName << ' '; 
			sorted << fixed << setprecision(11) << list[i].impactProb << endl;
                }
		sorted << "\nThis merge sort algorithim took " << t << " clicks." << endl;
		sorted.close();
    	}
    	else	//error handling
    	{	
		cout << ("\nERROR: Cannot open file.") << endl;
    	}	
	return 0;
}

//MERGESORT FUNCTIONS
void merge_sort(Meteor list[], int low, int high)
{
	int mid;	//middle element index
	
	if(low < high)
	{
		mid = (low + high)/2;		//calculate middle index
		merge_sort(list, low, mid);	//recursion-left half
		merge_sort(list, mid+1, high);	//recursion-right half
		merge(list, low, mid, high);	//merge halves together
	}
}

void merge(Meteor list[], int low, int mid, int high)
{
	int i;
    	int Lindex = low;		//LEFT index
    	int Rindex = mid + 1;		//RIGHT index
    	int MergeIndex = low;
    	Meteor tempArr[585];		//temporary array to store and swap elements while sorting

	//SORT sequences in ascending order
    	while(Lindex <= mid && Rindex <= high)
    	{
		//increment indexes to traverse the entire sequence according to which side
        	if(list[Lindex].impactProb <= list[Rindex].impactProb)		//LEFT SIDE
        	{
            		tempArr[MergeIndex++] = list[Lindex++];
        	}
        	else								//RIGHT SIDE
        	{
            		tempArr[MergeIndex++] = list[Rindex++];
        	}
    	}

    	if(Lindex == mid + 1)
    	{
        	while(Rindex <= high)		//Refill RIGHT side according to current list
        	{
            		tempArr[MergeIndex++] = list[Rindex++];
        	}
    	}
    	else
    	{
        	while(Lindex <= mid)		//Refill LEFT side according to current list
        	{
            		tempArr[MergeIndex++] = list[Lindex++];
        	}
    	}
	
	//MERGE sequences back together
    	for(i = low; i <= high; i++)
    	{
        	list[i] = tempArr[i];
    	}
}
