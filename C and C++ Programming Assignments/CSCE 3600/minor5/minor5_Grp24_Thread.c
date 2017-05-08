////////////////////////////////////////////////////////////////////////////////
//
//	CSCE 3600 - Dr. Sweany - March 9th, 2015
//	Threaded version of the increment.c program.
//	Worked on and completed by - GROUP 24: JASON HOANG and AUSTIN HARRIS
//
////////////////////////////////////////////////////////////////////////////////

#include <pthread.h>
#include <stdio.h>

// second thread function
void *xinc(void *xPtrVoid);

int main()
{

	int x = 0, y = 0;

	// print the initial values of x and y 
	printf("x: %d, y: %d\n", x, y);

	// reference to the second thread
	pthread_t Xthread;

	//create a second thread which executes xinc(&x) function
	if(pthread_create(&Xthread, NULL, xinc, &x))
	{
		// error message
        	printf("ERROR");		
        	return 1;
	}

	// increment y in the first thread
	while(++y < 1000000000);

	printf("y increment finished\n");

	// wait for the second thread to finish
	if(pthread_join(Xthread, NULL))
	{
		// error message
		printf("ERROR");
		return 2;
	}

	// print the results
	printf("x: %d, y: %d\n", x, y);

	return 0;

}

// this function is run by the second thread
void *xinc(void *xPtrVoid)
{

        // increment x via pointer
        int *xptr = (int *)xPtrVoid;
        while(++(*xptr) < 1000000000);

        printf("x increment finished\n");

        return NULL;

}
