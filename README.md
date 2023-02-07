# asleap (Docker)

Tool: [asleap](https://github.com/joswr1ght/asleap) - Cisco LEAP and Generic MS-CHAPv2 Dictionary Attack

On Kali, the [current version does not work anymore](https://github.com/joswr1ght/asleap/issues/8) and fails with the following message:

```
Could not recover last 2 bytes of hash from the
challenge/response.  Sorry it didn't work out.
```

The alternative is to use either an older version of asleap, or another tool.

However, using an older version of Ubuntu, it still works, and furthermore, it can be compiled statically, so it can be copy/pasted in any distribution, without having to worry about depencies. This is a quick and dirty solution that works. A better solution would be to compile it using musl (if still wanted to compile statically). An even better solution would be to use a different library entirely.

Thanks to Docker, we can easily compile for all the CPU architectures Ubuntu offers:

- linux/386
- linux/amd64
- linux/arm/v7
- linux/arm64/v8
- linux/ppc64le
- linux/s390x

## DockerHub

DockerHub: https://hub.docker.com/r/finchsec/asleap

### Dynamically compiled

[![Dynamic Docker](https://github.com/FinchSec/asleap-docker/actions/workflows/docker-dynamic.yml/badge.svg?event=push)](https://github.com/FinchSec/asleap-docker/actions/workflows/docker-dynamic.yml)

Image: finchsec/asleap:dynamic (or finchsec/asleap:latest)

`sudo docker run --rm -it finchsec/asleap`

### Statically compiled

[![Static docker](https://github.com/FinchSec/asleap-docker/actions/workflows/docker-static.yml/badge.svg?event=push)](https://github.com/FinchSec/asleap-docker/actions/workflows/docker-static.yml)

Image: finchsec/asleap:static