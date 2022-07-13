#include <stdio.h>

int main()
{
	int number=100;
	for(int i=0;i<number;i++)
	{
		if(i%2==0)
		{
			continue;    // makes it possible to pass some values so its important
		}
		printf("%d\n",i);
	}
	return 0;
}
