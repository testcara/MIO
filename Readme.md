# Makefile初级语法2
## Makefile的执行顺序
在我们在讲解其他初级语法例如伪目标之前，我们来讲解Makefile的执行顺序
Makefile遇到的第一个target为默认target，也就是你仅执行make或者make -F Makefile_name时默认会执行的。我们称该目标为默认目标，也称为终极目标。
其会检索其依赖关系的关系链，然后根据时间来确定关系链条的更新点，判断那些需要重新编译，则从最底层依赖需要重新编译的地方开始重新编译，直到最终目标完成。
## Makefile初级语法
* 伪目标
目标命令不生成文件，我们称其为伪目标。
如以下Makefile
    ```
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
    ```
    则helloworld.o, main.o以及printhello.o都非伪目标，因为其都有目标文件生成。
    而clean则用来清除编译过程中生成的文件，则为伪目标。
    在GNU Makefile中，有一些约定俗称的伪目标。
    | 伪目标      |     含义                                                           | 
    |----------   |:-------------:                                                     |
    | all         |  编译所有目标                                                      |
    | clean       |  删除所有被make创建的文件                                          | 
    | install     |  编译已安装好的程序，其将目标可执行文件拷贝到指定的目录中去        |
    | print       |  列出改变过的源文件                                                |
    | tar         |  将源文件打包备份                                                  |
    | dist        |  将备份后的文件压缩                                                |
    | TAGS        |  更新所有目标，已备重新编译                                        |
    | check/test  |  一般用来测试Makefile的流程                                        |
    结合我们讲解的Makefile的执行顺序，通常all作为默认目标，其他伪命令不作为默认目标而需要显示调用，例如make clean去执行清理工作。
    对于伪目标，为了避免和文件名冲突，而出现不确定的状况，通常我们会使用.PHONY来生声明，例如.PHONY : clean 声明clean为伪命令。
    
* 隐含规则
    Makefile在编译是默认会使用隐含规则来进行编译，不同的语言类型，隐含规则不同。
    且我们可自己定义隐含规则。
    具体的可参见[GNU Makefile官方文档](ftp://ftp.gnu.org/old-gnu/Manuals/make-3.79.1/html_chapter/make_10.html#SEC95)。我们这里对其并不深究。
    这块内容，个人认为放在高级语法也是可以的，但是由于这一部分，我们使用的可能不多，所以就暂时放在此处。

至此，我们知道了如何写编写Makefile， Makefile的执行顺序，以及伪指令，可以尝试用其做简单的自动化编译工作吧！


