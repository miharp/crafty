#!/bin/bash

# Stop containers and remove volumes defined in compose
# We use --remove-orphans to catch containers created by 'docker compose run'
docker compose --profile openvox down -v --remove-orphans
docker compose --profile hdm down -v --remove-orphans
docker compose --profile test down -v --remove-orphans
docker compose --profile webhook down -v --remove-orphans

# Explicitly remove any remaining containers associated with the project (like one-off runs)
docker ps -a --filter "name=oss-testing-run" -q | xargs -r docker rm

# Remove named volumes
docker volume rm oss_hdm-db 2>/dev/null || true

# Remove bind mounted data
rm -fr server-data
rm -fr agent-ssl

