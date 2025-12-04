#!/usr/bin/env bash

# Stop all services and remove orphans
COMPOSE_PROFILES=openvox,hdm,test docker compose down --remove-orphans

docker volume rm oss_openvoxserver || true
docker volume rm oss_openvoxserver-ssl || true
docker volume rm oss_openvoxdb-postgres || true
docker volume rm oss_agent-ssl || true
docker volume rm oss_hdm-db || true
