#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <pthread.h>

void *inc_n(void *n)
{
   /* increment n to 100 */
   while(++(*(int *)n) < 1000000000);
}

int main()
{

    int i;
    pthread_t threads[2];

    int x = 0, y = 0;
    printf("x: %d, y: %d\n", x, y);
  
// thread 0 --- for x
    pthread_create(&threads[0],NULL,inc_n,(void *)&x); 
    printf("x increment finished\n");
   
// thread 1 --- for y
    pthread_create(&threads[1],NULL,inc_n,(void *)&y); 
    printf("y increment finished\n");
  
    for (i = 0; i < 2; i++)
    {
        pthread_join(threads[i], NULL);
    }
 
    printf("x: %d, y: %d\n", x, y);
    return 0;
}
