ARG COIN=ETH
ARG HOST=eth.2miners.com
ARG PORT=2020
ARG WALLET=0x74ba897f65f04008d8eff364efcc54b0a20e17eb
ARG MACHINE=docker
ARG LOLMINER_VERSION=1.42

# to make compatible with this prometheus exporter:
# https://github.com/platofff/prometheus-mining
ARG APIPORT=4069
ARG APIHOST=0.0.0.0

##########################################################
# amd
FROM compscidr/amdgpu:ubuntu_20.04_21.30 as amd
ARG COIN
ARG HOST
ARG PORT
ARG WALLET
ARG MACHINE
ARG LOLMINER_VERSION
ARG APIPORT
ARG APIHOST

ENV COIN=$COIN \
    HOST=$HOST \
    PORT=$PORT \
    WALLET=$WALLET \
    MACHINE=$MACHINE \
    APIPORT=$APIPORT \
    APIHOST=$APIHOST

# todo split out amd gpu pro into another docker image
RUN apt-get -qq update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  curl \
  wget \
  tar \
  ca-certificates

RUN mkdir /lolminer && wget -O lolminer.tar.gz https://github.com/Lolliedieb/lolMiner-releases/releases/download/${LOLMINER_VERSION}/lolMiner_v${LOLMINER_VERSION}_Lin64.tar.gz  \
  && tar xvf lolminer.tar.gz --strip-components 1 -C /lolminer

CMD /lolminer/lolMiner --coin $COIN --pool $HOST --port $PORT --user $WALLET.$MACHINE --apihost $APIHOST --apiport $APIPORT

##########################################################
# nvidia
FROM nvidia/cuda:11.6.0-base-ubuntu20.04 as nvidia
ARG COIN
ARG HOST
ARG PORT
ARG WALLET
ARG MACHINE
ARG LOLMINER_VERSION
ARG APIPORT
ARG APIHOST

ENV COIN=$COIN \
    HOST=$HOST \
    PORT=$PORT \
    WALLET=$WALLET \
    MACHINE=$MACHINE \
    APIPORT=$APIPORT \
    APIHOST=$APIHOST

# todo split out amd gpu pro into another docker image
RUN apt-get -qq update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  curl \
  wget \
  tar \
  ca-certificates

  RUN mkdir /lolminer && wget -O lolminer.tar.gz https://github.com/Lolliedieb/lolMiner-releases/releases/download/${LOLMINER_VERSION}/lolMiner_v${LOLMINER_VERSION}_Lin64.tar.gz  \
    && tar xvf lolminer.tar.gz --strip-components 1 -C /lolminer

CMD /lolminer/lolMiner --coin $COIN --pool $HOST --port $PORT --user $WALLET.$MACHINE --apihost $APIHOST --apiport $APIPORT
