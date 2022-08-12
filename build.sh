#!/bin/bash

# 编译动态库libmyadd.so
g++ -shared -fPIC -o libmyadd.so myadd.cpp

# 编译可执行文件，并链接libmyadd.so
# 方式1，直接指定so的完整路径
# 说明，这里的./libmyadd.so，不能省略成libmyadd.so，省略之后运行报错
#       编译时，main.cpp依赖libmyadd.so，所以main.cpp放在./libmyadd.so的前面，如果放在后面，会编译失败
g++ -o main1 main.cpp ./libmyadd.so

# 方式2，使用rpath来指定相对路径
# 说明: 
#    -L（大写），指定编译时动态库的路径
#   -l(小写)，指定动态库的名字
#   -Wl,-rpath,配置运行时搜索动态库的路径，注意这里使用逗号(,)来区分，逗号后面可以接多个运行时动态库的搜索路径，通过逗号隔开，
#       这里的点号(.)表示将当前目录作为运行时动态库搜索路径
g++ main.cpp -o main2 -L. -lmyadd -Wl,-rpath,.


# 说明，编译cpp，使用g++编译器
# -shared ： 表明编译成动态库，作用在连接阶段(.o到.so)
# -fPIC  :  告诉编译器产生与位置无关代码，产生的代码中就没有绝对地址，可以加载到内存的任意位置。作用在编译阶段(.cpp到.o)
# 
