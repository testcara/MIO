# Makefile高级语法2
这一章，我们学习条件关键字和常用函数
## 条件判断关键字
```
<conditional-directive>
<text-if-true>
else
<text-if-false>
endif
```
常用的有ifeq ifneq ifdef ifndef等，可在Conditonal_Makefile中看到案例。
终于ifeq等关键字之前没有tab。
## 遍历函数
```
$(foreach <var>,<list>,<text>)
```
遍历list, 赋给var，给text用。可在Foreach_Makefile中看到案例
## 条件判断函数
```
$(if condition,then-part[,else-part])
$(or condition1[,condition2[,condition3…]])
$(and condition1[,condition2[,condition3…]])
```
可在If_and_or_Makefile中看到案例
## 字符串处理函数
```
$(subst from,to,text)
$(patsubst pattern,replacement,text)
$(strip string)
$(findstring find,in)
$(filter pattern…,text)
$(filter-out pattern…,text)
$(sort list)
$(word n,text)
$(wordlist s,e,text)
$(words text)
$(firstword names…)
$(lastword names…)
```
可在String_Makefile中看到案例
更详细的信息可在[GNU Makefile官方手册-Text Function](https://www.gnu.org/software/make/manual/html_node/Text-Functions.html#Text-Functions)

## 文件名处理函数
```
$(dir names…)
$(notdir names…)
$(suffix names…)
$(basename names…)
$(addsuffix suffix,names…)
$(addprefix prefix,names…)
$(join list1,list2)
$(wildcard pattern)
$(realpath names…)
$(abspath names…)
```
可在File_Name_Makefile中看到案例
更详细的信息可在[GNU Makefile官方手册-File-Name-Functions](https://www.gnu.org/software/make/manual/html_node/File-Name-Functions.html#File-Name-Functions)

## Origin 函数
```
$(origin variable)
```
判断变量的来源，输出结果为undefined, default,environment等。由于简单，不做案例。
更详细的信息可在[GNU Makefile官方手册-Origin-Function](https://www.gnu.org/software/make/manual/html_node/Origin-Function.html#Origin-Function)

## Call 函数
```
$(call <expression>,<parm1>,<parm2>,<parm3>...)
```
创建新的参数化函数。示例如下
```
reverse = $(2) $(1)
foo = $(call reverse,a,b)
```
## Shell 函数
```
$(shell <shell command>)
```
执行shell命令。示例如下
```
.PHONY : all
all: check_shell

check_shell:
	@echo $(shell echo "Hello World")
	@echo "Hello World"
	@echo `echo Hello World`
```
其三种形式的执行shell指令都是可以的。该案例可在Shell_Makefile中看到。

## Error/Warn/Info函数
```
$(error text…)
$(warning text…)
$(info text…)
```
'error'函数可直接输出函数，并可以终止Makefile。'warning'和'info'则会输出相应的提示信息。案例可在Error_Warn_Info_Makefile中找到。

到目前为止，我们学习[GNU Makefile官方手册](https://www.gnu.org/software/make/manual/html_node)前8章内容。
后续章节内容，请保持持续关注。











