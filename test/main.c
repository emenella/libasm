#include "./test.h"

extern int ft_strlen(const char *s);
extern char *ft_strcpy(char *dst, const char *src);
extern int ft_strcmp(const char *s1, const char *s2);
extern size_t ft_write(int fd, const void *buf, size_t count);
extern size_t ft_read(int fd, void *buf, size_t count);
extern char *ft_strdup(const char *s);
extern int ft_atoi_base(char *str, char *base);
extern void ft_list_sort(t_list **begin_list, int (*cmp)());
extern void ft_list_push_front(t_list **begin_list, void *data);
extern int ft_list_size(t_list *begin_list);
extern void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));

void show_result(int result, int expected, char *func)
{
    if (result == expected)
        printf("%s OK\n", func);
    else
        printf("%s KO result=%d, expected=%d\n", func, result, expected);
}

void wrapper_strlen()
{
    printf("TEST: %s\n", "strlen");
    int asm_len = ft_strlen("Hello World!");
    int c_len = strlen("Hello World!");
    show_result(asm_len, c_len, "ft_strlen");

    asm_len = ft_strlen("");
    c_len = strlen("");
    show_result(asm_len, c_len, "ft_strlen");

    asm_len = ft_strlen("Hello World!\0");
    c_len = strlen("Hello World!\0");
    show_result(asm_len, c_len, "ft_strlen");
    
}

void wrapper_strcpy()
{
    printf("TEST: %s\n", "strcpy");
    char *asm_dst = malloc(sizeof(char) * 13);
    char *c_dst = malloc(sizeof(char) * 13);
    char *asm_ret;
    char *c_ret;

    asm_ret = ft_strcpy(asm_dst, "Hello World!");
    c_ret = strcpy(c_dst, "Hello World!");

    show_result(strcmp(asm_dst, c_dst), 0, "ft_strcpy");
    show_result(strcmp(asm_ret, c_ret), 0, "ft_strcpy");
}

void wrapper_strcmp()
{
    printf("TEST: %s\n", "strcmp");
    int asm_ret;
    int c_ret;

    asm_ret = ft_strcmp("Hello World!", "Hello World!");
    c_ret = strcmp("Hello World!", "Hello World!");
    show_result(asm_ret, c_ret, "ft_strcmp");

    asm_ret = ft_strcmp("Hello World!", "Hello World\0");
    c_ret = strcmp("Hello World!", "Hello World\0");
    show_result(asm_ret, c_ret, "ft_strcmp");

    asm_ret = ft_strcmp("Hello World\0", "Hello World!");
    c_ret = strcmp("Hello World\0", "Hello World!");
    show_result(asm_ret, c_ret, "ft_strcmp");
}

void wrapper_write()
{
    printf("TEST: %s\n", "write");
    ft_write(1, "Hello World!", 13);
    ft_write(1, "\n", 1);
    ft_write(1, "", 0);
    ft_write(1, "\n", 1);
}

void wrapper_read()
{
    printf("TEST: %s\n", "read");
    char buf[13];
    int ret;
    int asm_ret;

    asm_ret = ft_read(0, buf, 13);
    printf("buff = %s\n", buf);
    ret = read(0, buf, 13);
    printf("buff = %s\n", buf);
    show_result(asm_ret, ret, "ft_read");

}

void wrapper_strdup()
{
    printf("TEST: %s\n", "strdup");
    char *asm_ret;
    char *c_ret;

    asm_ret = ft_strdup("Hello World!");
    c_ret = strdup("Hello World!");
    show_result(strcmp(asm_ret, c_ret), 0, "ft_strdup");

    asm_ret = ft_strdup("");
    c_ret = strdup("");
    show_result(strcmp(asm_ret, c_ret), 0, "ft_strdup");
}

void wrapper_list_atio_base()
{
    printf("TEST: %s\n", "list_atio_base");
    char base[] = "0123456789ABCDEF";
    char *str = "FF";
    int asm_ret = ft_atoi_base(str, base);
    int c_ret = atoi_base(str, base);

    show_result(asm_ret, c_ret, "ft_atoi_base");

    str = "0";

    asm_ret = ft_atoi_base(str, base);
    c_ret = atoi_base(str, base);
    show_result(asm_ret, c_ret, "ft_atoi_base");
}

void wrapper_list_push_front()
{
    printf("TEST: %s\n", "list_push_front");
    t_list *list = NULL;
    char *data = "Hello World!";
    ft_list_push_front(&list, data);
    show_result(strcmp(list->data, data), 0, "ft_list_push_front");

    data = "front";
    ft_list_push_front(&list, data);
    show_result(strcmp(list->data, data), 0, "ft_list_push_front");
}

void wrapper_list_size()
{
    printf("TEST: %s\n", "list_size");
    t_list *list = NULL;
    char *data = "Hello World!";
    ft_list_push_front(&list, data);
    show_result(ft_list_size(list), 1, "ft_list_size");

    data = "front";
    ft_list_push_front(&list, data);
    show_result(ft_list_size(list), 2, "ft_list_size");
}

void wrapper_list_remove_if()
{
    printf("TEST: %s\n", "list_remove_if");
    t_list *list = NULL;
    char *data[] = {"Hello World!", "Hello", "dogo"};
    size_t i = -1;
    while (++i < sizeof(data) / sizeof(data[0]))
        ft_list_push_front(&list, (void *)data[i]);

    ft_list_remove_if(&list, "Hello World!", strcmp, free);
    show_result(ft_list_size(list), 2, "ft_list_remove_if");
}

void wrapper_list_sort()
{
    printf("TEST: %s\n", "list_sort");
    t_list *list = NULL;
    char *data[] = {"Hello World!", "Hello", "dogo"};
    size_t i = -1;
    while (++i < sizeof(data) / sizeof(data[0]))
        ft_list_push_front(&list, (void *)data[i]);
    ft_list_sort(&list, strcmp);
    //print all data
    t_list *tmp = list;
    while (tmp)
    {
        printf("%s\n", (char *)tmp->data);
        tmp = tmp->next;
    }
}


int main ()
{
    void (*wrapper[])() = {wrapper_strlen, wrapper_strcpy, wrapper_strcmp, wrapper_write, wrapper_strdup, wrapper_list_atio_base, wrapper_list_push_front, wrapper_list_size, wrapper_list_sort, wrapper_list_remove_if, wrapper_read};

    size_t i = -1;

    while (++i < sizeof(wrapper) / sizeof(wrapper[0]))
        wrapper[i]();
    return (0);
}