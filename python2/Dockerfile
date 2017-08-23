#
FROM python:2.7-alpine
LABEL maintainer "https://github.com/muccg/"

ARG ARG_PIP_INDEX_URL="https://pypi.python.org/simple"
ARG ARG_PIP_TRUSTED_HOST="127.0.0.1"
ARG ARG_PROSPECTOR_VERSION
ARG ARG_AUTOPEP8_VERSION
ARG ARG_AUTOFLAKE_VERSION
ARG ARG_FLAKE8_VERSION
ARG ARG_YAPF_VERSION
ARG ARG_PYLINT_VERSION
ARG ARG_RADON_VERSION
ARG ARG_XENON_VERSION

ENV PROSPECTOR_VERSION $ARG_PROSPECTOR_VERSION
ENV AUTOFLAKE_VERSION $ARG_AUTOFLAKE_VERSION
ENV AUTOPEP8_VERSION $ARG_AUTOPEP8_VERSION
ENV FLAKE8_VERSION $ARG_FLAKE8_VERSION
ENV YAPF_VERSION $ARG_YAPF_VERSION
ENV PYLINT_VERSION $ARG_PYLINT_VERSION
ENV RADON_VERSION $ARG_RADON_VERSION
ENV XENON_VERSION $ARG_XENON_VERSION
ENV VIRTUAL_ENV /env
ENV PIP_NO_CACHE_DIR="off"
ENV PIP_INDEX_URL $ARG_PIP_INDEX_URL
ENV PIP_TRUSTED_HOST $ARG_PIP_TRUSTED_HOST
ENV NO_PROXY ${PIP_TRUSTED_HOST}

RUN addgroup -S -g 1000 linter \
    && adduser -D -S -u 1000 -h /data -s /sbin/nologin -G linter linter

# create a virtual env in $VIRTUAL_ENV, ensure it respects pip version
RUN pip install --upgrade virtualenv \
    && virtualenv $VIRTUAL_ENV \
    && $VIRTUAL_ENV/bin/pip install --upgrade pip==$PYTHON_PIP_VERSION
ENV PATH $VIRTUAL_ENV/bin:$PATH

RUN env | sort
RUN pip install --upgrade \
    "autoflake==$AUTOFLAKE_VERSION" \
    "autopep8==$AUTOPEP8_VERSION" \
    "yapf==$YAPF_VERSION" \
    "pylint==$PYLINT_VERSION" \
    "flake8==$FLAKE8_VERSION" \
    "prospector==$PROSPECTOR_VERSION" \
    "radon==$RADON_VERSION" \
    "xenon==$XENON_VERSION"

VOLUME /data

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

USER linter
ENV HOME /data
WORKDIR /data

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["sh"]
