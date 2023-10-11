#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>



typedef struct s_list
{
    void *data;
    struct s_list *next;
} t_list;

void list_sort(t_list **begin_list, int (*cmp)());
void list_push_front(t_list **begin_list, void *data);
int list_size(t_list *begin_list);
int atoi_base(char *str, char *base);
void list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));