Unix Makefile入门
==
Makefile是一种自动化程序编译工具。它通过定义一系列的编译规则可以处理编译程序之间的依赖，并完成自动化的编译，从而必须重复的手动编译步骤。Unix Makefile可以运行在Unix, Linux等平台上。
下面我们以一个例子展示如何使用Unix Makefile
我们有一个非常简单的C程序，如下：
```
#include<stdio.h>
void printhello(){
	printf("Hello, world\n");
}
int main(void){
	printhello();
	return 0;
}
```
将该程序编译成可执行文件，则需要如下两步：
* 编译成目标（二进制）文件
```
gcc -c helloword.c -o hellworld
```
* 链接并生成可执行文件
```
gcc -o helloworld helloworld.o
```
则运行可执行文件可得到预期结果
```
$ ./helloworld 
Hello, world
```
而在实际工程场景中，依赖关系较复杂。下面我们来对上面一个程序进行简单的处理，来演示最简单的依赖关系下的编译过程。
将helloworld.c分成如下3个文件：
* print_hello.h
    ```
    #include<stdio.h>
    void printhello();
    ```
* print_hello.c
    ```
    #include"print_hello.h"
    void printhello(){
	    printf("Hello, world\n");
    }
    ```
* main.c
    ```
    #include "print_hello.h"
    int main(void){
	    printhello();
	    return 0;
    }
    ```
则我们要将其编译成可执行文件，需要以下步骤
```
gcc -c print_hello.c  print_hello.h 
gcc -c print_hello.h main.c 
gcc -o helloworld print_hello.o main.o 
 ./helloworld 
```
则步骤增加，而当一个文件发生变化时，我们有可能需要重新执行所有的步骤。
而当项目依赖关系更复杂，文件更多，这样的编译工作是非常负责的。我们有许多IDE来帮我们解决自动化编译的问题，而Makefile也是一个很好的选择
按照我们的编译步骤，Makefile编写如下
```
helloword.o: main.o print_hello.o
	gcc -o helloworld main.o print_hello.o
main.o: main.c print_hello.h
	gcc -c main.c
print_hello.o: print_hello.c print_hello.h
	gcc -c print_hello.c
clean:
	rm helloworld print_hello.o main.o
```
基于此Makefile,则我们只需要如下步骤完成编译
```
make helloworld.o
./helloworld
```
即无论文件内容变化是怎样的，我们只需要一条很简单的指令即可完成编译。
‘make clean’可以帮我们删除中间过程的生成的文件。
很显然，这是一个很粗糙的Makefile。关于如何工作的以及怎么优化它，我们将在下一章节讲解。