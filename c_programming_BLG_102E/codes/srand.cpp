#include <stdio.h>
#include <stdlib.h>
#include<time.h>
int main()
{
	srand(time(NULL));
	int ust_sinir=10;
	printf("%d ",rand()%10);// to make it random between 0 to 9 we have to find %10 so the
	                // to make it in the range that you want (rand() % (�st s�n�r - alt s�n�r + 1)) + alt s�n�r
	


	return 0;

}
