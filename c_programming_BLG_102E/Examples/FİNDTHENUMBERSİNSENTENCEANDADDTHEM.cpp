#include <stdio.h>
#include <stdlib.h>
char text[128];
int main(void) {
  int i, j, k;
  int result = 0;
  char temp[8];
  printf("Input Sentences with positive integers:\n");
  
  scanf("%s", text); // SCANN�NG THE TEXT
  
  i = 0;
  while (text[i]) {    // �F THERE �S ANYTH�NG �N TEXT THE LOOP W�LL BEG�N
    for (;
      (text[i] < '0' || '9' < text[i]) && text[i]; i++); // �F THE TEXT �S SMALLER THAN 0 OR B�GGER THAN 9 THEN �NCREASE THE �

    if ('0' <= text[i] && text[i] <= '9') {    // �F THE THE TEXT[�] �S BETWEEN 0 AND 9 THEN GO �NS�DE
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

