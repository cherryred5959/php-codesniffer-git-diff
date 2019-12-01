PHP ?= 7.4
SSH ?= ~/.ssh

.PHONY: start
start: erase build up ## clean current environment, recreate dependencies and spin up again

.PHONY: rebuild
rebuild: start ## same as start

.PHONY: erase
erase: ## stop and delete containers, clean volumes.
		docker-compose stop
		docker-compose rm -v -f

.PHONY: build
build: ## build environment and initialize composer and project dependencies
		docker-compose build --build-arg PHP_VERSION=$(PHP) --build-arg SSH_PATH=$(SSH)

.PHONY: up
up: ## spin up environment
		docker-compose up -d

.PHONY: codesniffer
codesniffer: ## run codesniffer
		docker-compose run php composer run codesniffer

.PHONY: gitdiff
gitdiff: ## run gitdiff
		docker-compose run php composer run gitdiff

