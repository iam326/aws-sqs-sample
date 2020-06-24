#!/bin/bash

set -euo pipefail

source ./config.sh

readonly TEMPLATE="`pwd`/template.yaml"

aws cloudformation validate-template \
  --template-body "file://${TEMPLATE}"

aws cloudformation deploy \
  --stack-name ${STACKNAME} \
  --template-file ${TEMPLATE} \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    QueueName=${QUEUE_NAME}
