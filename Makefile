CFLAGS=-g -Wall -pipe -fPIC

default: libSimpleUART.so simple_uart_test simple_uart_term

test: simple_uart_test
	./simple_uart_test

%.o: %.c
	cppcheck -q --enable=all -UTEST_FINI -UTEST_INIT -UCLOCK_MONOTONIC -URUNNING_ON_VALGRIND $<
	$(CC) -c -o $@ $< $(CFLAGS)

libSimpleUART.so: simple_uart.o simple_uart_util.o
	$(CC) $< -shared -o $@

simple_uart_test: simple_uart_test.o simple_uart.o
	$(CC) -o simple_uart_test simple_uart_test.o simple_uart.o

simple_uart_term: simple_uart_term.o simple_uart.o
	$(CC) -o simple_uart_term simple_uart_term.o simple_uart.o

clean:
	rm -f simple_uart_test *.o *.so

