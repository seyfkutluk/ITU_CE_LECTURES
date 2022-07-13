#include<stdio.h>
#include<stdlib.h>
int main()
{
	int array_1[]={1,2,3,4,5,6,7,6,6,6,7,8};
	int length=0;
	for(int i=0;array_1[i]!='\n';i++)
	{
		length++;
	}
	printf("%d",length);
	return 0;
}
