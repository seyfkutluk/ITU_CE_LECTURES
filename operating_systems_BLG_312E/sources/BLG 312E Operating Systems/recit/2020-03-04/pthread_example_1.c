#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>


void* print_message_function(void* ptr)
{
    char* message;
    
    //  wait for a second
    sleep(1);
    
    //  cast ptr to char* and print it
    message = (char*) ptr;
    printf("\n%s \n", message);
    
    //  terminating the thread
}

int main()
{
    pthread_t thread1;
    pthread_t thread2;
    pthread_t thread3;
    char* message1 = "Hello ";
    char* message2 = "World ";
    char* message3 = "!...";
    
    //  create 3 threads with starting from print_message_function
    //and arguments message1, message2, message3
    if (pthread_create(&thread1, NULL, print_message_function, (void*)message1))
    {
        fprintf(stderr, "pthread_create failure for thread 1!\n");
        exit(1);
    }
    if (pthread_create(&thread2, NULL, print_message_function, (void*)message2))
    {
        fprintf(stderr, "pthread_create failure for thread 1!\n");
        exit(1);
    }
    if (pthread_create(&thread3, NULL, print_message_function, (void*)message3))
    {
        fprintf(stderr, "pthread_create failure for thread 1!\n");
        exit(1);
    }
    
    //  make process not terminate until all spawned threads are finished
    pthread_exit(NULL);
}
    
