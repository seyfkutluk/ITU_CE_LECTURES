#include <stdio.h>
#include <stdlib.h>
#define SUTUN 5
void deger_ara(int satir,int dizi[][SUTUN],int aranan_deger){
 for(int i = 0;i < satir;i++){
 for(int j = 0;j < SUTUN;j++){
 if(dizi[i][j] == aranan_deger){
 printf("Dizide aradiginiz deger (%d) bulunmaktadir\n",aranan_deger);
 return;
 }
 }
 }
 printf("Dizide aradiginiz deger (%d) bulunmamaktadir\n",aranan_deger);
}
int main(){
 int satir = 5;
 int dizi[][SUTUN] = {{1,2,3,4,5},
 {6,7,8,9,10},
 {11,12,13,14,15},
 {16,17,18,19,20},
 {21,22,23,24,25}};
 int aranan_deger;
 printf("Dizide aramak istediginiz degeri giriniz: ");
 scanf("%d",&aranan_deger);
 deger_ara(satir,dizi,aranan_deger);
 return EXIT_SUCCESS;
}

