#include "../test.h"

void list_sort(t_list **begin_list, int (*cmp)())
{
    t_list *tmp;
    t_list *prev;
    void *data;

    tmp = *begin_list;
    while (tmp)
    {
        prev = tmp;
        tmp = tmp->next;
        if (tmp && (*cmp)(prev->data, tmp->data) > 0)
        {
            data = prev->data;
            prev->data = tmp->data;
            tmp->data = data;
            tmp = *begin_list;
        }
    }
}