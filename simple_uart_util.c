#include <stdio.h>
#include <stdlib.h>

#include "simple_uart.h"

void list_ports()
{
    char **names;
    ssize_t nuarts = simple_uart_list(&names);
    for (ssize_t i = 0; i < nuarts; i++) {
        printf("Port %ld: %s\n", i, names[i]);
    }

    for (ssize_t i = 0; i < nuarts; i++) {
        if (names[i]) free(names[i]);
    }
    free(names);
}

