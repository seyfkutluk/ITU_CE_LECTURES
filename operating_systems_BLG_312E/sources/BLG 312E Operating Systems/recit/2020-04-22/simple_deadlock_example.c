#include <sys/ipc.h>
#include <sys/sem.h>
#include <sys/types.h>
#include <pthread.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>



//  mutex variable declarations
pthread_mutex_t lock_1;
pthread_mutex_t lock_2;


void* faulty_functionA(void* arg)
{
    pthread_mutex_lock(&lock_1);  //  start of Critical Region 1
    printf("\nA is in Critical Region 1\n");
    fflush(stdout);  //  to print out buffer contents immediately
    sleep(2);  //  sleep 2 seconds
    pthread_mutex_lock(&lock_2);  //  start of Critical Region 2
    printf("\nA is in Critical Region 2\n");
    fflush(stdout);  //  to print out buffer contents immediately
    pthread_mutex_unlock(&lock_2);  //  end of Critical Region 2
    pthread_mutex_unlock(&lock_1);  //  end of Critical Region 1
}

    
void* faulty_functionB(void* arg)
{
    sleep(1);
    pthread_mutex_lock(&lock_2);  //  start of Critical Region 2
    printf("\nB is in Critical Region 2\n");
    fflush(stdout);  //  to print out buffer contents immediately
    sleep(2);  //  sleep 2 seconds
    pthread_mutex_lock(&lock_1);  //  start of Critical Region 1
    printf("\nA is in Critical Region 1\n");
    fflush(stdout);  //  to print out buffer contents immediately
    pthread_mutex_unlock(&lock_1);  //  end of Critical Region 1
    pthread_mutex_unlock(&lock_2);  //  end of Critical Region 2
}


int main()
{
    pthread_t threadA, threadB;  //  declaring two threads
    pthread_mutex_init(&lock_1, NULL);  //  initializing mutex variables
    pthread_mutex_init(&lock_2, NULL);  //  initially unlocked
    
    if ( pthread_create(&threadA, NULL, faulty_functionA, NULL) )  //  creating threadA
    {
        printf("Thread A creation error!\n");
        exit(1);
    }
    
    if ( pthread_create(&threadB, NULL, faulty_functionB, NULL) )  //  creating threadB
    {
        printf("Thread B creation error!\n");
        exit(2);
    }
    
    if ( pthread_join(threadA, NULL) )  //  waiting for threadA to terminate
    {
        printf("Thread A join error!\n");
        exit(3);
    }
    if ( pthread_join(threadB, NULL) )  //  waiting for threadB to terminate
    {
        printf("Thread B join error!\n");
        exit(4);
    }
    
    //  destroying mutex variables
    pthread_mutex_destroy(&lock_1);
    pthread_mutex_destroy(&lock_2);
    return 0;
}
    
