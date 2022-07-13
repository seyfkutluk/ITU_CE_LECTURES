#include <stdio.h>
int main() {
    char s1[100], s2[100];
    
    printf("Enter string s1: ");
    fgets(s1, sizeof(s1), stdin);
    int i = 0;
    for (i; s1[i] != '\0'; ++i) {
        s2[i] = s1[i];
    }

    s2[i] = '\0';
    printf("String s2: %s", s2);
    return 0;
}
