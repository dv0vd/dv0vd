init-demo:
	$(MAKE) init-lagoona
	$(MAKE) init-gazprombank-auth

init-lagoona:
	mkdir ./demo
	cd ./demo && git clone https://github.com/dv0vd/demo-lagoona.git

init-gazprombank-auth:
	mkdir ./demo
	cd ./demo && git clone https://github.com/dv0vd/demo-gazprombank-auth.git

refresh-demo:
	rm ./demo -rf
	$(MAKE) init-demo

refresh-lagoona:
	rm ./demo/demo-lagoona -rf
	$(MAKE) init-lagoona

refresh-gazprombank-auth:
	rm ./demo/demo-gazprombank-auth -rf
	$(MAKE) init-lagoona
