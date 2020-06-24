#!/bin/bash

set -euo pipefail

readonly PROJECT_NAME="aws-sqs-sample"
readonly STACKNAME="${PROJECT_NAME}-stack"
readonly QUEUE_NAME="${PROJECT_NAME}-queue.fifo"
