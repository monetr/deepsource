
docker:
	docker buildx rm deepsource-builder || true
	docker buildx create --use --name deepsource-builder
	docker buildx build --platform linux/amd64,linux/arm64 \
 		-t ghcr.io/harderthanitneedstobe/deepsource:latest \
 		--push .

UPSTREAM-TAG = $(shell (cd ./cli && git describe))

ci-kaniko-push:
	/kaniko/executor --context $CI_PROJECT_DIR \
		--build-arg $CI_COMMIT_SHA \
		--dockerfile $CI_PROJECT_DIR/Dockerfile \
		--destination ghcr.io/harderthanitneedstobe/deepsource:latest \
		--destination ghcr.io/harderthanitneedstobe/deepsource:$(UPSTREAM-TAG)
