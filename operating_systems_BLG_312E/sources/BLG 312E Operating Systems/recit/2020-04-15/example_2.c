#include <sys/ipc.h>
#include <sys/sem.h>
#include <sys/types.h>
#include <pthread.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


#define H_COUNT 6
#define O_COUNT 3



//  constant key values
#define MUTEXKEY 100
#define OXYGENKEY 101
#define HYDROGENKEY 102


//  to create a semaphore for mutual exclusion(value=1)
int oxygenCounter = 0;
int hydrogenCounter = 0;
int mutexSemaphore;  
int oxyQueue;  //  semaphore on which oxywgen atoms(threads) wait
int hydroQueue;  //  semaphore on which hydrogen atoms(threads) wait
int bondCount = 0;  //  counter of number of h2o molecoles formed



void create(char* argv[])
{
    int ret;
   
   
    int semKey = MUTEXKEY;
    mutexSemaphore = semget(semKey, 1, 0700|IPC_CREAT);
    ret = semctl(mutexSemaphore, 0, SETVAL, 1);  //  semaphore value = 1

    semKey = OXYGENKEY;
    oxyQueue = semget(semKey, 1, 0700|IPC_CREAT);
    semctl(oxyQueue, 0, SETVAL, 0);  //  semaphore value = 0
    
    semKey = HYDROGENKEY;
    hydroQueue = semget(semKey, 1, 0700|IPC_CREAT);
    semctl(hydroQueue, 0, SETVAL, 0);  //  semaphore value = 0
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


void bond()
{
    bondCount += 1;
    printf("Number of bonds:%d\n", bondCount);
}


void* oxygenfunc(void* arg)
{
    sem_wait(mutexSemaphore, 1);
    printf("O thread in CS\n");
    oxygenCounter += 1;
    
    if (hydrogenCounter >= 2)
    {
        sem_signal(hydroQueue, 2);
        hydrogenCounter -= 2;
        sem_signal(oxyQueue, 1);
        oxygenCounter -= 1;
    }
    else
    {
        sem_signal(mutexSemaphore, 1);
    }
    
    sem_wait(oxyQueue, 1);
    bond();
    
    sem_signal(mutexSemaphore, 1);
}


void* hydrogenfunc(void* arg)
{
    sem_wait(mutexSemaphore, 1);
    printf("H thread in CS\n");
    
    hydrogenCounter += 1;
    
    if (hydrogenCounter >= 2 && oxygenCounter >= 1)
    {
        sem_signal(hydroQueue, 2);
        hydrogenCounter -= 2;
        sem_signal(oxyQueue, 1);
        oxygenCounter -= 1;
    }
    else
    {
        sem_signal(mutexSemaphore, 1);
    }
    
    sem_wait(hydroQueue, 1);
    //bond();
}
    



int main(int argc, char* argv[])
{
    int i;
    
    setvbuf(stdout, (char*)NULL, _IONBF, 0);  //  no-buffer printf
    printf("H2O Example\n");
    
    
    create(argv);  //  create required semaphores
    
    pthread_t h[H_COUNT];
    pthread_t o[O_COUNT];
    
    //  create threads
    for (i = 0; i < H_COUNT; ++i)
    {
        pthread_create(&h[i], NULL, hydrogenfunc, NULL);
    }
    for (i = 0; i < O_COUNT; ++i)
    {
        pthread_create(&o[i], NULL, oxygenfunc, NULL);
    }
    
    
    //  wait for threads to finish
    for (i = 0; i < H_COUNT; ++i)
    {
        pthread_join(h[i], NULL);
    }
    for (i = 0; i < O_COUNT; ++i)
    {
        pthread_join(o[i], NULL);
    }
    printf("Finished all joins\n");
    printf("Value of oxyQueue:%d\n", semctl(oxyQueue, 0, GETVAL));
    printf("Value of hydroQueue:%d\n", semctl(hydroQueue, 0, GETVAL));
    

    //  remove created semaphores
    semctl(mutexSemaphore, 0, IPC_RMID, 0);
    semctl(oxyQueue, 0, IPC_RMID, 0);
    semctl(hydroQueue, 0, IPC_RMID, 0); 
    
    return 0;
}
    
