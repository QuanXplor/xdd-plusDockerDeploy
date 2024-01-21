FROM golang:1.19

COPY ./docker-entrypoint.sh /bin/

RUN chmod a+x /bin/docker-entrypoint.sh \
    && apt update && apt install -y wget git

ENTRYPOINT ["/bin/docker-entrypoint.sh"]

WORKDIR /xdd-plus
