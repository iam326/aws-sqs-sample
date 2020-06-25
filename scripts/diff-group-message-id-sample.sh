#!/bin/bash

# 異なるメッセージグループIDのメッセージを複数送信した後、
# 1回の受信で全てのメッセージを取得する

set -euo pipefail

source ../config.sh

readonly QUEUE_URL=$(aws cloudformation describe-stacks \
  --stack-name ${STACKNAME} \
  --query "Stacks[].Outputs[?OutputKey=='SQSQueueURL'].OutputValue" \
  --output text \
)

echo "Send 10 messages ..."

for i in `seq 0 9`
do
  VAL="TEST"$(date +%s)
  echo ${VAL}
  ./send-message.sh ${VAL} ${VAL}
done

echo "Receive 10 message ..."

aws sqs receive-message \
  --queue-url ${QUEUE_URL} \
  --max-number-of-messages 10
