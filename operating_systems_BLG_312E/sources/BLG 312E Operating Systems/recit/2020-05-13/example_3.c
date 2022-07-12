#include <unistd.h>
#include <stdio.h>

void main()
{
    FILE* f;
    FILE* g;
    char line[80];
    
    //  open pipe for reading
    //  command: list files in current working directory.
    if ( (f=popen("ls", "r")) == NULL)
        printf("Can't open pipe.\n");
    
    //  open pipe for writing
    // command: grep (search for a pattern)
    //  -i: case insensitive
    if ( (g=popen("grep -i .*.c", "w")) == NULL)
        printf("Can't open pipe.\n");
    
    while (fgets(line, 80, f) != NULL)
    {
        printf("Read: %s", line);
        fputs(line, g);
    }
    
    
    
    //  close pipes
    pclose(f);
    printf("before closing g\n");
    pclose(g);
    printf("after closing g\n");
}
