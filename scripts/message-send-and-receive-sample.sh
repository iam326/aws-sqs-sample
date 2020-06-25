#!/bin/bash

set -euo pipefail

source ../config.sh

echo "Send 5 messages ..."

VAL="TEST"$(date +%s)
for i in `seq 0 1`
do
  echo ${VAL}
  ./send-message.sh ${VAL}
  # 重複するメッセージはQueueに格納されない
done

for i in `seq 0 3`
do
  VAL="TEST"$(date +%s)
  echo ${VAL}
  ./send-message.sh ${VAL}
done

echo "Receive 5 message ..."

for i in `seq 0 4`
do
  ./receive-message.sh
done
