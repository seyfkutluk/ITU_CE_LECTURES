#include<stdio.h>          /* Pre processor file for standard input output*/

#include<conio.h>        /* Pre processor file for console input output*/

#include<string.h>       /* Pre processor file for string predefined functions */

void append(char *a,char *b);     /* Declaration of function */

int main(void)                  

{

char a[20],b[20];             /*Declaration of strings a and b */

printf("Enter 1st string:");       /* Prompts the screen */

scanf("%s",a);                         /* Takes string input and store it in variable a */

printf("Enter 2nd string:");    /* Prompts the screen */

scanf("%s",b);                     /* Takes string input and store it in variable a */

append(a,b);              /* Calling of function */
return 0;

}

void append(char *a,char *b)        /* Function Definition starts */

{

if(strlen(a) + strlen(b)>=20)        /* Checking whether string resulting in append(a,b) exceeds 20 or not. */

printf("Error");                                 /* If exceeds 20 display error message .*/

else

{                                               /* if string doesn't exceed length of 20 */

a=strcat(a," ");                     /* appending blank symbol to a */

a=strcat(a,b);                     /* appending string b to string a */

printf("Appended string is:%s",a);   /* printing Appended string. */

}

}
