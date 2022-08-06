ARG LOLMINER_VERSION=1.52a
ARG CUDA_VERSION=11.4.2
ARG OS_VERSION=ubuntu20.04
ARG AMD_VERSION=ubuntu_20.04_21.30

##########################################################
# amd
FROM compscidr/amdgpu:${AMD_VERSION} as amd
ARG LOLMINER_VERSION

# todo split out amd gpu pro into another docker image
RUN apt-get -qq update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  curl \
  wget \
  tar \
  ca-certificates

RUN mkdir /lolminer && wget -O lolminer.tar.gz https://github.com/Lolliedieb/lolMiner-releases/releases/download/${LOLMINER_VERSION}/lolMiner_v${LOLMINER_VERSION}_Lin64.tar.gz  \
  && tar xvf lolminer.tar.gz --strip-components 1 -C /lolminer

ENTRYPOINT ["/lolminer/lolMiner"]

##########################################################
# nvidia
# don't bump this because otherwise it breaks on ubuntu 20.04 due to differing cuda version
FROM nvidia/cuda:${CUDA_VERSION}-base-${OS_VERSION} as nvidia
ARG LOLMINER_VERSION

# todo split out amd gpu pro into another docker image
RUN apt-get -qq update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  curl \
  wget \
  tar \
  ca-certificates

  RUN mkdir /lolminer && wget -O lolminer.tar.gz https://github.com/Lolliedieb/lolMiner-releases/releases/download/${LOLMINER_VERSION}/lolMiner_v${LOLMINER_VERSION}_Lin64.tar.gz  \
    && tar xvf lolminer.tar.gz --strip-components 1 -C /lolminer

ENTRYPOINT ["/lolminer/lolMiner"]
