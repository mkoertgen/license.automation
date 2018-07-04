#!/bin/sh
set -e
wget -T 30 --spider ${ES_URL}
elasticdump --output=/data/packages-2018_07_04.json --input=${ES_URL}/packages-2018_07_04 --type=data
elasticdump --output=/data/.kibana_mapping.json --input=${ES_URL}/.kibana --type=mapping
elasticdump --output=/data/.kibana.json --input=${ES_URL}/.kibana --type=data
