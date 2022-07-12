#include <unistd.h>
#include <sys/wait.h>
#include <stdlib.h>
#include <stdio.h>

#define NOFSEND 3  //  number of messages
#define SOFSEND 4  //  size of messages


int main()
{
    int c, p[2], i;
    char send[NOFSEND][SOFSEND] = {"Fee\0", "Faa\0", "Foo\0"};  //  messages
    char rec[SOFSEND];  //  buffer for receiver
    
    //  creating pipe
    if (pipe(p) < 0)
        printf("Can't create a pipe.\n");
    
    if ( (c=fork()) < 0)
        printf("Can't fork.\n");
    else if (c > 0)
    {
        //  parent process
        close(p[0]);  //  closing reading end
        for (i = 0; i < NOFSEND; ++i)
        {
            if (write(p[1], send[i], SOFSEND) < 0)  //  sending messages
                printf("M: Can't write %d\n", i+1);
            else
                printf("M: I wrote %d.\n", i+1);
        }
        wait(NULL);  //  waiting for child to terminate
        exit(0);
    }
    else
    {
        //  child process
        sleep(1);  //  waiting for a second
        close(p[1]);  //  closing writing end
        for (i = 0; i < NOFSEND; ++i)
        {
            if (read(p[0], &rec, SOFSEND) < 0)
                printf("C: Can't read %d\n", i+1);
            else
                printf("C: I read %s\n", rec);
        }
    }
}
