#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <sys/types.h>
#include <signal.h>  //  sigaction
#include <sys/errno.h>


#define SEMKEY_AB 5
#define SEMKEY_C 6



//  increment operation
void sem_signal(int semid, int val)
{
    struct sembuf semaphore;
    semaphore.sem_num = 0;
    semaphore.sem_op = val;  //  relative:  add sem_op to value
    semaphore.sem_flg = 0;   
    semop(semid, &semaphore, 1);
}

//  increment operation using two semaphores
void sem_multi_signal(int semid, int val, int nsems)
{
    struct sembuf semaphore[2];
    int i;
    for (i = 0; i < nsems; ++i)
    {
        semaphore[i].sem_num = i;
        semaphore[i].sem_op = val;
        semaphore[i].sem_flg = 0;
    }
    
    //  TWO Operations are performed on SAME SEMAPHORE SET
    semop(semid, semaphore, 2);
    for (i = 0; i < nsems; ++i)
    {
        printf("SIGNAL : SEM %d IS NOW: .... %d\n", i, semctl(semid, i, GETVAL, 0));
    }
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


//  decrement operation using two semaphores
void sem_multi_wait(int semid, int val, int nsems)
{
    struct sembuf semaphore[2];
    int i;
    for (i = 0; i < nsems; ++i)
    {
        semaphore[i].sem_num = i;
        semaphore[i].sem_op = (-1 * val);
        semaphore[i].sem_flg = 0;
    }

    //  TWO Operations are performed on SAME SEMAPHORE SET
    semop(semid, semaphore, 2);
    for (i = 0; i < nsems; ++i)
    {
        printf("WAIT : SEM %d IS NOW: .... %d\n", i, semctl(semid, i, GETVAL, 0));
    }
}



//  signal handling function
void mysignal(int signum)
{
    printf("Received signal with num=%d\n", signum);
}

void mysigset(int num)
{
    struct sigaction mysigaction;
    mysigaction.sa_handler = (void*) mysignal;

    //  using the signal-catching function identified by sa_handler
    mysigaction.sa_flags = 0;

    //  sigaction() system call is used to change the action taken by
    //a process on receipt of a specific signal(specified with num)
    sigaction(num, &mysigaction, NULL);
}


int main()
{
    //  signal handler with num=12
    mysigset(12);
    int semAB, semC, c[2];
    int f = 1;
    int i, myOrder;
    
    //  creating 2 children processes
    for (i = 0; i < 2; ++i)
    {
        if (f > 0)
            f = fork();
        if (f == -1)
        {
            printf("fork error ....\n");
            exit(1);
        }
        if (f == 0)
            break;
        else
            c[i] = f;  //  get pid of each child process
    }
    
    if (f != 0)  //  parent process
    {
        printf("PARENT is starting to CREATE RESOURCES...\n");
        //  creating a set of 2 semaphores and setting their values as 1
        semAB = semget(SEMKEY_AB, 2, 0700|IPC_CREAT);
        if (semAB == -1)
            printf("SEMGET ERROR on SEM GET, Error Code: %d\n", errno);
        if (semctl(semAB, 0, SETVAL, 1) == -1)
            printf("SEMCTL ERROR on SEM A, Error Code %d\n", errno);
        if (semctl(semAB, 1, SETVAL, 1) == -1)
            printf("SEMCTL ERROR on SEM B, Error Code: %d\n", errno);
        
        printf("PARENT: SEM A is NOW .... %d\n", semctl(semAB, 0, GETVAL, 0));
        printf("PARENT: SEM B is NOW .... %d\n", semctl(semAB, 1, GETVAL, 0));
        
        //  creating another semaphore and setting its value as 0
        semC = semget(SEMKEY_C, 1, 0700|IPC_CREAT);
        semctl(semC, 0, SETVAL, 0);
        printf("PARENT: SEM C is NOW .... %d\n", semctl(semC, 0, GETVAL, 0));
        sleep(2);
        printf("PARENT is starting CHILDREN PROCESSES ......\n");
        for (i = 0; i < 2; ++i)
            kill(c[i], 12);
        sleep(5);
        sem_wait(semC, 2);  //  decrease sem value by 2 (i.e., wait for all children)
        printf("PARENT: SEM C is NOW .... %d\n", semctl(semC, 0, GETVAL, 0));
        printf("PARENT: Child processes has done, resources are removed back.\n");
        semctl(semC, 0, IPC_RMID, 0);
        semctl(semAB, 0, IPC_RMID, 0);
        exit(0);
    }
    else  //  child process
    {
        myOrder = i;
        printf("CHILD %d: waiting permission from PARENT ....\n", myOrder);
        
        //  wait for a signal
        pause();
        
        //  returning the sem_ids associated with SEMKEY_AB and SEMKEY_C
        semAB = semget(SEMKEY_AB, 2, 0);
        semC = semget(SEMKEY_C, 1, 0);
        printf("CHILD %d has permission from PARENT, is starting ....\n", myOrder);
        printf("CHILD %d: DECREASING sem AB.\n", myOrder);
        
        //  decrease two semaphores in the set specified by semAB by 1
        sem_multi_wait(semAB, 1, 2);
        printf("CHILD %d: I am in the CRITICAL REGION.\n", myOrder);
        sleep(5);
        
        //  increase two semaphores in the set specified by semAB by 1
        sem_multi_signal(semAB, 1, 2);
        
        //  increase the third semaphore by 1
        sem_signal(semC, 1);
    }
    
    return 0;
}
