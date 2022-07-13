#include<stdio.h>
#include<stdlib.h>

int main(){
	int length=0;
	char c[]="merhaba";
	char k[]={'m','e','r','h','a','b','a'};
	printf("%s\n",c);
	printf("%s\n",k);
	

	for(int i=0; c[i]!='\0';i++){
		printf("%c",c[i]);
		length++;
	}
	
	
//	printf("%d",length);
	
	
	return 0;
}
