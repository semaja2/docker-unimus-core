# Unimus Core in Docker

Unimus is a multi-vendor network device configuration backup and management solution, designed from the ground up with user friendliness, workflow optimization and ease-of-use in mind.

  - https://unimus.net/
  - https://wiki.unimus.net/display/UNPUB/Architecture+overview
  - https://wiki.unimus.net/display/UNPUB/Zones

## Running

Simply pass through the variables required, be sure to use bash escaped characters for the access key (https://www.gnu.org/software/bash/manual/html_node/Escape-Character.html)

```
docker run --rm -it \
  -v /etc/localtime:/etc/localtime \
  -v /etc/timezone:/etc/timezone \
  -e UNIMUS_SERVER_ACCESS_KEY=BashEscapedKeyHere \
  -e UNIMUS_SERVER_ADDRESS=unimus.domain.local \
  -e XMX=1024M \
  -e XMS=256M \
  -e TZ=Australia/Adelaide \
  semaja2/unimus-core:latest
```
```
podman container create \
  --restart=always \
  -eUNIMUS_SERVER_ACCESS_KEY=BashEscapedKeyHere \
  -eUNIMUS_SERVER_ADDRESS=unimus.domain.local \
  -e XMX=1024M \
  -e XMS=256M \
  -eTZ=Australia/Adelaide \
  semaja2/unimus-core:latest
```