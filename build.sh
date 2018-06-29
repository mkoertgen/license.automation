#!/bin/bash -ex
component=$1
docker-compose build ${component}
if [ "$CI_BUILD_REF_NAME" != "master" ]; then exit; fi
docker-compose push ${component}
