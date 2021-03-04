# Unimus Core in Docker

Unimus is a multi-vendor network device configuration backup and management solution, designed from the ground up with user friendliness, workflow optimization and ease-of-use in mind.

  - https://unimus.net/
  - https://wiki.unimus.net/display/UNPUB/Running+in+Docker
  - https://wiki.unimus.net/display/UNPUB/Architecture+overview
  - https://wiki.unimus.net/display/UNPUB/Zones

## Running

Simply pass through the variables required  

```
docker run --rm -it \
  -v /etc/localtime:/etc/localtime \
  -v /etc/timezone:/etc/timezone \
  -e UNIMUS_SERVER_ACCESS_KEY=rellylongkey \
  -e UNIMUS_SERVER_ADDRESS=unimus.domain.local \
  -e TZ=Australia/Adelaide \
  semaja2/unimus-core
```