#!/user/bin/env bash

docker-compose -f /home/zerg/apps/containers/docker-compose.yaml up --detach
echo "Application started..."