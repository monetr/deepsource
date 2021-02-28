
docker:
	docker buildx rm deepsource-builder || true
	docker buildx create --use --name deepsource-builder
	docker buildx build --platform linux/amd64,linux/arm64 \
 		-t ghcr.io/harderthanitneedstobe/deepsource:latest \
 		-t ghcr.io/harderthanitneedstobe/deepsource:v0.1.7 \
 		--push .
