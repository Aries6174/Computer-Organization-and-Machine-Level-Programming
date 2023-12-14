#include <stdio.h>
#include "cdecl.h"

int PRE_CDECL asm_main(char*) POST_CDECL;

int main(void)
{
    char input[100]; // Assuming a maximum length of 100 characters for the string
    printf("--------------------------------------------------\n");
    printf("Find the maximum occurring character in a string\n");
    printf("--------------------------------------------------\n");
    printf("Enter a string : ");
    fgets(input, 100, stdin);

    asm_main(input);

    return 0;
    }