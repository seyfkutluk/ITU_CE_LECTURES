#include<stdio.h>
#include<stdlib.h>

double ortalama(double * arr, int size)
{
	double toplam=0;
	double number=0;
	for(int i=0;arr[i]!='\0';i++)
	{
		toplam=toplam+arr[i];
		number++;
		
	}
	double ortalama=toplam/number;
	return ortalama;
	
	
}

int main()
{
	double array_1[] ={1,2,3,4,5,6,7,8};
	int length;
	for(int i=0; array_1[i]!='\0'; i++)
	{
		length++;
	}
	printf("%d\n",length);

	printf("%lf",ortalama(array_1,length));
	return 0;
	
}
