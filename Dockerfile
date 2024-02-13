FROM debian:bookworm@sha256:4482958b4461ff7d9fabc24b3a9ab1e9a2c85ece07b2db1840c7cbc01d053e90

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
