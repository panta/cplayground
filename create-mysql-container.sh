#!/bin/bash

set -e

# see:
#   https://severalnines.com/blog/mysql-docker-containers-understanding-basics

: ${CONTAINER:="cplayground-mysql"}
: ${DB:="cplayground"}
: ${PASSWORD:="passw0rd"}
LOCAL_PORT=3306
VM_PORT=3306
IMAGE=mariadb:10.3

docker run --detach \
    --name=${CONTAINER} \
    --env="MYSQL_ROOT_PASSWORD=${PASSWORD}" \
    --publish ${LOCAL_PORT}:${VM_PORT} ${IMAGE}

if [ $? -eq 0 ]; then
    echo "MySQL container created."
    if hash dinghy 2>/dev/null ; then
        c_ip=$(dinghy ip)
    else
        c_ip=$(docker-machine ip)
    fi
    echo
    echo "Destroy the machine with:"
    echo "  docker stop ${CONTAINER}"
    echo "  docker rm ${CONTAINER}"
    echo
    echo "Connect the MySQL client to ${c_ip}:${LOCAL_PORT}"
    echo
else
    echo "FAILED - can't create MySQL container."
    exit 1
fi

docker exec -it ${CONTAINER} mysql -uroot -p"${PASSWORD}" -e "create database ${DB};"
if [ $? -eq 0 ]; then
  echo "Created ${DB} database."
fi
