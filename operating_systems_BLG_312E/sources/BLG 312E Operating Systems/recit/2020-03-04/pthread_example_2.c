#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <pthread.h>

#define NUM_THREADS 4


//  The purpose of this function is just prevent a thread from finishing
//before the other threads are started. Calculated result inside the function
//does not matter for this example.
void* BusyWork(void *arg)
{
    int i;
    long tid;
    double result = 0.0;
    long exit_status;
    
    tid = (long)arg;
    exit_status = 10*tid;
    printf("Thread %ld starting...\n", tid);
    for (i=0; i < 1000000; ++i)
    {
        result = result + sin(i) * tan(i);
    }
    printf("Thread %ld done. Result = %e\n", tid, result);
    pthread_exit((void*) exit_status);
}


int main(int argc, char* argv[])
{
    pthread_t thread[NUM_THREADS];
    pthread_attr_t attr;
    int rc;
    long t;
    void* status;
    
    //  Initialize and set thread detach state attribute
    //Only threads that are created as joinable can be joined
    //Threads created as PTHREAD_CREATE_DETACHED can not be joined
    pthread_attr_init(&attr);
    pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);
    for (t = 0; t < NUM_THREADS; ++t)
    {
        printf("Main: creating thread %ld\n", t);
        
        //  creating thread t
        rc = pthread_create(&thread[t], &attr, BusyWork, (void*)t);
        if (rc)
        {
            printf("ERROR: return code from pthread_create() for thread %ld is %d\n", t, rc);
            exit(t);
        }
    }
    
    //  free resources used by attribute
    pthread_attr_destroy(&attr);
    
    //  Join operation is used for synchronization between threads by
    //blocking the calling thread until the specified thread (with
    //given threadid) terminates. Status is the exit status of the
    //target thread (from pthread_exit, if performed) or PTHREAD_CANCELLED if
    //the targed thread was canceled.
    for (t=0; t < NUM_THREADS; ++t)
    {
        rc = pthread_join(thread[t], &status);
        if (rc)
        {
            printf("ERROR: return code from pthread_join() for thread %ld is %d\n", t, rc);
            exit(t);
        }
        printf("Main: completed join with thread %ld having a status of %ld\n", t, (long)status);
    }
    printf("Main: program completed. Exiting.\n");
    
    //  make process not terminate until all spawned threads are finished
    pthread_exit(NULL);
}
