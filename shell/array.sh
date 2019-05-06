#!/bin/bash
# 只能执行，不能shell执行文件
# 赋值一个数组
selfname=`basename $0`
a=($(ls *));
echo ${a[@]};
i=0;
for fname in a; do
    echo $fname;
done

#echo ${a[2]};
#echo ${a[*]}
#
##$(ls $0);
#a=(1 2 3 4 5);
## 获取数组
#echo ${a[1]};
## 输出数组所有内容 @或者*
#echo ${a[@]}
