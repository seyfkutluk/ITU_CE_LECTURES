#include<stdio.h>
#include<stdlib.h>
#define MAX 200

struct students{
	char isim[20];
	char soyisim[20];
	int numara;
};

typedef struct{
	char isim[20];
	char soyisim[20];
	int numara;
}OTHERSTUDENTS;

int main(){
	struct students student1;
	OTHERSTUDENTS
	printf("lütfen isim, soyisim, ve numara giriniz: ");
	scanf("%s %s", student1.isim, student1.soyisim);  // & kullanýlmadý çünkü array pointerdýr stringer
	scanf("%d",&student1.numara); // & kullanýldý
	
	printf("%s, %s, %d",student1.isim,student1.soyisim,student1.numara);
	return EXIT_SUCCESS;
}
