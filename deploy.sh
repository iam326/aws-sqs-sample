#!/bin/bash

set -euo pipefail

readonly PROJECT_NAME="aws-sqs-sample"

readonly TEMPLATE="`pwd`/template.yaml"
readonly STACKNAME="${PROJECT_NAME}-stack"
readonly QUEUE_NAME="${PROJECT_NAME}-queue.fifo"

aws cloudformation validate-template \
  --template-body "file://${TEMPLATE}"

aws cloudformation deploy \
  --stack-name ${STACKNAME} \
  --template-file ${TEMPLATE} \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    QueueName=${QUEUE_NAME}
