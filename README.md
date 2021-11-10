![https://github.com/compscidr/lolminer-docker/actions/workflows/build.yml](https://github.com/compscidr/lolminer-docker/actions/workflows/build.yml/badge.svg)
# lolminer-docker
Tried to make it as simple as possible to run the miner without worrying about
drivers or the mining software (at least on amd).

## amd:
Tested with Ubuntu 20.04 and 20.10 host operating systems without any special
drivers installed on the host OS (ie, don't need to worry about the mess of
AMD drivers in the most recent Ubuntu OS's).

https://hub.docker.com/repository/docker/compscidr/lolminer-docker
From dockerhub:
```
docker run --device=/dev/dri:/dev/dri -e COIN=YOURCOIN -e HOST=POOLHOST -e PORT=POOLPORT -e WALLET=YOURWALLET -e MACHINE=YOURMACHINE -e APIHOST=somehost -e APIPORT=someport compscidr/lolminer-docker:amd-1.35
```

For instance:
```
docker run --device=/dev/dri:/dev/dri -e COIN=ETH -e HOST=eth.2miners.com -e PORT=2020 -e WALLET=0x74ba897f65f04008d8eff364efcc54b0a20e17eb -e MACHINE=docker -e APIHOST=0.0.0.0 -e APIPORT=4069 compscidr/lolminer-docker:amd-1.35
```

Alternatively, use the docker-compose file, adjust the environment variables:
```
docker-compose build
docker-compose up
```

The only fees are the lolminer fees, I didn't add any additional fees.

## nvidia:
On the host, you need a bit more work to get the nvidia docker runtime:
```
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
sudo systemctl restart docker

docker run --gpus all -e COIN=YOURCOIN -e HOST=POOLHOST -e PORT=POOLPORT -e WALLET=YOURWALLET -e MACHINE=YOURMACHINE -e APIHOST=0.0.0.0 -e APIPORT=4069 compscidr/lolminer-docker:nvidia-1.35
```

Confirmed working with a ubuntu20.04 host and an nvidia rtx 3080 gpu.
