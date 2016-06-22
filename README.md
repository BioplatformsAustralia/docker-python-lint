docker-linter
=============

This repository contains a Dockerfile for static code analysis tools (linters) for Django projects.


# Getting started

## Installation

`docker pull muccg/linter

## Quickstart

Start using

```bash
docker run -d --name linter \
    --interactive \
    --tty \
    --net "host" \
    --volume "$(pwd):$(pwd)" \
    -w $(pwd) \
    muccg/linter flake8
```

*Alternatively, you can use the sample [docker-compose.yml](docker-compose.yml)
file to start the container using [Docker Compose](https://docs.docker.com/compose/)*
