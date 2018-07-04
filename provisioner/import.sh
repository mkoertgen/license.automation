#!/bin/sh
set -e

wget -T 30 --spider ${ES_URL}
#elasticdump --input=/data/packages-2018_07_04.json --output=${ES_URL}/packages-2018_07_04 --type=data
elasticdump --input=/data/.kibana_mapping.json --output=${ES_URL}/.kibana --type=mapping
elasticdump --input=/data/.kibana.json --output=${ES_URL}/.kibana --type=data
