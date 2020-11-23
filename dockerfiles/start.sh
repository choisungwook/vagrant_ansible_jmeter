#!/bin/bash
# number of slaves
COUNT=$1
mkdir -p results

# create docker containers
docker-compose up -d
docker-compose scale master=1 slave=$COUNT

jmx_filename=$2
WEBAPP_IP=$(docker inspect -f '{{.Name}} {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq) | grep webapp | awk -F' ' '{print $2}' | tr '\n' ',' | sed 's/.$//')
SLAVE_IP=$(docker inspect -f '{{.Name}} {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq) | grep slave | awk -F' ' '{print $2}' | tr '\n' ',' | sed 's/.$//')

echo "=============== WEBAPP IP============="
echo $WEBAPP_IP

echo "=============SLAVE_IP LIST"
echo $SLAVE_IP
echo "====================="

sed  s/TARGET_IP/$WEBAPP_IP/g test.jmx > test2.jmx
docker cp $jmx_filename master:/
docker exec -it master /bin/bash -c "jmeter -n -t $jmx_filename -R$SLAVE_IP"