#include <stdio.h>
#include <stdlib.h>

void inc_n(int *n)
{
   /* increment n to 100 */
   while(++(*n) < 1000000000);
}

int main()
{
    pid_t pid;

    int x = 0, y = 0;
    printf("x: %d, y: %d\n", x, y);
  
    pid = fork();
    if( pid == 0 )
    {
        inc_n(&y);
        printf("y increment finished\n");
        printf("y: %d\n", y);
	wait();
    } 
    else
    {
        inc_n(&x);
        printf("x increment finished\n");
        printf("x: %d\n", x);
    }   
    return 0;
}
