#include<stdio.h>
#include<stdlib.h>
#define SEN 500

int main(){
	char string[100];
	printf("please enter the string you want to scan");
	scanf("%s",string);  // scanf girdiyi sadece boþluk olarak gördüðü noktaya kadar alýr bu 
	// sorunu çözmek için 
	printf("%s",string);
	return EXIT_SUCCESS;
}

