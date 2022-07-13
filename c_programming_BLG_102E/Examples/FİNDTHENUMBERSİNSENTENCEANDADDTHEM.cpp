#include <stdio.h>
#include <stdlib.h>
char text[128];
int main(void) {
  int i, j, k;
  int result = 0;
  char temp[8];
  printf("Input Sentences with positive integers:\n");
  
  scanf("%s", text); // SCANNÝNG THE TEXT
  
  i = 0;
  while (text[i]) {    // ÝF THERE ÝS ANYTHÝNG ÝN TEXT THE LOOP WÝLL BEGÝN
    for (;
      (text[i] < '0' || '9' < text[i]) && text[i]; i++); // ÝF THE TEXT ÝS SMALLER THAN 0 OR BÝGGER THAN 9 THEN ÝNCREASE THE Ý

    if ('0' <= text[i] && text[i] <= '9') {    // ÝF THE THE TEXT[Ý] ÝS BETWEEN 0 AND 9 THEN GO ÝNSÝDE
      for (j = 0; '0' <= text[i] && text[i] <= '9'; j++, i++) {
        temp[j] = text[i];
      }

      temp[j] = '\0';
      result += atoi(temp);
    }
  }
  printf("\nSum of all numerical values embedded in a sentence:\n");
  printf("%d\n", result);
  return 0;
}

