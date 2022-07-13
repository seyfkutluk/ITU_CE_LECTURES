#include <stdio.h>
#include <stdlib.h>
int main()
{
	int number=rand();   // if you compile it more times the result is same to make it different you have to use 
	                    //  you ya-have to use srand() from <stdlib.h>    or time() form <time.h>
	printf("%d\n",number);

	return 0;

}
