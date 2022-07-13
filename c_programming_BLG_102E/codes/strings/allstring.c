#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#define SEN 500

// find length of a string
int stringlength(const char string[SEN]){
	int length;
		for(int i=0; string[i]!='\0'; i++)
	{
		length++;
	}
	return length;

}

// copy the the second string to the first string
void stringcopy(char string[SEN],const char string_1[SEN]){
	int length_1=stringlength(string_1);
	for(int j=0; j<length_1;j++){
	
				string[j]=string_1[j];
			

	}
}

// append the second string to the first string
void stringcat(char string[SEN], const char string_1[SEN]){
	int length=stringlength(string);
	int length_1=stringlength(string_1);
	for(int i=length; i<length+length_1-1;i++){
		string[i]=string_1[i-length];
		
	}
}

// compare two strings if same return0 else return 1
int stringcmp(const char string[SEN], const char string_1[SEN]){
	for(int i=0; string[i]!='\n';i++){
		if(string[i]!=string_1[i]){
			return 1;
		}
	}
	return 0;
}

int main(){
	char string[SEN],string_1[SEN];
	printf("please enter the string you want to scan  ");
	fgets(string, sizeof(string), stdin);
	fgets(string_1, sizeof(string_1), stdin); // \n e kadar okur
//	printf("%d\n",sizeof(string));
//	printf("%d\n",stringlength(string));
//	printf("%d\n",strlen(string));


  //  stringcopy(string,string_1);  // copy string without using string library
  //  strcpy(string,string_1);     // copy string using string library
  
//	stringcat(string,string_1); 
//  strcat(string,string_1);


//   printf("%d\n",stringcmp(string,string_1));
//  printf("%d\n",strcmp(string,string_1));

	puts(string);   // printf() gibidir sadece sonuna otomatik olarak \n koyar.
	puts(string_1);
	
	return EXIT_SUCCESS;
}


