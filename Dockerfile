FROM guenterbailey/amdgpu:ubuntu_1604_18.30
ARG COIN=ETH
ARG HOST=eth.2miners.com
ARG PORT=2020
ARG WALLET=0x74ba897f65f04008d8eff364efcc54b0a20e17eb
ARG MACHINE=docker

ENV COIN=$COIN \
    HOST=$HOST \
    PORT=$PORT \
    WALLET=$WALLET
    MACHINE=$MACHINE

# todo split out amd gpu pro into another docker image
RUN apt-get -qq update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  curl \
  wget \
  tar \
  ca-certificates

RUN mkdir /lolminer && wget https://github.com/Lolliedieb/lolMiner-releases/releases/download/1.24/lolMiner_v1.24a_Lin64.tar.gz  && tar xvf lolMiner_v1.24a_Lin64.tar.gz -C /lolminer

CMD /lolminer/1.24a/lolMiner --coin $COIN --pool $HOST --port $PORT --user $WALLET.$MACHINE
