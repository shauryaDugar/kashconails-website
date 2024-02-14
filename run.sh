#!/bin/bash
app="docker.kashco"
docker build -t ${app} .
docker run -d -p 443:443 \
  --name=${app} \
  -v "$PWD:/app" ${app} > /dev/null 2>&1
