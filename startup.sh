#!/bin/sh

MAIN_CF=/config/main.cf

echo ""
echo --- Configuration ---

if [ ! -z ${MYHOSTNAME+x} ]; then
    echo "myhostname = $MYHOSTNAME" | tee -a $MAIN_CF
fi

if [ ! -z ${RELAYHOST+x} ]; then
    echo "relayhost = $RELAYHOST" | tee -a $MAIN_CF
fi

if [ ! -z ${MYNETWORKS+x} ]; then
    echo "mynetworks = $MYNETWORKS" | tee -a $MAIN_CF
else
    echo "mynetworks = 127.0.0.0/8, 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16" | tee -a $MAIN_CF
fi

if [ ! -z ${SMTP_TLS_SECURITY_LEVEL+x} ]; then
    echo "smtp_tls_security_level = $SMTP_TLS_SECURITY_LEVEL" | tee -a $MAIN_CF
else
    echo "smtp_tls_security_level = encrypt" | tee -a $MAIN_CF
fi

if [ ! -z ${MESSAGE_SIZE_LIMIT+x} ]; then
    echo "message_size_limit = $MESSAGE_SIZE_LIMIT" | tee -a $MAIN_CF
else
    echo "message_size_limit = 20971520" | tee -a $MAIN_CF
fi

echo ---
echo ""

trap 'echo Terminating postfix...; pkill postfix;' TERM INT
postfix start-fg &
echo Starting postfix...
wait $!
