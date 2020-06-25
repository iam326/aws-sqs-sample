#!/bin/bash

set -euo pipefail

source ../config.sh

readonly QUEUE_URL=$(aws cloudformation describe-stacks \
  --stack-name ${STACKNAME} \
  --query "Stacks[].Outputs[?OutputKey=='SQSQueueURL'].OutputValue" \
  --output text \
)

# [Warn]
# The message deletion process takes up to 60 seconds. We recommend waiting for 60 seconds regardless of your queue's size.
aws sqs purge-queue --queue-url ${QUEUE_URL}
