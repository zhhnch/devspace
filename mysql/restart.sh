#!/bin/env bash

restart_serv(){

  app_id=$(docker-compose ps --services)

  echo $(date +'%Y-%m-%d %H:%M:%S') "restart server:" $app_id

  docker-compose exec $app_id rm -rf runtime/ \
  && docker-compose exec $app_id composer dump-autoload \
  && docker-compose restart

}

start_serv(){
  echo $(date +'%Y-%m-%d %H:%M:%S') "start server:"

  if [[ -d runtime/ ]]; then
      sudo rm -rf runtime/
  fi

  docker-compose start
}

up_serv(){

  echo $(date +'%Y-%m-%d %H:%M:%S') "up server:"

  if [[ -d runtime/ ]]; then
    sudo rm -rf runtime/
  fi

  docker-compose up -d

}

start_time=$(date +'%s')

upped=$(docker-compose ps -q)

running=$(docker-compose ps -q --filter status=running)

if [[ $running ]]; then
  restart_serv
elif [[ $upped ]]; then
  start_serv
else
  up_serv
fi

end_time=$(date +'%s')

echo $(date +'%Y-%m-%d %H:%M:%S') " docker-compose started" `expr $end_time - $start_time`"'s" && docker-compose logs -ft

