#include <stdio.h>

#include "cdecl.h"

int PRE_CDECL fibo(int) POST_CDECL;

int main(void)
{
  int n;
  printf("Enter a number: ");
  scanf("%d", &n);

  fibo(n);
  return 0;
}
