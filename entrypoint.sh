#!/usr/bin/env sh

mkdir ~/.kube

CLUSTER_ID=`curl -s -u ${NODIS_RANCHER_TOKEN} ${NODIS_RANCHER_ENTRYPOINT}/clusters?name=${NODIS_CLUSTER_NAME} | jq -r .data[].id`
curl -s -u ${NODIS_RANCHER_TOKEN} ${NODIS_RANCHER_ENTRYPOINT}/clusters/${CLUSTER_ID}/?action=generateKubeconfig -X POST -H 'content-type: application/json' | jq -r .config > ~/.kube/kubesystem

kubectl set image ${NODIS_SERVICE_TYPE}/${NODIS_SERVICE_NAME} ${NODIS_SERVICE_NAME}=${NODIS_FULL_VERSION}