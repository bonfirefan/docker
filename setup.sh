#!/bin/bash
set -x

# install pelias script
ln -s "$(pwd)/pelias" /usr/local/bin/pelias

#cwd
cd projects/boston-city

# configure environment 
sed -i '/DATA_DIR/d' .env
echo 'DATA_DIR=/data' >> .env

# run build
pelias compose pull
pelias elastic start
pelias elastic wait
pelias elastic create
pelias download all
pelias prepare all
pelias import all
pelias compose up
