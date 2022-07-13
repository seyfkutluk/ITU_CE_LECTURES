#include<stdio.h>
#include<stdlib.h>

int main()
{
	int x[4];
	printf("Please enter 4 array element ");
	for(int i=0;i<4 ;i++){
		scanf("%d",x+i);
	}
	for(int i=0;i<4 ;i++){
			printf("%d   %p\n",*(x+i), x+i);
	}
	return 0;
}
