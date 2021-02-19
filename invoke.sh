#!/bin/bash

container="weather_notifications_local"

docker build -t $container .                                  &&\
docker run --name $container -d $container /bin/sh            &&\
docker cp $container:/work/bootstrap .                        &&\
docker rm $container                                          &&\
sls invoke local --docker -f weather_notifications -d {}