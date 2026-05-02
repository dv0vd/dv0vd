mtproto-get-link:
	@echo 'tg://proxy?server=${PUBLIC_IP}&port=443&secret=${MTPROTO_SECRET}'

mtproto-generate-secret:
	podman run --rm \
  		docker.io/nineseconds/mtg:2.2.8 \
  		generate-secret ${BASE_URL}
