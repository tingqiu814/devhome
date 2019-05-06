#!/bin/bash
CMD='';
_ab=`whereis ab`
for i in 10 100 
do
    for j in 10 
    do
        if [ -n "$CMD" ] 
        then 
            CMD=$CMD' ||';
        fi
        CMD="$CMD $_ab -n $i -c $j http://i.xunlei.com/ 1>&2 > /tmp/ab_n_${i}_c_$j.out";
    done
done
echo $CMD;
#/usr/bin/ab -n 100 -c 10 http://i.xunlei.com/ > /tmp/ab_n_100_c_10.out
