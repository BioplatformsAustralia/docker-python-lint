docker-python-lint
=============

This repository contains a Dockerfile for static code analysis tools (linters) for Django projects.


# Getting started

## Installation

Python 3:
```
docker pull bioplatformsaustralia/python-lint:python3
```

## Quickstart

Start using

```bash
docker run -d --name linter \
    --interactive \
    --tty \
    --net "host" \
    --volume "$(pwd):$(pwd)" \
    -w $(pwd) \
    bioplatformsaustralia/python-lint:python3 flake8
```

