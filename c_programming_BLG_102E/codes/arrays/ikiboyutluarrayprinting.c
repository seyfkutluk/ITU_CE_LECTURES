#include<stdio.h>
#include<stdlib.h>

int main()
{
	double array_1[3][4]={{1,2,3,4},{5,6,7,8},{9,10,11,12}};
	for(int i=0;i<3;i++)
	{
		for(int j=0;j<4;j++)
		{
			printf("%.1lf",array_1[i][j]);
		}
		printf("\n");
	}
}
