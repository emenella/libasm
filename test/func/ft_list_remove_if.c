#include "../test.h"

void list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *))
{
    t_list *tmp;
    t_list *prev;

    tmp = *begin_list;
    prev = NULL;
    while (tmp)
    {
        if ((*cmp)(tmp->data, data_ref) == 0)
        {
            if (prev)
                prev->next = tmp->next;
            else
                *begin_list = tmp->next;
            (*free_fct)(tmp->data);
            free(tmp);
            tmp = prev ? prev->next : *begin_list;
        }
        else
        {
            prev = tmp;
            tmp = tmp->next;
        }
    }
}