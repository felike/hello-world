#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <time.h>
int main ()
{
    long long n;
    long long count[16] = {0};
    for (n=0; n<100000000; n++)
    {
        unsigned int time =clock();
        srandom(time);
        int ran1 = random();
        unsigned int ran = (ran1>>16)|(ran1<<16);
//        printf("time=%x, random=%d ---- %x \n", time, ran1, ran);
        int i=0;
        unsigned int value = 0xfffffff;
        for (i=0;i<16;i++)
        {
           if(ran < value)
           {
               count[i]++;
               break;
           }
            value+= 0x10000000;
        } 
    }
        for(int i=0; i<16;i++)
        {
            printf("i=%d, count=%lld\n", i, count[i]);
        }
}
