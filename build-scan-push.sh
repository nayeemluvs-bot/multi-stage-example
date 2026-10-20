#!/usr/bin/env bash
set -euo pipefail
IMAGE="nayeemluvs/docker03-demo:1.1"
docker build -t "$IMAGE" .
trivy image --severity HIGH,CRITICAL --exit-code 1 "$IMAGE"
docker push "$IMAGE"
