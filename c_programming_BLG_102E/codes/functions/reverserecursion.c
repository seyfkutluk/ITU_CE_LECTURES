#include <stdio.h>
void reversesentence()
{
	char c;
	scanf("%c",&c);
	if(c != '\n')
	{
		reversesentence();
		printf("%c",c);
	}
	
}
int main()
{
	printf("Enter the sentence;");
	reversesentence();
}
