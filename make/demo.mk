init-demo:
	$(MAKE) init-timers
	$(MAKE) init-skillnotes

init-timers:
	mkdir ./demo
	cd ./demo && git clone git@github.com:dv0vd/demo-timers.git && cp ../.env ./demo-timers/.env
	cd .. && podman build . -f ./deployment/configs/demo/timers.containerfile -t demo-timers

init-skillnotes:
	mkdir ./demo
	cd ./demo && git clone git@github.com:dv0vd/demo-skillnotes.git && cp ../.env ./demo-skillnotes/.env
	cd .. && podman build . -f ./deployment/configs/demo/skillnotes.containerfile -t demo-skillnotes

init-lagoona:
	mkdir ./demo
	cd ./demo && git clone git@github.com:dv0vd/demo-lagoona.git

refresh-demo:
	rm ./demo -rf
	$(MAKE) init-demo

refresh-lagoona:
	rm ./demo/demo-lagoona -rf
	$(MAKE) init-lagoona

refresh-timers:
	rm ./demo/demo-timers -rf
	$(MAKE) init-timers

refresh-skillnotes:
	rm ./demo/demo-skillnotes -rf
	$(MAKE) init-skillnotes