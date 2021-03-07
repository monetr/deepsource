#!/bin/sh

UPSTREAM-TAG=$((cd ./cli && git describe))

/kaniko/executor --context $CI_PROJECT_DIR \
  --build-arg $CI_COMMIT_SHA \
  --dockerfile $CI_PROJECT_DIR/Dockerfile \
  --destination ghcr.io/harderthanitneedstobe/deepsource:latest \
  --destination ghcr.io/harderthanitneedstobe/deepsource:$(UPSTREAM-TAG)
