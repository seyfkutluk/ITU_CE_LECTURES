#include<stdio.h>

int main()
{
	int c=1,b;
	printf("How many steps do you want to go wtih");
	scanf("%d",&b);
	int a=0;
	for(a;a<b;a++)
	{
		printf("%d\n",c);
		int l;
		l=c;
		c=l+c;
	
		
	}
	return 0;
}
