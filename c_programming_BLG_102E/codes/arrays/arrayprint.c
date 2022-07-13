#include<stdio.h>
#include<stdlib.h>
int main()
{
	int array_1[]={1,2,3,4,5,6,7,6,6,6,7,8};
	int length=0;
	int* array_2;
	for(int i=0;array_1[i]!='\0';i++)
	{
	
		length++;

	}
	printf("%d\n",length);
	for(int i=0;i<length;i++)
	{
		printf("%d",array_1[i]);
	}
	return 0;
}
