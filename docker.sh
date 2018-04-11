#!/bin/bash

# From the official documentation at https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#xenial-1604-and-newer
set -eo pipefail

sudo apt-get update

sudo apt-get install apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update && sudo apt-get install docker-ce
