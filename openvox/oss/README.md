# Default OpenVox Example

## Start basic OpenVox setup

```shell
docker compose --profile openvox up -d
# Wait for all the services to be in the healthy Status
docker compose ps
```

## Test an agent

Once the openvox-profile is up and healthy, run puppet agent.

```shell
docker compose --profile test run --rm testing agent -t
```

## Start HDM

The [Hiera Data Manager (HDM)](https://github.com/betadots/hdm) is a Web UI to visualize Hiera data and make it searchable!
It also allows you to read/update/create that configuration.

```shell
docker compose --profile hdm up -d
```

Open: <http://localhost:3000/> and follow the instructions to setup users.

## Access Puppetboard

[Puppetboard](https://github.com/voxpupuli/puppetboard) is a web interface to PuppetDB aiming to replace the reporting functionality of Puppet Enterprise console.
It is included in the `openvox` profile and should be running.

Open: <http://localhost:8088/> and you should see one node checking in from the previous agent run above.

## Cleanup

To stop all containers and remove all volumes (including generated certificates and database data), run the cleanup script:

```shell
./clean.sh
```

## Generate additional certificates

After the OpenVox stack is running, execute the following command to generate an additional certificate.
It will be put in the openvoxserver-ssl volume, or any other volume you may have mounted for `/etc/puppetlabs/puppet/ssl`.

```bash
docker exec oss-openvoxserver-1 puppetserver ca generate --certname puppetboard
```

Output:

```text
Successfully saved private key for puppetboard to /etc/puppetlabs/puppet/ssl/private_keys/puppetboard.pem
Successfully saved public key for puppetboard to /etc/puppetlabs/puppet/ssl/public_keys/puppetboard.pem
Successfully submitted certificate request for puppetboard
Successfully saved certificate for puppetboard to /etc/puppetlabs/puppet/ssl/certs/puppetboard.pem
Certificate for puppetboard was autosigned.
```

One can then mount the openvoxserver-ssl or whatever mount one have to the additional container, which shall use the certs.
But in general this is a bad idea, but for testing this might work.

For the puppetboard, one also can specify the certs as base64 strings. To get the strings do:

```bash
docker exec oss-openvoxserver-1 cat /etc/puppetlabs/puppet/ssl/certs/ca.pem | base64
docker exec oss-openvoxserver-1 cat /etc/puppetlabs/puppet/ssl/certs/puppetboard.pem | base64
docker exec oss-openvoxserver-1 cat /etc/puppetlabs/puppet/ssl/private_keys/puppetboard.pem | base64
```
