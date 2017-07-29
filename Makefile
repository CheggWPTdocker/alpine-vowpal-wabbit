.DEFAULT_GOAL := help

build: ## Build it
	docker build -t vwabbit .

run: ## run it -v ${PWD}/code:/app/code
	docker run -p 4000:4000 --name vwabbit_run --rm -id vwabbit

connect: ## connect to it
	docker exec -it vwabbit_run /bin/sh

kill: ## kill it
	docker kill vwabbit_run

it: build run connect ## do it all

.PHONY: help

help: ## Helping devs since 2016
	@cat $(MAKEFILE_LIST) | grep -e "^[a-zA-Z_\-]*: *.*## *" | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo "For additional commands have a look at the README"

