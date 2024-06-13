FROM debian:bookworm@sha256:afa55815a92b4a77511569beb652efde33b9c7d27d25efa745311107f5ae6257

RUN apt-get update && \
    apt-get install -y postfix procps && \
    rm -rf /var/lib/apt/lists/*

ADD ./config /config

WORKDIR /etc/postfix
RUN rm ./main.cf && \
    ln -s /config/main.cf ./main.cf && \
    rm ./master.cf && \
    ln -s /config/master.cf ./master.cf

ADD startup.sh /startup.sh
RUN chmod o+x /startup.sh

CMD ["/startup.sh"]
