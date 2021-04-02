FROM guenterbailey/amdgpu:ubuntu_1604_18.30

# todo split out amd gpu pro into another docker image
RUN apt-get -qq update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  curl \
  wget \
  tar \
  ca-certificates

RUN mkdir /lolminer && wget https://github.com/Lolliedieb/lolMiner-releases/releases/download/1.24/lolMiner_v1.24a_Lin64.tar.gz  && tar xvf lolMiner_v1.24a_Lin64.tar.gz -C /lolminer

CMD /lolminer/1.24a/lolMiner --coin ETH --pool eth.2miners.com --port 2020 --user 0x74ba897f65f04008d8eff364efcc54b0a20e17eb.docker
