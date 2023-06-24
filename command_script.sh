#!/bin/bash

function ver { printf "%03d%03d" $(echo "$1" | tr '.' ' '); }
K8S_VERSION=$(kubectl version --short 2>&1 | grep 'Server Version' | awk -F' v' '{ print $2; }' | awk -F. '{ print $1"."$2; }')

if [[ $(ver $K8S_VERSION) -lt $(ver "1.25") ]]; then
  KSM_IMAGE_VERSION="v2.6.0"
else
  KSM_IMAGE_VERSION="v2.7.0"
fi

helm repo add newrelic https://helm-charts.newrelic.com
helm repo update

kubectl create namespace newrelic
helm upgrade --install newrelic-bundle newrelic/nri-bundle \
  --set global.licenseKey=18b3c22382070ba7974d17b8976f1db19580NRAL \
  --set global.cluster=my-eks \
  --namespace=newrelic \
  --set newrelic-infrastructure.privileged=true \
  --set global.lowDataMode=true \
  --set kube-state-metrics.image.tag=${KSM_IMAGE_VERSION} \
  --set kube-state-metrics.enabled=true \
  --set kubeEvents.enabled=true \
  --set logging.enabled=true \
  --set newrelic-logging.lowDataMode=false
