init-demo:
	$(MAKE) init-timers
	$(MAKE) init-skillnotes

refresh-demo:
	rm ./demo -rf
	$(MAKE) init-demo

refresh-lagoona:
	rm ./demo/lagoona -rf
	$(MAKE) init-lagoona

init-timers:
	mkdir ./demo
	cd ./demo
	git clone git@github.com:dv0vd/demo-timers.git
	cp ../.env ./demo-timers/.env
	cd ./demo-timers
	make init

init-skillnotes:
	mkdir ./demo
	cd ./demo
	git clone git@github.com:dv0vd/demo-skillnotes.git
	cp ../.env ./demo-skillnotes/.env
	cd ./demo-skillnotes
	make init

init-lagoona:
	mkdir ./demo
	cd ./demo
	git clone git@github.com:dv0vd/lagoona.git