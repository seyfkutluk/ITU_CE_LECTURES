#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/msg.h>

#define MESSAGE_SIZE 256  //  message size


//  return immediately if no message of the requested type is in the queue
#define MESSAGE_FLAG IPC_NOWAIT


struct msgbuf  //  message buffer
{
    long mtype;  //  message type
    char mtext[MESSAGE_SIZE];  //  message
};


int main(int argc, char* argv[])
{
    //  convert input argument to long integer(id of the message queue)
    int msqid = strtol(argv[1], NULL, 10);
    
    //  convert input argument to long integer(message type)
    long msgtyp = strtol(argv[2], NULL, 10);
    
    //  create a message buffer
    struct msgbuf msgp;
    
    //  read the message
    if (msgrcv(msqid, &msgp, MESSAGE_SIZE, msgtyp, MESSAGE_FLAG) > 0)
        printf("Received: %s of type=%ld.\n", msgp.mtext, msgp.mtype);
    else
        printf("Cannot receive anything!\n");
}
    
