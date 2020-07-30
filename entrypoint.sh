#!/usr/bin/env sh

mkdir ~/.kube

CLUSTER_ID=`curl -s -u ${RANCHER_TOKEN} ${RANCHER_ENTRYPOINT}/clusters?name=${NODIS_CLUSTER_NAME} | jq -r .data[].id`
curl -s -u ${RANCHER_TOKEN} ${RANCHER_ENTRYPOINT}/clusters/${CLUSTER_ID}/?action=generateKubeconfig -X POST -H 'content-type: application/json' | jq -r .config > kubeconfig

kubectl -v=6 --kubeconfig=kubeconfig config get-contexts
kubectl -v=6 --kubeconfig=kubeconfig set image ${NODIS_SERVICE_TYPE}/${NODIS_SERVICE_NAME} ${NODIS_SERVICE_NAME}=${NODIS_IMAGE_NAME}:${NODIS_FULL_VERSION}