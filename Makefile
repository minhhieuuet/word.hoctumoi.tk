ifndef u
u:=root
endif

ifndef env
env:=dev
endif

OS:=$(shell uname)

build:
	npm i && npm run build && cp .env.example .env

rebuild:
	rm -rf node_modules
	make build

deploy:
	ssh $(u)@$(h) "mkdir -p $(dir)"
	rsync -avhzL --delete \
				--no-perms --no-owner --no-group \
				--exclude .git \
        --exclude .env \
				--exclude .idea \
				--exclude node_modules \
				. $(u)@$(h):$(dir)/

deploy-prod:
	make deploy h=139.180.204.128 dir=/var/www/html/word.hoctumoi.tk
	ssh root@139.180.204.128 "cd /var/www/html/word.hoctumoi.tk"