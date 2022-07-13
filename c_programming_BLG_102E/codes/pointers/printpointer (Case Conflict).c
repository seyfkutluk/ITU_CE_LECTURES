#include<stdio.h>
#include<stdlib.h>

int main()
{
	int number=5;
	
	int * p;
    p=&number;
	printf("%d\n",*p);
	
	
	int *c=&number;    // the perfect one to use
	printf("%d\n",*c);
	
	int *k;
	k=&number;
	printf("%d",*k);
	return 0;
}
