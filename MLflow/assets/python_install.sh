#!/bin/bash

set -e

apt-get update -y

apt install net-tools tree jq sqlite3 python3-pip -y

sudo add-apt-repository -y ppa:deadsnakes/ppa

sudo apt-get update

apt-get install -y python3.11

apt install -y python3.11-venv