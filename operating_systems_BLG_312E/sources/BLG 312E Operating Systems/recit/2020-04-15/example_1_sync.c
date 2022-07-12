#include <sys/ipc.h>
#include <sys/sem.h>
#include <sys/types.h>
#include <pthread.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


//  to create a semaphore for mutual exclusion(value=1)
int s;

//  to track whose turn it is
char currentTurn = 'a';


void create(char* argv[])
{
    //  ftok() function returns a key based on path and id
    //that is usable in the subsequent calls to semget() and shmget()
    int semKey = ftok("printerexample", 1);
    s = semget(semKey, 1, 0700|IPC_CREAT);
    semctl(s, 0, SETVAL, 1);  //  semaphore value = 1
}


//  increment operation
void sem_signal(int semid, int val)
{
    struct sembuf semaphore;
    semaphore.sem_num = 0;
    semaphore.sem_op = val;  //  relative:  add sem_op to value
    semaphore.sem_flg = 0;   
    semop(semid, &semaphore, 1);
}


//  decrement operation
void sem_wait(int semid, int val)
{
    struct sembuf semaphore;
    semaphore.sem_num = 0;
    semaphore.sem_op = (-1*val);  //  relative:  add sem_op to value
    semaphore.sem_flg = 0;  
    semop(semid, &semaphore, 1);
}


//  to increase semaphore value by 1
void increase(int sem)
{
    sem_signal(sem, 1);
}

//  to decrease semaphore value by 1
void decrease(int sem)
{
    sem_wait(sem, 1);
}


void* printThis(void* typ)
{
    int i, j;
    char* str = (char) typ=='a'?"abcdefghij":"01234567890";  //  2 types of contents
    for (i = 0; i < 100; ++i)  //  100 separate print jobs
    {
        decrease(s);  //  prevent other threads from entering critical section
        
        //  check whose turn is it
        if (    ((char)typ == 'a' && currentTurn != 'a')
             || ((char)typ == 'n' && currentTurn != 'n') )
        {
            //  this thread must wait other one to finish
            --i;
            increase(s);
            continue;
        }
        
        for (j = 0; j < 10; ++j)  //  of 10 pages each
        {
            printf("%c", str[j]);  //  each character represents a page
        }
        
        //  change current turn
        currentTurn = currentTurn == 'a' ? 'n' : 'a';
        
        increase(s);  //  allow other threads to enter critical section
    }
    
    return NULL;
}



int main(int argc, char* argv[])
{
    printf("I am the NO-SYNC printer manager\n");
    setvbuf(stdout, (char*)NULL, _IONBF, 0);  //  no-buffer printf
    
    create(argv);  //  create a semaphore for mutual exclusion
    
    pthread_t a, n;  //  create two threads (a thread for each set of documents)
    pthread_create(&a, NULL, printThis, (void*)'a');
    pthread_create(&n, NULL, printThis, (void*)'n');
    
    //  wait for threads to finish
    pthread_join(a, NULL);
    pthread_join(n, NULL);
    
    semctl(s, 0, IPC_RMID, 0);  //  removing the created semaphore
    
    return 0;
}
    
