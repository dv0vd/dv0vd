init-demo:
	$(MAKE) init-lagoona
	$(MAKE) init-evklid
	$(MAKE) init-gazprombank-auth
	$(MAKE) init-gazprombank-startups

init-lagoona:
	mkdir -p ./demo
	cd ./demo && git clone https://github.com/dv0vd/demo-lagoona.git

init-evklid:
	mkdir -p ./demo
	cd ./demo && git clone https://github.com/dv0vd/demo-evklid.git

init-gazprombank-auth:
	mkdir -p ./demo
	cd ./demo && git clone https://github.com/dv0vd/demo-gazprombank-auth.git

init-gazprombank-startups:
	mkdir -p ./demo
	cd ./demo && git clone https://github.com/dv0vd/demo-gazprombank-startups.git

refresh-demo:
	rm ./demo -rf
	$(MAKE) init-demo

refresh-lagoona:
	rm ./demo/demo-lagoona -rf
	$(MAKE) init-lagoona

refresh-evklid:
	rm ./demo/demo-evklid -rf
	$(MAKE) init-evklid

refresh-gazprombank-auth:
	rm ./demo/demo-gazprombank-auth -rf
	$(MAKE) init-lagoona

refresh-gazprombank-startups:
	rm ./demo/demo-gazprombank-startups -rf
	$(MAKE) init-lagoona
