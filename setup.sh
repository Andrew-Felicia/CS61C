#!/bin/bash
set -euxo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "Installing apt dependencies..."
apt-get update
apt-get install -y python3 python3-pip python3-dev nodejs gdb valgrind

echo "Installing python3 dependencies..."
pip3 install -r $DIR/requirements.txt

echo "Installing Node.js dependencies"
npm install -g npm
pushd $DIR/project-nike
  npm ci --production
popd
