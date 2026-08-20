enter-nginx:
	podman exec -it nginx sh

enter-synapse:
	podman exec -it synapse bash

enter-outline:
	podman exec -it outline sh

enter-doh-server:
	podman exec -it doh-server bash

enter-livekit:
	podman exec -it livekit sh

enter-email:
	podman exec -it email bash

enter-coturn:
	podman exec -it coturn bash

enter-sip:
	podman exec -it sip bash

enter-xray-vless-reality-whitelist-bypass:
	podman exec -it xray-vless-reality-whitelist-bypass bash