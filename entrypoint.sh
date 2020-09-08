#!/usr/bin/env sh
set -e

mkdir ~/.kube

CLUSTER_ID=`curl -s -u ${RANCHER_TOKEN} ${RANCHER_ENTRYPOINT}/v3/clusters?name=${NODIS_CLUSTER_NAME} | jq -r .data[].id`
curl -s -u ${RANCHER_TOKEN} ${RANCHER_ENTRYPOINT}/v3/clusters/${CLUSTER_ID}/?action=generateKubeconfig -X POST -H 'content-type: application/json' | jq -r .config > kubeconfig

kubectl -v=6 --kubeconfig=kubeconfig config get-contexts
kubectl -v=6 --kubeconfig=kubeconfig -n ${NODIS_K8S_NAMESPACE} set image ${NODIS_SERVICE_TYPE}/${NODIS_SERVICE_NAME} ${NODIS_SERVICE_NAME}=${NODIS_IMAGE_NAME}:${NODIS_FULL_VERSION}