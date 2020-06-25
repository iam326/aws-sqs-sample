#!/bin/bash

set -euo pipefail

source ../config.sh

readonly QUEUE_URL=$(aws cloudformation describe-stacks \
  --stack-name ${STACKNAME} \
  --query "Stacks[].Outputs[?OutputKey=='SQSQueueURL'].OutputValue" \
  --output text \
)

aws sqs send-message \
  --queue-url ${QUEUE_URL} \
  --message-body $1 \
  --message-group-id $2
