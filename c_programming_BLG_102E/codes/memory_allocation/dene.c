#include <stdio.h>
#include <stdlib.h>
void doldur(int *dizi, int size)
{
 for (int i = 0; i < size; i++)
 {
 printf("%d. elemani giriniz: ", i + 1);
 scanf("%d", dizi + i);
 }
}
void print(int *dizi, int size)
{
 for (int i = 0; i < size; i++)
 {
 printf("%d. elemani: %d\n", i + 1, *(dizi + i));
 }
}
int main()
{
 int size = 10;
 int *dizi = (int *)malloc(size * sizeof(int));

 doldur(dizi, size);
 print(dizi, size);
 free(dizi);
 dizi = NULL;
 return EXIT_SUCCESS;
}
