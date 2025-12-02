# Minimal Setup

This is the bare minimum setup to get started with OpenVox.
It starts a openvox-server, a openvoxdb and a postgres database for openvoxdb.

**Note:** This setup is not intended for production use, but for testing and development.

## Start the OpenVox compose

```shell
docker compose up -d

# check if compose is ready
docker compose ps
```

## Test an agent

```shell
docker run --rm --network crafty-ov-minimal --name agent ghcr.io/openvoxproject/openvoxagent:latest agent -t --server puppet
```

## Clean up

```shell
docker compose down -v
```
