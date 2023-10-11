#include "../test.h"

void list_push_front(t_list **begin_list, void *data)
{
    t_list *new;

    new = malloc(sizeof(t_list));
    if (new)
    {
        new->data = data;
        new->next = *begin_list;
        *begin_list = new;
    }
}