#include <unistd.h>
#include <stdio.h>

void main()
{
    FILE* f;
    char line[80];
    
    //  open pipe for reading
    //  command: list files in current working directory
    //  -l: in long format
    //  -a: include . and ..
    if ( (f=popen("ls -la", "r")) == NULL)
        printf("Can't open pipe.\n");
    
    //  read data line by line and print out on the screen
    while (fgets(line, 80, f) != NULL)
        printf("%s", line);
    
    //  close pipe
    pclose(f);
}
