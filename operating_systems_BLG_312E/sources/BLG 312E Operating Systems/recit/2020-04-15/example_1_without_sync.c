#include <stdio.h>
#include <pthread.h>

void* printThis(void* typ)
{
    int i, j;
    char* str = (char) typ=='a'?"abcdefghij":"01234567890";  //  2 types of contents
    for (i = 0; i < 100; ++i)  //  100 separate print jobs
    {
        for (j = 0; j < 10; ++j)  //  of 10 pages each
        {
            printf("%c", str[j]);  //  each character represents a page
        }
    }
    
    return NULL;
}

int main()
{
    printf("I am the NO-SYNC printer manager\n");
    setvbuf(stdout, (char*)NULL, _IONBF, 0);  //  no-buffer printf
    pthread_t a, n;  //  create two threads (a thread for each set of documents)
    pthread_create(&a, NULL, printThis, (void*)'a');
    pthread_create(&n, NULL, printThis, (void*)'n');
    
    //  wait for threads to finish
    pthread_join(a, NULL);
    pthread_join(n, NULL);
    return 0;
}
    
