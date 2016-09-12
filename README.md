docker-linter
=============

This repository contains a Dockerfile for static code analysis tools (linters) for Django projects.


# Getting started

## Installation

Python 2:
```
docker pull muccg/linter:python2
```

Python 3:
```
docker pull muccg/linter:python3
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
    muccg/linter:python2 flake8
```

Convenience scripts in 2/bin and 3/bin for Python 2 and 3 respectively.
