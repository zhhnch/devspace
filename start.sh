#!/bin/bash

dir=$(dirname $0)

cd $dir

re_start(){
    svc=$1
    info=$(docker-compose ls -a | grep $svc | sed -r "s/\(.*\)//g")
    if [[ $info ]]; then
        eval $(echo $info | awk -F"[ ]+" '{print "service="$1 "; " "status="$2 "; " "yml="$3";"}')
        if [[ $status == 'exited' ]]; then
          docker-compose -f $yml start
        fi
    fi
}

re_start mysql
re_start redis
