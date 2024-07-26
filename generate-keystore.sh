#!/bin/bash
# ============
# Globals
# ============
KEYSTORE_FILE=keystore.jks
KEYSTORE_PASSWORD=123456

# ==================================================
# extract x509 certificate and import into keystore
# ==================================================
function importIntoStore(){
    CONNECT_HOSTNAME=$1
    SERVER_NAME=$2

    CERT_FILENAME=$SERVER_NAME.cert

    echo -n | openssl s_client -connect $CONNECT_HOSTNAME -servername $SERVER_NAME | openssl x509 > $CERT_FILENAME
    keytool -import -noprompt -alias $SERVER_NAME -keystore $KEYSTORE_FILE -file $CERT_FILENAME -storepass $KEYSTORE_PASSWORD
    rm -f $CERT_FILENAME
}

# ======================
# MAIN
# ======================

# create blank keystore
rm -f $KEYSTORE_FILE
keytool -genkey \
    -deststoretype pkcs12 -keystore $KEYSTORE_FILE \
    -dname "CN=HAWK-Local-Dev, OU=BP2S, O=BNP, L=Portugal, S=Lisbon, C=PT" \
    -storepass $KEYSTORE_PASSWORD -keypass $KEYSTORE_PASSWORD

# delete the default alias 'mykey'
keytool -delete -noprompt -alias "mykey" -keystore $KEYSTORE_FILE -storepass $KEYSTORE_PASSWORD

# start importing certificates
importIntoStore "google.com:443" "google.com" #sample

# list all aliases
keytool -list -keystore $KEYSTORE_FILE -storepass $KEYSTORE_PASSWORD

