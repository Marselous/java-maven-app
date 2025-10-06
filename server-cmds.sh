#!/user/bin/env bash

export IMAGE=$1 # That env var reffers to ${IMAGE_NAME} passed from Jenkinsfile.
docker-compose -f /home/zerg/apps/containers/docker-compose.yaml up --detach
echo "Application started..."