#include <string.h>
#include <stdio.h>
int get_traceid(int *a , char *b);
int get_traceid2(int *a , char *b);
int main()
{
    int trace_id =0;
    char *name1="nwpi-auto-class-10-trace10";
    char *name2="nwpi-auto-class-10-trace30";
    char *name3="nwpi-auto-class-10-10-trace50";

    get_traceid(&trace_id, name1);
    get_traceid(&trace_id, name2);
    get_traceid(&trace_id, name3);
    return 0;
}

int get_traceid(int *trace_id, char *name)
{
    char *begin = NULL;
    while (*name) {

        if (*name == '-')
            begin = name +1;
        name++;
    }

    sscanf(begin,"trace%u", trace_id);
    printf("%s:%d,begin:%s trace:%d\n",__FUNCTION__, __LINE__, begin, *trace_id);
    return 0;
}

int get_traceid2(int *trace_id, char *name)
{
    char str[100];
    sscanf(name,"%s-trace%u", str, trace_id);
    printf("%s:%d str:%s, trace:%d\n",__FUNCTION__, __LINE__, str, *trace_id);
    return 0;
}
