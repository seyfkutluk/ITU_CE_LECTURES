#include <stdio.h>	//  printf
#include <unistd.h>	//  getpid

int main(int argc, char* argv[])
{
    printf("\nSlave started working ... PID: %d \n", getpid());
    printf("Name of the program :%s \n", argv[0]);
    printf("The first parameter of the program:%s \n", argv[1]);
    printf("The second parameter of the program:%s \n", argv[2]);
    return 0;
}