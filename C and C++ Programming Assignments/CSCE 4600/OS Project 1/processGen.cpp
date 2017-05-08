/////////////////////////////////////////////////////////////////
//
//	Jason Hoang - CSCE 4600 - Keathly
//	3/25/2016
//
//	Project #1 - Process Scheduling
//
/////////////////////////////////////////////////////////////////

#include <cstdlib>
#include <cmath>
#include <ctime>
#include <stdio.h>
#include <stdlib.h>
#include <vector>
#include <iostream>

using namespace std;

class Process{			//This class serves as the data structure containing the process 3-tuple
	private:
		int processID;
		bool procDone1;
		bool procDone2;
		int numCycles1;
		int numCycles2;
		int memSize;
		int arrival;

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
	int numCycles1 = 0;
	int numCycles2 = 0;
	bool procDone1 = false;
	bool procDone2 = false;
	int totalWait1 = 0;
	int totalWait2 = 0;
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
        	double diff = max - min;
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
	int loopCount = 0;
	int penaltyTime = 0;
	while (procComplete != numProc)
	{
		for(i=0; i<numProc; i++)
		{
			if(plist[i].procDone1 == false)
			{
				cout << "\nProcess #" << i << " number of cycles = " << plist[i].numCycles1 << endl;
				plist[i].numCycles1 -= 50;
				cout << "Processing..." << endl;
				if(plist[i].numCycles1 == 0)	//process complete perfect
				{
					plist[i].procDone1 = true;
					procComplete++;	//increment complete processes. 
					waitTime(plist, i, numProc, 0);
					penaltyTime += 10;
					cout << "context switch! +10 to the penalty." << endl;
					cout << "Total Penalty = " << penaltyTime << endl;
					cout << "1 RR cycle complete! Number of cycles = " << plist[i].numCycles1 << endl;
					cout << endl;
				}
				else if(plist[i].numCycles1 < 0)	//process complete with overflow
				{
					int overflow = 0;
					overflow = abs(plist[i].numCycles1);
					plist[i].numCycles1 = 0;
					plist[i].procDone1 = true;
					procComplete++;
					waitTime(plist, i, numProc, overflow);
					penaltyTime += 10;
					cout << "context switch! +10 to the penalty." << endl;
					cout << "Total Penalty = " << penaltyTime << endl;
					cout << "1 RR cycle complete! Number of cycles = " << plist[i].numCycles1 << endl;
				}
				else if((plist[i].numCycles1 > 0) && (procComplete == (numProc-1)))		//process not complete continue scheduling RR
				{
					//do nothing but cycle through the last process
					cout << "1 RR cycle complete! Number of cycles = " << plist[i].numCycles1 << endl;
				}
				else if(plist[i].numCycles1 > 0)	//process not finished
				{
					waitTime(plist, i, numProc, 0);
					penaltyTime += 10;
					cout << "context switch! +10 to the penalty." << endl;
					cout << "Total Penalty = " << penaltyTime << endl;
					cout << "1 RR cycle complete! Number of cycles = " << plist[i].numCycles1 << endl;
				}
			}
		}	
	}
	cout << "NO final context switch! -10 to the penalty." << endl;
	plist[i].totalWait1 -= 10;	//subtract the extra context switch time
	penaltyTime -= 10;
	cout << "\nFINAL Total Penalty = " << penaltyTime << endl;
	return penaltyTime;
}

int Process::multiSchedule(vector<Process>& plist, int numProc, int coreNum, int totalProc)
{
	int i;
	int procComplete = 0;
	int loopCount = 0;
	int penaltyTime = 0;
	int cycleTracker = 0;
	while (procComplete != numProc)
	{
		for(i=0; i<totalProc; i++)
		{
			if((plist[i].coreNum == coreNum)&&(cycleTracker == 0)&&(coreNum == 0))	//resets the RR to account for arrival
			{
				//start of the scheduling processor 1
			}
			else if((plist[i].coreNum == coreNum)&&(cycleTracker == 0)&&(coreNum == 1))	//resets the RR to account for arrival
			{
				//start of the scheduling processor 2
				cycleTracker = 50;
			}
			else if((plist[i].coreNum == coreNum)&&(cycleTracker == 0)&&(coreNum == 2))	//resets the RR to account for arrival
			{
				//start of the scheduling processor 3
				cycleTracker = 100;
			}
			else if((plist[i].coreNum == coreNum)&&(cycleTracker == 0)&&(coreNum == 3))	//resets the RR to account for arrival
			{
				//start of the scheduling processor 4
				cycleTracker = 150;
			}
			else if((plist[i].coreNum == coreNum)&&(plist[i].arrival > cycleTracker))	//resets the RR to account for arrival
			{
				i = 0;
				penaltyTime -= 10;
				cout << "NO context switch! -10 to the penalty." << endl;
				cout << "Total Penalty = " << penaltyTime << endl;

			}	
				if((plist[i].coreNum == coreNum)&&(plist[i].procDone2 == false))
				{
					cout << "\nProcessor #" << coreNum+1 << endl;
					cout << "Process #" << i << " number of cycles = " << plist[i].numCycles2 << endl;
					cout << "Processing..." << endl;
					cycleTracker += 50;
					plist[i].numCycles2 -= 50;
					if(plist[i].numCycles2 == 0)	//process complete perfect
					{
						plist[i].procDone2 = true;
						procComplete++;
						multiWaitTime(plist, i, totalProc, 0, coreNum);
						penaltyTime += 10;
						cout << "context switch! +10 to the penalty." << endl;
						cout << "Total Penalty = " << penaltyTime << endl;
						cout << "1 R1R cycle complete! Number of cycles = " << plist[i].numCycles2 << endl;
					}
					else if(plist[i].numCycles2 < 0)	//process complete with overflow
					{
						int overflow = 0;
						overflow = abs(plist[i].numCycles2);
						plist[i].numCycles2 = 0;
						plist[i].procDone2 = true;
						procComplete++;
						multiWaitTime(plist, i, totalProc, overflow, coreNum);
						penaltyTime += 10;
						cout << "context switch! +10 to the penalty." << endl;
						cout << "Total Penalty = " << penaltyTime << endl;
						cout << "1 R2R cycle complete! Number of cycles = " << plist[i].numCycles2 << endl;
					}
					else if((plist[i].numCycles2 > 0) && (procComplete == (numProc-1)))		//process not complete continue scheduling RR
					{
						//do nothing but cycle through the last process
						cout << "1 R3R cycle complete! Number of cycles = " << plist[i].numCycles2 << endl;
					}
					else if(plist[i].numCycles2 > 0)	//process not finished
					{
						multiWaitTime(plist, i, totalProc, 0, coreNum);
						penaltyTime += 10;
						cout << "context switch! +10 to the penalty." << endl;
						cout << "Total Penalty = " << penaltyTime << endl;
						cout << "1 R4R cycle complete! Number of cycles = " << plist[i].numCycles2 << endl;
					}
				}
		}	
	}
	cout << "NO final context switch! -10 to the penalty." << endl;
	plist[i].totalWait2 -= 10;	//subtract the extra context switch time at the end
	plist[coreNum].totalWait2 -= 30;
	penaltyTime -= 10;
	cout << "\nFINAL Total Penalty = " << penaltyTime << endl;
	return penaltyTime;
}

//add the wait time, from the current process being run, to all of the other processes that are waiting
void Process::waitTime(vector<Process>& plist, int index, int numProc, int overflow)
{
	for(int i=0; i<numProc; i++)
	{
		if((i != index) && (plist[i].procDone1 == false))
		{
			plist[i].totalWait1 += 60;	//50 cycle time + 10 context switch
			plist[i].totalWait1 -= overflow;	//overflow subtracted in case the process finished before the time quantum
		}
	}
}

//same as Process::waitTime(), but only for the processes belonging to the specified processor
void Process::multiWaitTime(vector<Process>& plist, int index, int numProc, int overflow, int coreNum)
{
	for(int i=0; i<numProc; i++)
	{
		if((i != index) && (plist[i].coreNum == coreNum)&&(plist[i].procDone2 == false))
		{
			plist[i].totalWait2 += 60;	//50 cycle time + 10 context switch
			plist[i].totalWait2 -= overflow;	//overflow subtracted in case the process finished before the time quantum
		}
	}
}

//subtract all of the different arrival times from each of the processes - single processor
//This calculation is needed, because the simulation calcualated wait time as if all the processes arrived at time 0
void Process::subtractArrival(vector<Process>& plist, int numProc)
{
	int underflow = 0;
	for(int i=1; i<numProc; i++)	//starts at 1 because process 0 arrives at time 0
        {
        	plist[i].totalWait1 -= 50;       //50 cycle time + 10 context switch
                plist[i].totalWait1 -= underflow;//adds up the +50 time increments and subtracts
		underflow += 50;
        }
}

//subtract all of the different arrival times from each of the processes - multi processor
//This calculation is needed, because the simulation calculated wait time as if all the processes arrived at time 0
void Process::multiSubtractArrival(vector<Process>& plist, int numProc)
{
	for(int i=1; i<numProc; i++)	//starts at 1 because process 0 arrives at time 0
        {
        	plist[i].totalWait2 -= plist[i].arrival;       //subtract the arrival time
        }
}

//INT MAIN
int main() {
	Process process;	//Process 3-tuple class
	vector<Process> plist;	//vector data structure
	int numProc = 50;	//number of processes
	int numCyclesList[numProc];
	int memSizeList[numProc];
	int coreNumProc[4];
    	int k, i, j, x;	//counters
	int cycleAvg = 0;
	int memAvg = 0;
	int avgWait = 0;
	int avgWait1 = 0;	int avgWait2 = 0;	int avgWait3 = 0;	int avgWait4 = 0;
	int penaltyTime = 0; 	
	int penaltyTime1 = 0;	int penaltyTime2 = 0;	int penaltyTime3 = 0;	int penaltyTime4 = 0;
	int numProc1 = 0;	int numProc2 = 0;	int numProc3 = 0;	int numProc4 = 0;
	int overallPenalty = 0;
	int totalAvgWait = 0;	

	//cout << "\nPlease input the number of processes"
	cout << "\nThis program will create " << numProc << " processes, each with an ID #, the number of cycles to complete the process, and the size of the memory footprint." << endl;

     	srand(time(NULL));	//seed the rand function
     	for(k=0; k<numProc; k++) {	//generates randomly distributed numbers for the number of cycles
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

	for(k=0; k<numProc; k++) {	//generates randomly distributed numbers for the memory sizes
                double val2 = process.randDist(20480, 1, 1024.0, 102400.0);
                int j = (int)floor(val2 - 0.5);	//rounds the number genreated
                if (j >= 1024 && j <= 102400)
                {
                        memSizeList[k] = j;	//store in temporary list
			memAvg += j;		//calculate average
                }
        }
	cout << "The the memory size for each process has been generated for each process." << endl;

	cycleAvg /= numProc;	//calculate averages
	memAvg /= numProc;
	
	cout << endl;
	cout << "Average number of cycles = " << cycleAvg << endl;	//print average outputs
	cout << "Average size of memory footprint = " << memAvg << endl;

	int coreNum = 0;	//for processor assignment
	int arrival = 0;	//for arrival calcualtions

	for (j=0; j<4; j++)
	{
		coreNumProc[j] = 0;	//initialize the "number of processes per processor" array
	}

	for(k=0; k<numProc; k++) {	//add each process to the vector data structure
		if(coreNum == 4)
		{
			coreNum = 0;
			process.addProcess(plist, k, numCyclesList[k], memSizeList[k], coreNum, arrival);
			coreNumProc[0]++;	//increment the "number of processes per processor" array
		}
		else
		{
			process.addProcess(plist, k, numCyclesList[k], memSizeList[k], coreNum, arrival);
			coreNumProc[coreNum]++;	//increment the "number of processes per processor" array
			coreNum++;	//alternate between 4 processors
		}
		arrival += 50;	//processes arrive in increments of 50 cycles
	}

	cout << "\nCalculating the Round Robin Schedule of processes for a single processor..." << endl;
	penaltyTime = process.schedule(plist, numProc);
	process.subtractArrival(plist, numProc);
	//calculate the average wait time
	for(x=0; x<numProc; x++)
	{
		avgWait += plist[x].totalWait1;	
	}
	avgWait /= numProc;
	
	cout << "Average waiting time = " << avgWait << endl;
	cout << "Total Penalty Time = " << penaltyTime << endl;
	cout << endl;

	cout << "\nCalculating the Round Robin Schedule of processes for Multi-Processor #1..." << endl;
	penaltyTime1 = process.multiSchedule(plist, coreNumProc[0], 0, numProc);
	cout << "\nCalculating the Round Robin Schedule of processes for Multi-Processor #2..." << endl;
	penaltyTime2 = process.multiSchedule(plist, coreNumProc[1], 1, numProc);
	cout << "\nCalculating the Round Robin Schedule of processes for Multi-Processor #3..." << endl;
	penaltyTime3 = process.multiSchedule(plist, coreNumProc[2], 2, numProc);
	cout << "\nCalculating the Round Robin Schedule of processes for Multi-Processor #4..." << endl;
	penaltyTime4 = process.multiSchedule(plist, coreNumProc[3], 3, numProc);
	process.multiSubtractArrival(plist, numProc);
	//calculate the average wait time overall and for each processor
	for(x=0; x<numProc; x++)
	{
		if(plist[x].coreNum == 0)
		{
			avgWait1 += plist[x].totalWait2;
			numProc1++;
		}
		else if(plist[x].coreNum == 1)
		{
			avgWait2 += plist[x].totalWait2;
			numProc2++;
		}
		else if(plist[x].coreNum == 2)
		{
			avgWait3 += plist[x].totalWait2;
			numProc3++;
		}
		else if(plist[x].coreNum == 3)
		{
			avgWait4 += plist[x].totalWait2;
			numProc4++;
		}
	}
	totalAvgWait = avgWait1 + avgWait2 + avgWait3 + avgWait4;
	totalAvgWait /= numProc;

	avgWait1 /= numProc1;
	avgWait2 /= numProc2;
	avgWait3 /= numProc3;
	avgWait4 /= numProc4;
	//calculate total penalty time over all the processors
	overallPenalty = penaltyTime1 + penaltyTime2 + penaltyTime3 + penaltyTime4;

	cout << "\n\nOverall FINAL RESULTS:" << endl;

	cout << endl;
	cout << "For this experiement, the set of " << numProc << " processes have:" << endl;
	cout << "Average number of cycles = " << cycleAvg << endl;	//print average outputs
	cout << "Average size of memory footprint = " << memAvg << endl;

	cout << "\nThe experiment ran using the Round Robin method calculated(using a single-processor):" << endl;
	cout << "Average waiting time for each process = " << avgWait << endl;
	cout << "Total Penalty Time of the system = " << penaltyTime << endl;
	cout << endl;

	cout << "The experiment ran using the Round Robin method calculated(using a quad-processor):" << endl;
	cout << endl;
	cout << "For Processor 1:" << endl;
	cout << "Average waiting time for each process = " << avgWait1 << endl;
	cout << "Total Penalty Time = " << penaltyTime1 << endl;
	cout << endl;

	cout << endl;
	cout << "For Processor 2:" << endl;
	cout << "Average waiting time for each process = " << avgWait2 << endl;
	cout << "Total Penalty Time = " << penaltyTime2 << endl;
	cout << endl;

	cout << endl;
	cout << "For Processor 3:" << endl;
	cout << "Average waiting time for each process = " << avgWait3 << endl;
	cout << "Total Penalty Time = " << penaltyTime3 << endl;
	cout << endl;

	cout << endl;
	cout << "For Processor 4:" << endl;
	cout << "Average waiting time for each process = " << avgWait4 << endl;
	cout << "Total Penalty Time = " << penaltyTime4 << endl;
	cout << endl;

	cout << "Overall quad-processor average waiting time for each process = " <<  totalAvgWait << endl;
	cout << "Overall total penalty time for all processors = " << overallPenalty << endl;
	cout << endl;
	
	//Commented out code that will print out the list of processes and the number of cycles assigned to each.
	/*for(i=0; i<numProc; i++)
	{
		cout << "\nProcess #" << i+1 << endl;
		cout << "Number of Cycles = " << numCyclesList[i] << endl;
	}*/

	return 0;
}
