#
FROM python:3.5-alpine
MAINTAINER https://github.com/muccg

ARG ARG_PROSPECTOR_VERSION
ARG ARG_AUTOPEP8_VERSION
ARG ARG_AUTOFLAKE_VERSION
ARG ARG_FLAKE8_VERSION
ARG ARG_YAPF_VERSION
ARG ARG_PYLINT_VERSION
ARG ARG_CLOSURE_LINTER_VERSION
ARG ARG_RADON_VERSION
ARG ARG_PIP_OPTS="--upgrade --no-cache-dir"

ENV PROSPECTOR_VERSION $ARG_PROSPECTOR_VERSION
ENV AUTOFLAKE_VERSION $ARG_AUTOFLAKE_VERSION
ENV AUTOPEP8_VERSION $ARG_AUTOPEP8_VERSION
ENV FLAKE8_VERSION $ARG_FLAKE8_VERSION
ENV YAPF_VERSION $ARG_YAPF_VERSION
ENV PYLINT_VERSION $ARG_PYLINT_VERSION
ENV CLOSURE_LINTER_VERSION $ARG_CLOSURE_LINTER_VERSION
ENV RADON_VERSION $ARG_RADON_VERSION
ENV VIRTUAL_ENV /env

RUN addgroup -S -g 1000 linter \
    && adduser -D -S -u 1000 -h /data -s /sbin/nologin -G linter linter

#entrypoint is written in bash
RUN apk add --no-cache bash
 
# create a virtual env in $VIRTUAL_ENV, ensure it respects pip version
RUN pyvenv $VIRTUAL_ENV \
    && $VIRTUAL_ENV/bin/pip install $ARG_PIP_OPTS pip==$PYTHON_PIP_VERSION
ENV PATH $VIRTUAL_ENV/bin:$PATH

RUN env | sort
RUN pip install $ARG_PIP_OPTS \
    "autoflake==$AUTOFLAKE_VERSION" \
    "autopep8==$AUTOPEP8_VERSION" \
    "closure-linter==$CLOSURE_LINTER_VERSION" \
    "yapf==$YAPF_VERSION" \
    "pylint==$PYLINT_VERSION" \
    "flake8==$FLAKE8_VERSION" \
    "prospector==$PROSPECTOR_VERSION" \
    "radon==$RADON_VERSION"

VOLUME /data

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

USER linter
ENV HOME /data
WORKDIR /data

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["sh"]
