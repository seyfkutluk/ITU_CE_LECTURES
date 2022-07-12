#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/msg.h>

int main(int argc, char* argv[])
{
    //  convert input argument to long integer(id of the queue)
    int msqid = strtol(argv[1], NULL, 10);
    
    //  remove the message queue
    if (msgctl(msqid, IPC_RMID, 0) == 0)
        printf("Queue %d removed successfully\n", msqid);
    else
        printf("Failed to remove queue %d!\n", msqid);
}
