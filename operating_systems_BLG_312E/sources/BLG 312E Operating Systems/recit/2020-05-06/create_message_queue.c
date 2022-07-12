#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/msg.h>

#include <errno.h>
#include <string.h>

#define KEYMQ 500  //  key

int main()
{
    //  create a message queue
    int msqid = msgget(KEYMQ, IPC_CREAT|0777);
    if (msqid >= 0)
        printf("Queue %d is created.\n", msqid);
    else
    {
        printf("Queue creation failed!\n");
        printf("%s\n", strerror(errno));
    }
}
