# Makefile高级语法1
在高级语法中，我们会讲到Makefile的嵌套，命令包，函数定义等
## 嵌套Makefile
在一些场景中，我们会需要多个Makefile协同工作，这就用到Makefile的嵌套。
常用的方法是使用include函数，在Makefile文件末尾包括其他的Makefile文件。
假设我们有Makefile, WEB_Makefile和API_Makefile需要一起编译
Makefile具体如下：
```
.PHONY : all
all: build

build:
	@echo "---> Start to make ..."
	@make build_web
	@make build_api
	@echo "---> Done to make ..."
include ./WEB/WEB_Makefile 
include ./API/API_Makefile
```
WEB_Makefile如下：
```
build_web:
	@echo "---> Make the WEB APP ..."
	@echo "---> Done to make WEB APP ..."
```
API_Makefile如下：
```
build_api:
	@echo "---> Make the API APP ..."
	@echo "---> Done to make API APP ..."
```
则执行结果为：
```
$ make
---> Start to make ...
make[1]: Entering directory `/home/wlin/MIO/Embedded_Makefiles/Embedded_Makefile_Example2'
---> Make the WEB APP ...
---> Done to make WEB APP ...
make[1]: Leaving directory `/home/wlin/MIO/Embedded_Makefiles/Embedded_Makefile_Example2'
make[1]: Entering directory `/home/wlin/MIO/Embedded_Makefiles/Embedded_Makefile_Example2'
---> Make the API APP ...
---> Done to make API APP ...
make[1]: Leaving directory `/home/wlin/MIO/Embedded_Makefiles/Embedded_Makefile_Example2'
---> Done to make ...
```
经验证这里需要注意的是，include别的Makefile的Makefile文件必须命令为Makefile,否则出现找不到被包含文件的错误。不确定是否为Makefile的版本。
出现该问题Make版本如下：
```
GNU Make 3.82
Built for x86_64-redhat-linux-gnu
```
该案例的脚本放在Embedded_Makefiles/Embedded_Makefile_Example1目录下
在实际应用中，我们也可以不用include，而直接使用shell命令，切换目录到其他目标Makefile位置处，执行make，或者使用make -f target_Makefile target来进行执行，案例脚本放在Embedded_Makefiles/Embedded_Makefile_Example2。

在一些文档有的说无论哪种方法，想在不同的Makefile中共享变量或者宏，则必须使用export, 否则值无法传递。经放在Embedded_Makefiles/Embedded_Makefile_Example3目录下的案例验证，发现无需使用export也可以实现共享。在[GNU Makefile官方文档- Including Other Makefiles](https://www.gnu.org/software/make/manual/html_node/Include.html)也没发现需要导出。

## 命令包
类似于shell中定义函数，将一组命令封装为一个包，格式为
```
define command_package =
cmd_1
cmd_2
...
endef
```
在我们在其他处，可使用${command_package}来引用该命名包，我们将案例放在CmdPackage_Makefile中, 由于很简单，这里不再次列出。
更多详细信息，可参考[GNU Makefile官方文档-Canned Recipes](https://www.gnu.org/software/make/manual/html_node/Canned-Recipes.html#Canned-Recipes)

## Shell方法
所有Shell的指令可以在Makefile中执行，但是默认Makefile并不解析Shell的语法，在将其交给shell执行前，会做一些简单的转义。
这些简单的转义和处理为：
1. 变量应该$${shell_variable}，否则为Makefile的变量
2. 没一条Shell指令的都以tab开头，一行command一个sub-shell，这就要求我们在使用shell程序块和传递变量时，需要注意，另其在同一个Shell中运行。达到这一目的，我们有以下方法
    * 将所有的command放在同一行（可用\链接）
    * 使用‘.ONESHELL’声明target中的SHELL都只在同一个shell运行。
案例放在OneShell_Makeline中，由于比较简单，这里不在展开。

    更多详细信息，可参考[GNU Makefile 官方文档 - Execution](https://www.gnu.org/software/make/manual/html_node/Execution.html#Execution)
    
本节中我们学习了，如何一般命令行包，shell包（ONESHELL），以及include多个Makefile，在下一章节中我们将学习Makefile的程序流程控制。