init-demo:
	$(MAKE) init-lagoona

init-lagoona:
	mkdir ./demo
	cd ./demo && git clone https://github.com/dv0vd/demo-lagoona.git

refresh-demo:
	rm ./demo -rf
	$(MAKE) init-demo

refresh-lagoona:
	rm ./demo/demo-lagoona -rf
	$(MAKE) init-lagoona
