init-demo:
	$(MAKE) init-lagoona
	$(MAKE) init-skillnotes

init-skillnotes:
	mkdir ./demo
	cd ./demo && git clone https://github.com/dv0vd/demo-skillnotes.git && cp ../.env ./demo-skillnotes/.env

init-lagoona:
	mkdir ./demo
	cd ./demo && git clone https://github.com/dv0vd/demo-lagoona.git

refresh-demo:
	rm ./demo -rf
	$(MAKE) init-demo

refresh-lagoona:
	rm ./demo/demo-lagoona -rf
	$(MAKE) init-lagoona

refresh-skillnotes:
	rm ./demo/demo-skillnotes -rf
	$(MAKE) init-skillnotes