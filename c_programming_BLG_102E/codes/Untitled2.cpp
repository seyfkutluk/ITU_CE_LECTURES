#include <stdio.h>
//You cannot use the string library

#define MAX_STRING_SIZE 20


void append(char* a, char* b)
{
    //fill the function body. Do not change the arguments and the return parameter
    int count_a=0;
    int count_b=0;
    while(a[count_a] != '\0'){
    	count_a++;
	}
    while(b[count_b] != '\0'){
    	count_b++;
	}

	if(count_a+count_b>20){printf("Error");
	}
	
    a[count_a]=' ';
    count_a++;
    
    
	for(int c=0;c<count_b;c++)
	{
		*(a+count_a)= *(b+c);
		count_a++;
	}
	printf("%s",a);
    return;
}

int main()
{
	char a[MAX_STRING_SIZE];
	char b[MAX_STRING_SIZE];
	scanf("%s",a);
	scanf("%s",b);
	append(a,b);
	return 0;
}
