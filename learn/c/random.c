#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <time.h>
int main ()
{
    int n;
    int count[16] = {0};
    for (n=0; n<1000; n++)
    {
        unsigned int time =clock();
        srandom(time);
        unsigned int ran = (unsigned int)random();
        //printf("time=%x, random=%x \n", time, ran);
        int i=0;
        unsigned int value = 0x10000000;
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
            printf("i=%d, count=%d\n", i, count[i]);
        }
}
