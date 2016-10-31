#!/bin/bash
echo "stopping homebridge in case it is running"
docker stop -t 60 homebridge
echo "removing old container"
docker rm homebridge
echo "starting new instance of homebridge"
docker run -d --net=host --name=homebridge -p 51826:51826 -v /share/Public/homebridge:/root/.homebridge rgrasmus/homebridge-docker:0.18
echo "done"
