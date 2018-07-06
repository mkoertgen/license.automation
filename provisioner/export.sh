#!/bin/sh
set -e
wget -T 30 --spider ${ES_URL}
elasticdump --output=/data/packages.json --input=${ES_URL}/packages-* --type=data --size=1
elasticdump --output=/data/.kibana_mapping.json --input=${ES_URL}/.kibana --type=mapping
elasticdump --output=/data/.kibana.json --input=${ES_URL}/.kibana --type=data
