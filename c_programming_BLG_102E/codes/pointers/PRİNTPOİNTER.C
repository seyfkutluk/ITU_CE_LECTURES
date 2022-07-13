#include<stdio.h>
#include<stdlib.h>

int main()
{
	int * p;
	&p=5;
	printf("%d",*p);
	return EXIT_SUCCESS;
}
