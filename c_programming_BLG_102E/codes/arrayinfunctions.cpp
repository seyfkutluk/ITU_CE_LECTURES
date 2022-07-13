#include <stdio.h>
#include <stdlib.h>
double ortalama(int arr[], int size){
 int toplam = 0;
 for(int i = 0; i < size;i++){
 toplam += arr[i];
 printf("%d",arr[i]);
 }
 double ortalama_sonuc = toplam / size;
 return ortalama_sonuc;
}
int main(){
 int array_1[] = {1,2,3,4,5,6,7,8,9,10};

 double array_ortalama_degeri = ortalama(array_1, 10);
 printf("array ortalamasi: %lf\n",array_ortalama_degeri);
 return EXIT_SUCCESS;
}
