#include "../test.h"

int list_size(t_list *begin_list)
{
    int size = 0;
    t_list *tmp = begin_list;

    while (tmp)
    {
        size++;
        tmp = tmp->next;
    }
    return size;
}