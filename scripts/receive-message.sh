#!/bin/bash

set -euo pipefail

source ../config.sh

readonly QUEUE_URL=$(aws cloudformation describe-stacks \
  --stack-name ${STACKNAME} \
  --query "Stacks[].Outputs[?OutputKey=='SQSQueueURL'].OutputValue" \
  --output text \
)

MESSAGES=$(aws sqs receive-message \
  --queue-url ${QUEUE_URL} \
  --query 'Messages[].[ReceiptHandle, Body]')
  # https://qiita.com/hirotaka-tajiri/items/3405fe18be319557c7e7#2%E6%AC%A1%E5%85%83%E9%85%8D%E5%88%97%E3%81%A7%E5%8F%96%E5%BE%97%E3%81%99%E3%82%8B

RECEIPT_HANDLE=$(echo ${MESSAGES} | jq -r '.[][0]')
BODY=$(echo ${MESSAGES} | jq -r '.[][1]')

echo ${BODY}

aws sqs delete-message \
  --queue-url ${QUEUE_URL} \
  --receipt-handle ${RECEIPT_HANDLE}
