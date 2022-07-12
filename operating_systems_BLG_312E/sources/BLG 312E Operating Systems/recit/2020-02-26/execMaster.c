#include <stdio.h>	//  printf
#include <unistd.h>	//  fork, exec
#include <stdlib.h>	//  exit
#include <errno.h>	//  errno
#include <string.h>	//  strerror
#include <sys/wait.h>	//   wait

int main(void)
{
    printf("\nMaster is working: PID:%d \n", getpid());
    int f = fork();

    if (f == 0)  //  child process
    {
        printf("\n This is child... PID: %d\n", getpid());
        //  execute the slave process
        execlp("./execSlave", "./execSlave", "test1", "test2", (char*)NULL);

        //  exec returns only when there is an error
        printf("\n %s\n", strerror(errno));
    }
    else  //  parent process
    {
        //  wait until child process has exited
        wait(NULL);
        exit(0);
    }
    return 0;
}