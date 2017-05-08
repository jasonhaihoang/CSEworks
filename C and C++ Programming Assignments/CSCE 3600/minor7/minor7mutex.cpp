//**********************************************************************************
//
//	CSCE 3600 - Dr. Sweany
//	Minor Program 7 - Mutex Threads
//	
//	The purpose of this program was to adjust the code to utilize mutex locks
//	and synchornize the execution of the threads and correct the output.
//
//	NOTE: The simplest fix to this program without the use of mutex locks was
//	to add a second for loop that is similar to the first which created the 
//	first threads. The second loop will create a new set of threads that will 
//	print each character of the new sentence with the correct output using the 
//	printChar function.
//
//	This program was written and completed by:
//	Group 24 - Jason Hoang and Austin Harris
//
//**********************************************************************************

#include <cstdio>
#include <iostream>
#include <string.h>
#include <pthread.h>


using namespace std;

pthread_mutex_t lock;

char sentence[2000];
int ind1=0;	//index for uppercase converter
int ind2=0;	//index for printing new sentence
int sLength=0;	//globalize the sentence length

char convertUppercase(char lower){ //Converts lowercase un uppercase
	if((lower > 96) && (lower < 123))
		return lower-32;
	else
		return lower;
}

//This whole function needs to be converted into a pointer function for the thread
void *printChar(void *ptr){ //prints the converted sentence
	pthread_mutex_lock(&lock);		//second function lock
	//traverse and print the new sentence
	for(ind2=0; ind2 < sLength; ind2++)
        {
		cout << sentence[ind2];
	}
	pthread_mutex_unlock(&lock);		//unlocks second lock
}

void *convertMessage(void *ptr){ // Function that each threads initiates its execution
	char aux;	//don't know why this was included in the original

	pthread_mutex_lock(&lock);		//first function lock
	//traverse the sentence
	for(ind1=0; ind1 < sLength; ind1++)	
	{
		if(ind1 % 2)	//if odd index
		{
			sentence[ind1] = convertUppercase(sentence[ind1]);
			//printChar();		//part of the original
		}
	}
	pthread_mutex_unlock(&lock);		//unlocks first lock
}

//MAIN
int main(){
	
	string phrase;
	pthread_t ts1;		//only need 2 threads for this assignment
	pthread_t ts2;
	//pthread_t ts[50]; // define up to 50 threads


	cout<<"please enter a phrase (less than 50 characters): ";
	getline(cin, phrase);

	strcpy(sentence, phrase.c_str()); // copy string to char array
	sLength = phrase.length()+1;	//sets size length for sentence

	cout<<"The original sentence is: \t"<< sentence << endl;
	
	//create first thread to convert each character to uppercase if in odd index
	//for(int i=0; i < phrase.length()+1; ++i){	//part of original
		pthread_create(&ts1, NULL, convertMessage, NULL);	//thread for converting the message
	//}
	
	cout << "The new sentence is: \t\t";	//moved here to prevent multiple prints

	//create second thread to print the results of capitalization.
        //for(int i=0; i < phrase.length()+1; ++i){	//part of original
                pthread_create(&ts2, NULL, printChar, NULL);		//thread for printing new message
        //}

	//we wait until all threads finish execution.
	//for(int i=0; i < phrase.length(); i++){	//part of original
		pthread_join(ts1,NULL);
		pthread_join(ts2,NULL);
	//}
	
	cout<<endl;
	
	return 0;
}
