#include <string.h>
#include <stdio.h>
typedef struct aaa_ {
    int a;
    int b;
    int *c;
    int *e;
    int *d;
} aaa_st;
int main()
{
    aaa_st a={ 0, 1, 0x10, 0x20, 0x30 };
    aaa_st *b=&a;
    printf("b=%p b->d:%p\n", b, b->d);
    return 0;
}
int add(int a , int b)
{
    return a+b;
}
