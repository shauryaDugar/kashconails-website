#!/bin/bash
app="docker.kashco"
docker build -t ${app} .
docker run -d -p 56733:80 -e VIRTUAL_HOST=kashconails.in\
  --name=${app} \
  -v "$PWD:/app" ${app}