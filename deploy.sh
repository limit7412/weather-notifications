#!/bin/bash

stg=$1
[ "$stg" = "" ] && stg="dev"

[ -e bootstrap ] && sudo rm bootstrap

sudo docker run --rm -v $(pwd):/src -w /src      \
jhass/crystal-build-x86_64 crystal build         \
--link-flags -static -o bootstrap src/main.cr && \
sudo chmod +x bootstrap                          || exit 1

sls deploy -s $stg