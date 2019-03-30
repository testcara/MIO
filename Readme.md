# Makefile初级语法1
## Makefile基本规则
基本规则如下：
```
target [target...] : [dependent ...]
    [ command ...]
# command前必须是TAB
```
语法示例分析：
```
helloworld.o: main.o print_hello.o
    gcc -o helloworld main.o print_hello.o
```
则对比可看书':'前为target名字，后为依赖。命令行必须为TAB开头。我们发现这里的命令和我们直接在终端执行的命令一样，即shell command可以在Makefile中使用，对的，这也是有些人认为Makefile是增强版的Shell的原因。
我们想执行此target,则执行’Make target‘即可（示例，则执行make helloworld.o）。

## Makefile初级语法
Makefile语法中除了基本规则外，Makefile还支持宏定义，显性隐性规则等其他语法。基本的语法有：
* 宏定义
Makefile中的宏定义类似于变量定义。语法点有：
__1. 两种格式__
    ```
    # '='可以使用在后面定义的变量
    OBJS_1 = ProgramA.o ProgramB.o ${OBJS_2}
    OBJS_2 = ProgamC.o ProgramD.o
    # ':='仅能使用在前面定义的变量
    OBJS_3 := ProgamE.o ProgramF.o ${OBJS_4}
    OBJS_4 = ProgramG.o ProgramH.o ${OBJS_2}
    ```
    我们用以Macros_Makefile文件来进行这两个格式的对比
    ```
    OBJS_1 = ProgramA.o ProgramB.o ${OBJS_2}
    OBJS_2 = ProgamC.o ProgramD.o
    OBJS_3 := ProgamE.o ProgramF.o ${OBJS_4}
    OBJS_4 = ProgramG.o ProgramH.o ${OBJS_2}
    
    macro_1:
        echo ${OBJS_1}
    macro_2:
        echo ${OBJS_3}
    ```
    则执行结果为：
    ```
    $ make -f Macros_Makefile  macro_1
    echo ProgramA.o ProgramB.o ProgamC.o ProgramD.o
    ProgramA.o ProgramB.o ProgamC.o ProgramD.o
    $ make -f Macros_Makefile  macro_2
    echo ProgamE.o ProgramF.o 
    ProgamE.o ProgramF.o
    ```
    可看到'：='使用后面的宏定义并不能生效。
    除了在Makefile中定义宏，我们在运行脚本时也可以指定宏，如下：
    ```
    $ make -f Macros_Makefile  OBJS_4='ProgamZ.o' macro_2 
    echo ProgamE.o ProgramF.o ProgamZ.o
    ProgamE.o ProgramF.o ProgamZ.o
    ```
    __2. Override宏__
    我们看到宏在运行时可被重新定义，如果不想被重新定义，则需要使用override来声明宏.
    更新Macros_Makefile如下
    ```
    OBJS_1 = ProgramA.o ProgramB.o ${OBJS_2}
    OBJS_2 = ProgamC.o ProgramD.o
    OBJS_3 := ProgamE.o ProgramF.o ${OBJS_4}
    OBJS_4 = ProgramG.o ProgramH.o ${OBJS_2}
    override OBJS_5 := ProgramI.o ${OBJS_4}

    macro_1:
        echo ${OBJS_1}
    macro_2:
        echo ${OBJS_3}
    macro_3:
        echo ${OBJS_5}
    ```
    则执行如下：
    ```
    $ make -f Macros_Makefile  OBJS_5='ProgamZ.o' macro_3 
    echo ProgramI.o ProgramG.o ProgramH.o ProgamC.o ProgramD.o
    ProgramI.o ProgramG.o ProgramH.o ProgamC.o ProgramD.o
    ```
    __3.目标变量__
    ```
    <target ...> :: <variable-assignment>
    <target ...> :: ...
    ```
    我们在Makefile开头定义的宏为全局宏，对所有的target均有效。
    而当我们需要定义仅对某一特定目标生效的宏时，我们需要定义目标宏。
    我们在TargetMacros_Makefile中进行实验
    ```
    OBJ1 = programA.o

    target_macro_1: OBJ1 = programB.o
    target_macro_1:
        echo ${OBJ1}
    ```
    则执行结果如下
    ```
    $ make -f TargetMacros_Makefile target_macro_1
    echo programB.o
    programB.o
    ```
* 指定文件路径
    当Makefile中牵涉到的文件在不同目录时，我们需要将原文件的路径明确的写在Makefile中，便于Makefile在执行编译时进行查找。Makefile中VPATH这个特殊的变量帮助我们实现这一功能。
    VPATH的使用方法有以下几种
    ```
    vpath = <directories>   :: 当前目录中找不到文件时, 就从<directories>中搜索
    vpath <pattern> <directories>  :: 符合<pattern>格式的文件, 从<directories>中搜索
    vpath <pattern>  :: 清除符合<pattern>格式的文件搜索路径
    vpath =  :: 清除所有已经设置好的文件路径
    ```
    我们把所有编译程序放到src文件夹下，编写VPATH_Makefile来实验第一种用法
    ```
    VPATH = ./src

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
    则通过执行‘make -f VPATH_Makefile helloword.o’可得到可执行文件
* 命令前缀
  我们调用命令时，希望命令根据执行时不同的输出及不同的遇错反映，有三种命令格式
    ```
    @rm helloworld  # '@'前缀表示，只输出结果，遇错停止执行
    _rm helloworld  # '_'前缀表示，输出执行命令和结果，遇错继续执行
    rm helloworld   # 无前缀，输出执行命令和结果，遇错停止执行
    ```
   我们编写Prefix_Makefile来进行实验
   ```
    test_@:
        @echo "test the @rm for unexisting files"
        @rm unexisting_files
        @echo "echoing after the failure"
    test_-:
        @echo "testing the '-rm' for unexisting files"
        -rm unexisting_files
        @echo "echoing after the failure"
    test_:
        @echo "testing the 'rm' for unexisting files"
        rm unexisting_files
        @echo "echoing after the failure"
   ```
   实验结果为：
   ```
    $ make -f Prefix_Makefile test_@
    test the @rm for unexisting files
    rm: cannot remove ‘unexisting_files’: No such file or directory
    make: *** [test_@] Error 1
    $ make -f Prefix_Makefile test_-
    testing the '-rm' for unexisting files
    rm unexisting_files
    rm: cannot remove ‘unexisting_files’: No such file or directory
    make: [test_-] Error 1 (ignored)
    echoing after the failure
    $ make -f Prefix_Makefile test_
    testing the 'rm' for unexisting files
    rm unexisting_files
    rm: cannot remove ‘unexisting_files’: No such file or directory
    make: *** [test_] Error 1
   ```
   
在这一章节中我们学习了，Makefile的基本规则，如何定义编译，查找文件以及调用命令，着手写一些简单的Makefile吧。

