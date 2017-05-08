////////////////////////////////////////////////////////////////////////////////
//
//	CSCE 3600 - Dr. Sweany - March 9th, 2015
//	Forked version of the increment.c program.
//	Worked on and completed by - GROUP 24: JASON HOANG and AUSTIN HARRIS
//
////////////////////////////////////////////////////////////////////////////////

#include <stdio.h>
#include <unistd.h>

void inc(pid_t pid, void *x, void *y);

int main()
{
	
	int i, j;
	int x = 0, y = 0;

	// print initial values for x and y
	printf("x: %d, y: %d\n", x, y);

	// create fork
	pid_t pid = fork();
	inc(pid, &x, &y);

	//wait for processes to finish
	// print incremented values
	wait(pid);
    	printf("x: %d, y: %d\n", x, y);

    	return 0;

}

// This function takes the pointers for x and y, increments them, and returns them to main
void inc(pid_t pid, void *x, void *y)
{
	int i, j;
	int *xptr = (int *)x;
	int *yptr = (int *)y;
	
	if (pid == 0)
        {
                // child process
                for (i = 0; i < 1000000000; ++i)
                {
                        //increment y
                        ++(*yptr);
                }
                printf("y increment finished\n");
        }
        else if (pid > 0)
        {
                // parent process
                for (j = 0; j < 1000000000; ++j)
                {
                        //increment x
                        ++(*xptr);
                }
                printf("x increment finished\n");
        }
        else
        {
                // fork failed
                printf("ERROR\n");
                return;
        }
	
	return;
}
