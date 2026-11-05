FROM debian:13@sha256:9c6e381421d0f48d1b8133e573f33c185ee16cbf505eda9c4a8a4791b25ea8a6

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
