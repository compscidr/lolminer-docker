![https://github.com/compscidr/lolminer-docker/actions/workflows/build.yml](https://github.com/compscidr/lolminer-docker/actions/workflows/build.yml/badge.svg)
# lolminer-docker
Tried to make it as simple as possible to run the miner without worrying about
drivers or the mining software.

Tested with Ubuntu 20.04 and 20.10 host operating systems without any special
drivers installed on the host OS (ie, don't need to worry about the mess of
AMD drivers in the most recent Ubuntu OS's).

https://hub.docker.com/repository/docker/compscidr/lolminer-docker

## Running:
From dockerhub:
```
docker run --device=/dev/dri:/dev/dri -e COIN=YOURCOIN -e HOST=POOLHOST -e PORT=POOLPORT -e WALLET=YOURWALLET -e MACHINE=YOURMACHINE compscidr/lolminer-docker
```

For instance:
```
docker run --device=/dev/dri:/dev/dri -e COIN=ETH -e HOST=eth.2miners.com -e PORT=2020 -e WALLET=0x74ba897f65f04008d8eff364efcc54b0a20e17eb -e MACHINE=docker compscidr/lolminer-docker
```

Alternatively, use the docker-compose file, adjust the environment variables:
```
docker-compose build
docker-compose up
```

The only fees are the lolminer fees, I didn't add any additional fees.
