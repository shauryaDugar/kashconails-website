#!/bin/bash
app="docker.kashco"
docker build -t ${app} .
docker run -d -p 56733:80 \
  --name=${app} VIRTUAL_HOST=kashconails.in\
  -v "$PWD:/app" ${app}