#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#define SEN 500



int stringlength(char* string)
{
	int length;
	for(int i=1; string[i]!='\0'; i++)
	{
		length++;
	}
	return length;
}

char * stringappend(char* a, char* b, char* c,int value,int value1,int s)
{
	
    printf("%d\n",stringlength(a)); 
	printf("%d\n",stringlength(b));
	int lengtha=stringlength(a);
	int lengthb=stringlength(b);
	for(int i=value; i<value+value1;i++){
		a[i]=b[i-value+1];
	}
	for(int i=0; a[i]!='\0';i++){
		c[i]=a[i];
	}
	return c;

}
int main(){
	char string[SEN];
	fgets(string,sizeof(string),stdin);
		char string1[SEN];
	fgets(string1,sizeof(string1),stdin);
    strlen(string);
    strlen(string1);


    char *son;
	stringappend(string,string1,son);
      strlen(string);
    puts(son);
  
	return EXIT_SUCCESS;
}
