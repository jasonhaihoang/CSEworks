/////////////////////////////////////////////////////////////////
//
//  Joson Hoang
//  Taylor Condrack
//  Samuel McGregor
//  CSCE 4600 - Keathly
//	5/3/2016
//
//	Project #2 - Process Scheduling
//
/////////////////////////////////////////////////////////////////

#include <cstdlib>
#include <cmath>
#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#include <vector>
#include <iostream>

using namespace std;


int * RAM; // pointer to our RAM block
bool memAllocated = false; // has RAM been allocated?
unsigned int SIZE_OF_MEM_BLOCK = 10240; // 10 MB in KB

// returns:
//	Sucess --> returns true
//	Fail   --> return false
bool allocateMEM()
{
	RAM = (int *) malloc(SIZE_OF_MEM_BLOCK * sizeof(int));

	if (RAM != NULL)
	{
		for (unsigned int i = 0; i < SIZE_OF_MEM_BLOCK; i++) // loop through all RAM offsets
			RAM[i] = 1; // set all RAM to free

		memAllocated = true;
		return true;
	}
	return false;
};

// parameters:
// 	first  --> the offset (index starts at 0) of the memory location
//
// returns:
//	Sucess --> returns offset (index starts at 0) of mem block
//	Fail   --> return -1, memory is unchanged
int my_malloc( unsigned int numOfBlocksToMalloc)
{
	if (!memAllocated || numOfBlocksToMalloc < 1)
		return -1;

	unsigned int i,tempNum;

	for (i = 0, tempNum = 0; i < SIZE_OF_MEM_BLOCK; i++) // loop through all RAM offsets
	{
		if (RAM[i] == 1) // keep track of current size of free block
			tempNum++;
		else // start over with the free block counter
			tempNum = 0;

		if (tempNum == numOfBlocksToMalloc) // found the first block big enough!
		{
			for (unsigned int j=0; j < numOfBlocksToMalloc; j++, i--) // loop through block size
				RAM[i] = 0; // set RAM block to used

			return i + 1; // return offset
		}
	}

	return -1; // else return error, not enough free space
};

// parameters:
// 	first  --> the offset (index starts at 0) of the memory location
// 	second --> the number of blocks to free up
//
// returns:
//	Sucess --> returns number of blocks freed up
//	Fail   --> return -1, process should wait
int my_free(unsigned int offset, unsigned int numOfBlocksToFree)
{
	// exit if memory not allocated or index out of bounds
	if (!memAllocated
		|| offset < 0
		|| offset > SIZE_OF_MEM_BLOCK
		|| numOfBlocksToFree < 1
		|| numOfBlocksToFree > SIZE_OF_MEM_BLOCK
		|| offset+numOfBlocksToFree > SIZE_OF_MEM_BLOCK
		)
	{
		return -1;
	}

	for (unsigned int i = 0; i < numOfBlocksToFree; i++)
		RAM[offset + i] = 1; // set it to free

	return numOfBlocksToFree; // return number of blocks freed up
};

// only used for debugging
void printMEM(unsigned int x = 100)
{
	for (unsigned int i = 0; i<x && i<SIZE_OF_MEM_BLOCK; i++)
		cout << RAM[i];
	cout << endl;
};

class Process{			//This class serves as the data structure containing the process 3-tuple
	private:
		int processID;
		bool procDone1;
		bool procDone2;
		bool run;
		int numCycles1;
		int numCycles2;
		int memSize;
		int arrival;
		int *mem;
		int offset;
		int sizeofmem;


	public:
		Process();			//constructor
		Process(int, int, int, int, int);		//overloaded constructor
		double randDist(int, int, double, double);	//the normal distribution algorithm
		void addProcess(vector<Process>&, int, int, int, int, int);	//add new process with stats to list

		int totalWait1;	//made public to be used for function calulations
		int totalWait2;
		int coreNum;

		int schedule(vector<Process>&, int);
		void waitTime(vector<Process>&, int, int, int);
		void subtractArrival(vector<Process>&, int);
		int multiSchedule(vector<Process>&, int, int, int);
		void multiWaitTime(vector<Process>&, int, int, int, int);
		void multiSubtractArrival(vector<Process>&, int);
};

//Constructor
Process::Process(){
	numCycles1 = 0;
	numCycles2 = 0;
	procDone1 = false;
	procDone2 = false;
	run = false;
	totalWait1 = 0;
	totalWait2 = 0;
	offset = 0;
}

//Overloaded Constructor
Process::Process(int newProcessID, int newNumCycles, int newMemSize, int newCoreNum, int newArrival){
	processID = newProcessID;
	numCycles1 = newNumCycles;
	memSize = newMemSize;
	coreNum = newCoreNum;
	arrival = newArrival;
	numCycles2 = newNumCycles;
	totalWait1 = 0;
	totalWait2 = 0;
	procDone1 = false;
	procDone2 = false;
	run = false;
	offset = 0;
}

//This is the normal distribution algorithm that I used  to generate random numbers.
//The normal distribution utilizes the Box Muller Transformation to generate the random numbers
double Process::randDist(int mean, int stddev, double min, double max) {
	static double n2 = 0.0;		//these variables are used to generate the normally distributed
     	static int n2_cached = 0;	//faster by keeping the 2nd random number generated from the previous
					//instance of the function
        if (!n2_cached) {
		double x, x1, x2, y, y1, y2, r;
 		do {	//generate 2 random numbers within the specified range
 			x1 = ((double)rand()/(double)(RAND_MAX));
			x2 = (max - min);
			x = fmod(x1,x2);

 	    		y1 = ((double)rand()/(double)(RAND_MAX));
			y2 = (max - min);
			y = fmod(y1,y2);

 	    		r = x*x + y*y;	//begin to normally distribute the randomly generated numbers
 		}while (r == 0.0 || r > 1.0);
        	//double diff = max - min;
        	double d = sqrt(abs(-2.0*log(r)/r));		//Box Muller Transformation algorithm
		double n1 = x*d;
 		n2 = y*d;		//store the 2nd generated number normally distributed
		double result = n1*mean*stddev + (min*4);
        	while((result < min)||(result > max))
		{	//error correcting
			if (result < min)
			{
				result += min;
			}
			else if (result > max)
			{
				result -= max;
			}
		}
		n2_cached = 1;		//set the if flip flop
        	return result;	//return the 1st normally distributed random number
  	}
	else
	{
        	n2_cached = 0;			//set the if flip flop
		double result = n2*mean*stddev + (min*4);
		while((result < min)||(result > max))
                {	//error correcting
                        if (result < min)
                        {
                                result += min;
                        }
                        else if (result > max)
                        {
                                result -= max;
                        }
                }
		return result;	//return the 2nd normally distributed random number
	}
}

//This function adds the newly distributed process with its stats to the vector data structure
void Process::addProcess(vector<Process>& plist, int newProcessID, int newNumCycles, int newMemSize, int newCoreNum, int newArrival){
	Process newProcess(newProcessID, newNumCycles, newMemSize, newCoreNum, newArrival);	//create the new process
	plist.push_back(newProcess);				//store the process
}

int Process::schedule(vector<Process>& plist, int numProc)
{
	int i;
	int procComplete = 0;
	unsigned int time = 0;
	unsigned int quantum = 0;
	unsigned int nextProc = 0;
	
	while (procComplete != numProc)
	{
		for(i=0; i<numProc; i++)
		{
			if((plist[i].run == true) && (plist[i].procDone1 == false))
			{
				plist[i].numCycles1 -= 1;
				if(plist[i].numCycles1 == 0)
				{
					plist[i].procDone1 = true;
					procComplete += 1;
					cout<<procComplete<<endl;
					//free(plist[i].mem);
					my_free(plist[i].offset, plist[i].memSize);
					plist[i].run = false;
				}
			}
			else if(plist[i].offset == -1)	 //checks the process failed allocation queue
                        {	//checks if skipped process due to not enough memory can allocate memory yet
                                plist[i].offset = my_malloc( plist[i].memSize );
                                //sizeofmem = malloc((plist[i].memSize)*sizeof(int));
                                //plist[i].mem = (int*)malloc((plist[i].memSize)*sizeof(int));
                                if (plist[i].offset != -1)
                                {
                                        plist[i].run = true;
                                        plist[i].numCycles1 -= 1;
                                }
                        }
			else if((plist[i].run == false) && (plist[i].procDone1 == false))
			{
				if(nextProc == 0)
				{
					quantum = time % 50;
					if(quantum == 0)
					{
						plist[i].offset = my_malloc( plist[i].memSize );
						//sizeofmem = malloc((plist[i].memSize)*sizeof(int));
						//plist[i].mem = (int*)malloc((plist[i].memSize)*sizeof(int));
						if (plist[i].offset != -1)
						{
							plist[i].run = true;
							plist[i].numCycles1 -= 1;
						}
						nextProc = 1;
					}
				}
			}
		}
		nextProc = 0;
		time += 1;
	}
	return time;
}
;

//INT MAIN
int main() {
	Process process;	//Process 3-tuple class
	vector<Process> plist;	//vector data structure
	int numProc = 64;	//number of processes
	int numCyclesList[numProc];
	int memSizeList[numProc];
	//int coreNumProc[4];
    int k;	//counters
	int cycleAvg = 0;
	int memAvg = 0;
	int penaltyTime = 0;

	if (!allocateMEM()) // call malloc
	{
		return 0;
	}

	//cout << "\nPlease input the number of processes"
	cout << "\nThis program will create " << numProc << " processes, each with an ID #, the number of cycles to complete the process, and the size of the memory footprint." << endl;

	//srand(time(NULL));
	srand(45067); //seed the rand function

	// cycle gen
	for(k=0; k<numProc; k++){	//generates randomly distributed numbers for the number of cycles
		double val = process.randDist(6000, 1, 1000.0, 11000.0);
		int i = (int)floor(val + 0.5); //rounds the number genreated
		if (i >= 1000 && i <= 11000)
		{
			numCyclesList[k] = i;	//store in temporary list
			cycleAvg += i;		//calculate average
			//cout << "numCycles: " << i << endl;
		}
	}
	cout << "The required # of cycles to complete each process has been generated for each process." << endl;

	// mem gen
	for(k=0; k<numProc; k++) {	//generates randomly distributed numbers for the memory sizes
		double val2 = process.randDist(320, 1, 1, 320.0);
		//val2 = rand()%319 +1;
		int j = (int)floor(val2 - 0.5);	//rounds the number genreated
		if (j >= 1 && j <= 320)
		{
			memSizeList[k] = j;	//store in temporary list
			memAvg += j;		//calculate average
		}
	}
	cout << "The memory size for each process has been generated for each process.\n" << endl;

	cycleAvg /= numProc;	//calculate averages
	//memAvg /= numProc;


	// //Commented out code that will print out the list of processes and the number of cycles assigned to each.
	// for(i=0; i<numProc; i++)
	// {
		// cout << "Process #" << i+1;
		// cout << "\tCycles = " << numCyclesList[i];
		// cout << "\tMem size = " << memSizeList[i] << endl;
	// }

	cout << "Average number of cycles = " << cycleAvg << endl;	//print average outputs
	cout << "Total size of memory footprint = " << memAvg << endl;
	cout << "Average size of memory footprint = " << (memAvg/numProc) << endl;

	int arrival = 0;	//for arrival calcualtions

	//for (j=0; j<4; j++)
//	{
	//	coreNumProc[j] = 0;	//initialize the "number of processes per processor" array
	//}

	for(k=0; k<numProc; k++) {	//add each process to the vector data structure
		process.addProcess(plist, k, numCyclesList[k], memSizeList[k], 0, arrival);
		arrival += 50;	//processes arrive in increments of 50 cycles
	}
	clock_t start, end;

	start = clock();
	penaltyTime = process.schedule(plist, numProc);
	end = clock();

	double time = (end - start)/CLOCKS_PER_SEC;
	cout << "Cycles = " << (end - start) << " And seconds = " << time << endl;
	cout << "Num of cycles total = " << penaltyTime << "\n" << endl;

	return 0;
}
