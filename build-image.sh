#!/bin/bash

echo ""

echo -e "\nbuild docker hadoop image\n"
sudo docker build -t docker-hadoop-1.2.1 .

echo ""
