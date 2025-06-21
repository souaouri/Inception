SHELL := /bin/bash

up:
	docker compose --file ./srcs/docker-compose.yml up --build -d

down:
	docker compose --file ./srcs/docker-compose.yml down -v

fclean: down
	@sudo rm -rf /home/souaouri/data/*/*
	@docker rmi $$(docker images -qa) -f
	@docker system prune -a -f <<<"y"

re: fclean up