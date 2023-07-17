#include <stdio.h>

extern int ft_strlen(char *str);

int main(int ac, char **av)
{
    if (ac != 2)
    {
        return -1;
    }

    int ret = ft_strlen(av[1]);
    printf("length of %s its %d\n", av[1], ret);
    return 0;
}