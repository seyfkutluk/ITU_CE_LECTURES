#include <stdio.h>
#include <stdlib.h>
void Asal_sayi_kontrolu (int a){
 int bolenler = 0;
 for(int i = 2;i < a;i++){
 if(a % i == 0){
 	if(a!=i){
 		 bolenler++;
	 }

 }
 }
 if(bolenler == 0){
 printf("Asaldir \n");
 }
 else{
 printf("Asal degildir\n");
 }
}
int main(){
 int sayi;
 printf("Asal sayi kontrolu icin bir sayi giriniz: ");
 scanf("%d",&sayi);
 Asal_sayi_kontrolu(sayi);
 return EXIT_SUCCESS;
}
