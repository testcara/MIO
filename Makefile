helloword.o: main.o print_hello.o
	gcc -o helloworld main.o print_hello.o
main.o: main.c print_hello.h
	gcc -c main.c
print_hello.o: print_hello.c print_hello.h
	gcc -c print_hello.c
clean:
	rm helloworld print_hello.o main.o
