GCC = gcc
OBJECTS = main.o print_hello.o
HEAD_SOURCE = print_hello.h


helloword.o: ${OBJECTS}
	${GCC} -o helloworld ${OBJECTS}

${OBJECTS}: ${HEAD_SOURCE}
main.o: main.c
print_hello.o: print_hello.c

clean:
	rm helloworld ${OBJECTS}