#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/msg.h>

#define MESSAGE_SIZE 256  //  message size

struct msgbuf  //  message buffer
{
    long mtype;  //  message type
    char mtext[MESSAGE_SIZE];  //  message
};


int main(int argc, char* argv[])
{
    //  convert input argument to long integer(id of the message queue)
    int msqid = strtol(argv[1], NULL, 10);
    
    //  create message buffer
    struct msgbuf msgp;
    
    //  convert input argument to long integer (message type)
    msgp.mtype = strtol(argv[2], NULL, 10);
    strcpy(msgp.mtext, argv[3]);  //  read message from console
    
    //  send message via message queue
    if (msgsnd(msqid, &msgp, MESSAGE_SIZE, 0) == 0)
        printf("Sent\n");
    else
        printf("Cannot send!\n");
}
