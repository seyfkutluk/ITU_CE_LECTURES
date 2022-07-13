#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main()
{
 char string[100] = "Dennis Ritchie";
 int uzunluk = strlen(string);
 printf("%s'in uzunlugu: %d\n", string, uzunluk);
 char string2[100];
 strcpy(string2, string);
 puts(string2);
 char string3[100] = "My name is ";
 strcat(string3, string);
 puts(string3);
 char compare1[100] = "abcd";
 char compare2[100] = "abcd";
 char compare3[100] = "wxyz";
 // 0 donme durumu
 printf("%d\n", strcmp(compare1, compare2));
 // negatif donme durumu
 printf("%d\n", strcmp(compare1, compare3));
 // pozitif donme durumu
 printf("%d\n", strcmp(compare3, compare1));
 return EXIT_SUCCESS;
}
