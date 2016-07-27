#!/bin/sh
#
# Script to build images
#

# break on error
set -e
set -x
set -a
: ${PROJECT_NAME:='linter'}
: ${DOCKER_IMAGE:="muccg/${PROJECT_NAME}"}
: ${DOCKER_USE_HUB:="0"}

DATE=`date +%Y.%m.%d`


ci_docker_login() {
    info 'Docker login'

    if [ -z ${DOCKER_EMAIL+x} ]; then
        DOCKER_EMAIL=${bamboo_DOCKER_EMAIL}
    fi
    if [ -z ${DOCKER_USERNAME+x} ]; then
        DOCKER_USERNAME=${bamboo_DOCKER_USERNAME}
    fi
    if [ -z ${DOCKER_PASSWORD+x} ]; then
        DOCKER_PASSWORD=${bamboo_DOCKER_PASSWORD}
    fi

    docker login -e "${DOCKER_EMAIL}" -u ${DOCKER_USERNAME} --password="${DOCKER_PASSWORD}"
    success "Docker login"
}


# warm up cache
docker pull ${DOCKER_IMAGE}:latest || true

docker-compose build linter
docker inspect ${DOCKER_IMAGE}:latest

docker tag ${DOCKER_IMAGE}:latest ${DOCKER_IMAGE}:latest-${DATE}

if [ ${DOCKER_USE_HUB} = "1" ]; then
    ci_docker_login
    docker push ${DOCKER_IMAGE}:latest
    docker push ${DOCKER_IMAGE}:latest-${DATE}
fi
