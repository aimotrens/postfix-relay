FROM debian:bookworm@sha256:d93aa0b2100e5aea695a6584b1d694d1a14ea783ab86dbc33962efdc8c9819c9

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
