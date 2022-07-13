#include<stdio.h>
#include<stdlib.h>
#define MAX 500

int toplam(int * ptr,int size){
	int all;
	for(int i=0; i<size;i++){
		scanf("%d",(ptr+i));
		all+= *(ptr+i);
	}
	return all;
}

void printadress(int * ptr,int size){
		for(int i=0;i<size;i++)
	{
		printf("%p\n",ptr+i);
	}
	
}

int main(){
	int size;
	printf("Dizinin buyuklugunu giriniz");
	scanf("%d",&size);
	int* ptr=(int*)malloc(size*sizeof(int));
	
	printadress(ptr,size);

	
	int newsize;
	printf("Enter the new size");
	scanf("%d",&newsize);
	
	ptr=(int*)realloc(ptr,newsize);
	
    printadress(ptr,newsize);
	
//    printf("%d",toplam(ptr,size));
	
	free(ptr);   // free the malloc is necessary
	ptr=NULL;    // after we freed the pointer we need to equalize it to NULL
	

	return EXIT_SUCCESS;
}
