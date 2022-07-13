#include<stdio.h>
#include<stdlib.h>
#define SUTUN  5

// printing all the array in the screen
void deger_yazdir(int satir,double array_1[][SUTUN])
{
	for(int i=0; i< satir; i++)
	{
		for(int j=0; j< SUTUN;j++)
		{
			printf("%lf",array_1[i][j]);
		}
		printf("\n");
	}
}

// finding the given number and the places that the number is in
void findintwodimaaray(int satir, double array_1[][SUTUN], double finded)
{
		for(int i=0; i< satir; i++)
	{
		for(int j=0; j< SUTUN;j++)
		{
			if(array_1[i][j]==finded)
			{
				printf("The number has been finded in %d, %d ",i,j);
				return;
			}
		}
	}
	printf("The number has not been finded");

	
}

int main()
{
	double dizi[][SUTUN] = {{1,2,3,4,5},
                        {6,7,8,9,10},
                        {11,12,13,14,15},
                        {16,17,18,19,20},
                        {21,22,23,24,25}};
    int satir=5;
    deger_yazdir(satir, dizi);
    
    int searchednumber=4;
	findintwodimaaray(satir, dizi, searchednumber);                 
                          
	return 0;
}

