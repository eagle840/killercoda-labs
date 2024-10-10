
# Docker Install


## System update

`sudo apt update`{{exec}}

## Docker remove

`apt-get remove docker  docker.io containerd runc -y`{{exec}}

## Docker install

`apt-get install ca-certificates curl gnupg  lsb-release -y`{{exec}}

`mkdir -p /etc/apt/keyrings`{{exec}}

`curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg`{{exec}}

```
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```{{exec}}

`apt-get update`{{exec}}

`apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y `{{exec}}

## Docker version check

`docker version`{{exec}}

`docker-compose version`{{exec}}

`docker compose version`{{exec}}

## Docker-Compose vs Docker Compose

- 'docker compose' is the newer project, composed in Go and part of Docker
- 'docker-compose' is the orginal project and now deprecated

The main difference between Docker Compose v1 and v2 lies in the command syntax and integration with the Docker CLI. Here are some key points:

Command Syntax:
- Compose v1: Uses the docker-compose command.
- Compose v2: Uses the docker compose command (note the space instead of a hyphen)1.
Integration:
- Compose v1: Was a standalone tool written in Python.
- Compose v2: Is integrated into the Docker CLI and written in Go, providing a more consistent and predictable set of options and flags1.
Container Naming:
- Compose v1: Uses underscores (_) as word separators in container names.
- Compose v2: Uses hyphens (-) instead, which are valid characters in DNS hostnames1.
Deprecated Commands:
- Compose v1: Supported the docker-compose scale command.
- Compose v2: Replaces this with docker compose up --scale1.
New Features:
- Compose v2: Introduces new features like improved build performance with BuildKit, support for SSH resources at build time, and the ability to define multiple platforms for multi-arch images2.

Switching to Compose v2 is recommended as Compose v1 is no longer supported or updated2.

Are you planning to migrate an existing project to Compose v2, or starting a new one?


## Docker compose confusion

Docker compose has changed alot over the years.

The current version is 'Compose V2' [github](https://github.com/docker/compose/tags)

And to confuse things, the older version 'Version V1' has two versions 1.x, 2.x and 3.x

## Build specification

The docker compose API version has changed over the years

For the new [Compose V2](https://docs.docker.com/compose/compose-file/) you should be using what is called the 'Compose Specification' [github](https://github.com/compose-spec/compose-spec/blob/master/spec.md)

For the older Compose V1:

| OLD ComposeV1 API Version |  Docker deamon Verion |
|---------------------|-----------------------|
| 3.0 ; 3.1           | 1.13.0+ / 17.03+      |
| 2.1                 | 1.12.0+               |
| 2.0                 | 1.10.0+               |
| 1.0 * | 1.9.1+                |

Compose v1 is legacy, and you shouldn't use it. There will be no 'version' in a v1 file.

## Checking version

`docker version`{{exec}}

we're using version 24.x (or higher)


`docker-compose version`{{exec}}

Shows as 1.25, a depreicated version that is no longer updated


`docker compose version`{{exec}}

Remember this is the new 'Compose V2' Version, and not to be confused with the older 'Compose V1' 2.x sepecification version using with docker-compose



See https://docs.docker.com/compose/compose-file/ [link](https://docs.docker.com/compose/compose-file/)




`nano docker-compose.yml`{{exec}}

```
version: '3.8'

services:
  redis:
    image: redis:alpine
    restart: always
    ports:
      - "6379:6379"
    volumes:
      - redis-data:/data

volumes:
  redis-data:
    driver: local

```{{copy}}

`docker compose pull`{{exec}}
