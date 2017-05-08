//**********************************************************************************
//
//	CSCE 3600 - Dr. Sweany
//	Minor Program 7 - Mutex Threads
//	
//	The purpose of this program was to show that there is an incredibly simple
//	adjustment made to the original code that did not need mutex locks. We 
//	still decided to include the locks to show where they would have belonged
//	if the program actually needed them. Remove the mutex locks and the program 
//	will still produce the correct output.
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
int ind1=0;		//2 indexes are used
int ind2=0;

char convertUppercase(char lower){ //Converts lowercase un uppercase
	if((lower > 96) && (lower < 123))
		return lower-32;
	else
		return lower;
}

//This whole function needs to be converted into a pointer function for the threads
void *printChar(void *ptr){ //prints the converted sentence
	pthread_mutex_lock(&lock);		//second function lock
	cout << sentence[ind2];
	ind2++;
	pthread_mutex_unlock(&lock);		//unlocks second lock
}

void *convertMessage(void *ptr){ // Function that each threads initiates its execution
	char aux;
	pthread_mutex_lock(&lock);		//second function lock
	if(ind1 % 2)
		sentence[ind1] = convertUppercase(sentence[ind1]);
		//printChar();		//remove this as it is now it's own function
		ind1++;
	pthread_mutex_unlock(&lock);		//unlocks second lock
	return 0;
}


//MAIN
int main(){
	
	string phrase;
	pthread_t ts[50]; // define up to 50 threads


	cout<<"please enter a phrase (less than 50 characters): ";
	getline(cin, phrase);

	strcpy(sentence, phrase.c_str()); // copy string to char array
	
	cout<<"The original sentence is: \t"<< sentence << endl;
	
	//create one thread for each character on the input word.
	for(int i=0; i < phrase.length()+1; ++i){
		pthread_create(&ts[i], NULL, convertMessage, NULL);
	}
	
	cout << "The new sentence is: \t\t";	//place this output here as we only need 1 instance

	//create one thread for each character for the sentence output.
	for(int i=0; i < phrase.length()+1; ++i){
                pthread_create(&ts[i], NULL, printChar, NULL);
        }
	
	//we wait until all threads finish execution.
	for(int i=0; i < phrase.length(); i++){
		pthread_join(ts[i],NULL);
	}
	
	cout<<endl;
	
	return 0;
}
