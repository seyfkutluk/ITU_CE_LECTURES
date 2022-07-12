#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>

int myglobal;

void* thread_function(void* arg)
{
    int i, j;
    
    //  changing the value of myglobal in thread_function
    for (i=0; i < 20; ++i)
    {
        //myglobal++;
        j = myglobal;
        j = j + 1;
        myglobal = j;
        printf(".");
        
        //  to force writing buffered data to stdout
        fflush(stdout);
        
        //sleep(1);
    }
}

int main()
{
    pthread_t mythread;
    int i;
    myglobal = 0;
    
    //  creating a thread using thread_function as the start
    if (pthread_create(&mythread, NULL, thread_function, NULL))
    {
        printf("error creating thread\n");
        exit(1);
    }
    
    //  changing the value of myglobal in main()
    for (i = 0; i < 20; ++i)
    {
        myglobal = myglobal+1;
        printf("o");
        
        //  to force writing buffered data to stdout
        fflush(stdout);
        
        //sleep(1);
    }
    
    printf("\nmyglobal equals %d\n", myglobal);
    
    //  make process not terminate until all spawned threads are finished
    pthread_exit(NULL);
}
