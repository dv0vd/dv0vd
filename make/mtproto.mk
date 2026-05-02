mtproto-get-link:
	podman run --rm \
  		-v ./deployment/configs/mtproto/mtg.toml:/config.toml \
  		docker.io/nineseconds/mtg:2.2.8 \
  		access /config.toml

mtproto-generate-secret:
	@podman run --rm \
  		docker.io/nineseconds/mtg:2.2.8 \
  		generate-secret ${BASE_URL}
