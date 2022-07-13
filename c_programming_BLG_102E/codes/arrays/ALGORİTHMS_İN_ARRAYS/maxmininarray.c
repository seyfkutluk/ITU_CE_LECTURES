#include<stdio.h>
#include<stdlib.h>
#define SIZE 10

void printarray(int array[], int size){
	for(int i=0;i<size;i++){
		printf("%d ",array[i]);
	}
	printf("\n");
}

int max_deger(int array[], int size)
{
	int maxnumber=array[0];
	for(int i=0; i<size; i++){
		if(maxnumber<array[i]){
			maxnumber=array[i];
		}
	}
	return maxnumber;
}

int min_deger(int array[], int size)
{
	int minnumber=array[0];
	for(int i=0; i<size; i++){
		if(minnumber>array[i]){
			minnumber=array[i];
		}
	}
	return minnumber;
}

void kucukten_buyuge(int array[], int size){
	for(int i=0; i<size-1;i++){
		for(int j=0; j<size-i-1;j++){
			if(array[j]>array[j+1]){
				int changingvalue= array[j];
				array[j]=array[j+1];
				array[j+1]=changingvalue;
			}
		}
	}
	
}

void buyukten_kucuge(int array[], int size){
	for(int i=0; i<size-1;i++){
		for(int j=0; j<size-i-1; j++){
			if(array[j]<array[j+1]){
				int changingvalue=array[j+1];
				array[j+1]=array[j];
				array[j]=changingvalue;
				
			}
		}
	}
}

int main()
{
	int array[SIZE];
	printf("Please enter the array numbers");
	for(int i=0;i<SIZE;i++)
	{
		scanf("%d",&array[i]);
	}
	printf("%d\n",max_deger(array, SIZE));
	printf("%d\n",min_deger(array, SIZE));
	
	kucukten_buyuge(array,SIZE);
	printarray(array,SIZE);
	buyukten_kucuge(array,SIZE);
	printarray(array,SIZE);
	

	return 0;
	
}
