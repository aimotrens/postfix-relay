FROM debian:trixie-20260610@sha256:50d8c6e4413c3f5f5890208197bd439e60e4b0c6567326bfef8f3ede11d1645b

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
