![https://github.com/compscidr/lolminer-docker/actions/workflows/build.yml](https://github.com/compscidr/lolminer-docker/actions/workflows/build.yml/badge.svg)
# lolminer-docker
Tried to make it as simple as possible to run the miner without worrying about
drivers or the mining software (at least on amd). The docker images are named as follows:
`ubuntu<ubuntu-version>-<cuda/amd-version>-<lolminer version>`. For instance:
`ubuntu22.04-cuda-11.7.1-1.84` or `ubuntu22.04-amd-21.30-1.84`

## amd:
Tested with Ubuntu 20.04 and 20.10 host operating systems without any special
drivers installed on the host OS (ie, don't need to worry about the mess of
AMD drivers in the most recent Ubuntu OS's).

For physical hardware, tested with rx580, rx480 gpus.

https://hub.docker.com/repository/docker/compscidr/lolminer-docker
From dockerhub:
```
docker run --device=/dev/dri:/dev/dri compscidr/lolminer-docker:ubuntu22.04-amd-21.30-1.84 <insert lolminer args>
```

For instance:
```
docker run --device=/dev/dri:/dev/dri compscidr/lolminer-docker:ubuntu22.04-amd-21.30-1.84--coin ETH --pool eth.2miners.com --port 2020 --user 0x74ba897f65f04008d8eff364efcc54b0a20e17eb.amd-docker --apihost 0.0.0.0 --apiport 4069
```

The only fees are the lolminer fees, I didn't add any additional fees.

## nvidia:
On the host, you need a bit more work to get the nvidia docker runtime (only required once):
```
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
sudo systemctl restart docker
```

Then you can run as follows:
```
docker run --gpus all compscidr/lolminer-docker:ubuntu22.04-cuda-11.7.1-1.84 --coin ETH --pool eth.2miners.com --port 2020 --user 0x74ba897f65f04008d8eff364efcc54b0a20e17eb.nvidia-docker --apihost 0.0.0.0 --apiport 4069
```

Confirmed working with a ubuntu20.04 host and an nvidia rtx 3080 gpu. On a fresh
Ubuntu 20.04 install, cuda 11.4.2 image will work, however if you've got
a newer version on your host for some other reason, you can bump to a newer cuda
version in the image as well if you want. You can check your cuda version and
gpu driver version with `nvidia-smi`

## docker-compose
Alternatively you can use the provided docker-compose file which will build
everything from source. You will want to update the `entrypoint` within the
docker-compose.yml file to use your own wallet and arguments for lolminer.

Then for AMD:
`docker-compose --profile amd up`

and for Nvidia:
`docker-compose --profile nvidia up`
