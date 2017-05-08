//**************************************************
//
//	Name: JASON HOANG
//	Course: CSCE 3110 - Dr. O'Neill
//	Assignment: Program 2 - Sorting - QUICKSORT
//	Due Date: 6/30/2015 at 11:55pm
//
//**************************************************

#include <iostream>
#include <ctime>	//for use of clock_t
#include <string>
#include <fstream>	//file i/o
#include <iomanip>	//for use of setprecision() to display full decimals in output

using namespace std;

typedef struct			//data structure used for array of meteors and their stats
{
	string metName;
	double impactProb;
}Meteor;

//pre-build functions
void quicksort(Meteor list[], int low, int high);
int Mo3partition(Meteor list[], Meteor pivot, int low, int high);
void swapArrayElements(Meteor list[], int index1, int index2);
Meteor median3(Meteor list[], int low, int high);

//MAIN
int main()
{
	clock_t t;			//function used for clock()	
	Meteor list[585];		//hardcoded 585 meteors, otherwise array size not specified
	int i;
	int low = 0, high = 584;	//index (p and r)

	for(i=0; i<585; i++)		//build and define array of meteors
	{
		cin >> list[i].metName;
		cin >> list[i].impactProb;
	}
	
	t = clock();			//start time number of clicks
	quicksort(list, low, high);	//call quicksort algorithm
	t = clock() - t;		//stop time number of clicks
	
	// Open the file
    	ofstream sorted ("neo_sorted.txt");

    	if(sorted.is_open())
    	{
		// Print contents after sorting
                for(i = 0; i < 585; i++)
                {
                        sorted << list[i].metName << ' '; 
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

//QUICKSORT FUNCTIONS
void quicksort(Meteor list[], int low, int high)
{
	int i;
	Meteor pivot;
	
	if(high-low < 2)	//if number of elemnts less than number needed for Median-of-three
	{	
		//swap any of the leftover elements if needed
		if(list[high].impactProb < list[low].impactProb)
        	{
                	swapArrayElements(list, low, high);
        	}
		return;
	}
	else if (low < high)
	{
		pivot = median3(list, low, high);		//median-of-three partitioning
		i = Mo3partition(list, pivot, low, high);	//regular partitioning
		quicksort(list, low, i-1);			//recursion-left side
		quicksort(list, i+1, high);			//recursion-right side
	}
}

//REGULAR PARTITIONING AFTER median-of-three
int Mo3partition(Meteor list[], Meteor pivot, int low, int high)
{
	int j = high-1;		//set to pivot point
	int i = low;
	for( ; ; )
	{								//Partition - 
		while(list[++i].impactProb < pivot.impactProb){}	//traverse array to calcualte
		while(pivot.impactProb < list[--j].impactProb){}	//where to swap elements
		if(i < j)						//according to quicksort
		{							//algorithm
			swapArrayElements(list, i, j);
		}
		else
		{
			break;
		}
	}
	swapArrayElements(list, i, high-1);				//restore pivot
	return i;
}

//MEDIAN-OF-THREE PARTITIONING
Meteor median3(Meteor list[], int low, int high)
{
	int center = (low+high)/2;				//calculate median
	//Partition between the ends and the center elements
	if(list[center].impactProb < list[low].impactProb)
	{
		swapArrayElements(list, low, center);
	}
	if(list[high].impactProb < list[low].impactProb)
	{
		swapArrayElements(list, low, high);
	}
	if(list[high].impactProb < list[center].impactProb)
	{
		swapArrayElements(list, center, high);
	}
	//swap center element with second to last element-which will now become the pivot
	swapArrayElements(list, center, high-1);
	return list[high-1];			//return pivot
}

// function to swap two elements of an array
void swapArrayElements(Meteor list[], int index1, int index2)
{
  	Meteor temp;
    	temp = list[index1];
    	list[index1] = list[index2];
    	list[index2] = temp;
}
