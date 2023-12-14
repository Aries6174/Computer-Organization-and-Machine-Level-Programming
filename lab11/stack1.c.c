#include <stdio.h>
#include "cdecl.h"

int PRE_CDECL pells(int) POPST_CDECL;
int main(void)
{
    int n, pells_number("Enter a number to find its Pells Companion: ");
    scanf("%d", &n);

    pells_number = pells(n);
    printf("P(%d) is %d\n", n, pells_number);

    return 0;
}