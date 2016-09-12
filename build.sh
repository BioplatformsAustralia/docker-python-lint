#!/bin/sh
#
# Script to build images
#

: ${PROJECT_NAME:='linter'}
. ./lib.sh

set -e

docker_options

info "${DOCKER_BUILD_OPTS}"
TOPDIR=${PWD}

# build dirs, top level is python version
for pythondir in 2 3
do
    pythonver=`basename ${pythondir}`

    image="${DOCKER_IMAGE}:python${pythonver}"
    echo "################################################################### ${image}"

    ## warm up cache for CI
    docker pull ${image} || true

    ## build
    set -x
    cd ${TOPDIR}
    cd ${pythonver} && docker-compose build ${DOCKER_COMPOSE_BUILD_OPTS} linter
    docker tag ${image} ${image}-${DATE}

    ## for logging in CI
    docker inspect ${image}

    if [ ${DOCKER_USE_HUB} = "1" ]; then
        _ci_docker_login
        docker push ${image}-${DATE}
        docker push ${image}
    fi
    set +x
done
