#!/bin/bash
# number of slaves
COUNT=$1

# create docker containers
docker-compose up -d
docker-compose scale client=1 server=$COUNT

run_jmx_filename=$2
docker inspect -f '{{.Name}} {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq)
WEBAPP_IP=$(docker inspect -f '{{.Name}} {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq) | grep webapp | awk -F' ' '{print $2}' | tr '\n' ',' | sed 's/.$//')
SERVER_IP=$(docker inspect -f '{{.Name}} {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq) | grep server | awk -F' ' '{print $2}' | tr '\n' ',' | sed 's/.$//')


sed  s/TARGET_IP/$WEBAPP_IP/g $run_jmx_filename > run.jmx
docker cp run.jmx client:/

# run client
docker exec -it client /bin/bash -c "jmeter -n -t /run.jmx -R$SERVER_IP"