#
FROM python:3.8-slim
LABEL maintainer "https://github.com/bioplatformsaustralia/"

RUN addgroup --gid 1000 linter \
  && adduser --disabled-password --home /data --no-create-home --system -q --uid 1000 --ingroup linter linter \
  && mkdir /data \
  && chown linter:linter /data

ADD requirements.txt /
RUN pip install --upgrade -r /requirements.txt

VOLUME /data

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

USER linter
ENV HOME /data
WORKDIR /data

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["sh"]
