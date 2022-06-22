#!/bin/env bash

dir=$(dirname $0)

cd $dir

create_volume(){
  vol=$1
  created=$(docker volume ls -f name=$vol -q)
  if [[ ! $created ]]; then
    echo "docker volume create $vol"
    docker volume create $vol
  fi
}

create_volume es-logs
create_volume es-data
create_volume es-plugins

docker-compose -f $dir/compose.yml up -d && docker-compose -f $dir/compose.yml logs -f --tail 10

