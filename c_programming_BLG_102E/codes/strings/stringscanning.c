#include<stdio.h>
#include<stdlib.h>
#define SEN 500

int main(){
	char string[100];
	printf("please enter the string you want to scan");
	scanf("%s",string);  // scanf girdiyi sadece bo�luk olarak g�rd��� noktaya kadar al�r bu 
	// sorunu ��zmek i�in 
	printf("%s",string);
	return EXIT_SUCCESS;
}

