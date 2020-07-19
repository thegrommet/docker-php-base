
DEFAULT_TAG=7.3
ifndef TAG
	TAG=$(DEFAULT_TAG)
endif

.DEFAULT_GOAL := help
.PHONY: help all build tag push

help:
	@echo "Usage: make [options] [target] ..."
	@echo "Targets:"
	@echo "    help       Display this help text"
	@echo "    all        build, tag, and push images"
	@echo "    build      build all images"
	@echo "    tag        tag latest images"
	@echo "    push       push images to docker hub"
	@echo
	@echo "Default TAG: $(DEFAULT_TAG)"
	@echo "Apply a different tag by assigning TAG before command"
	@echo "Example:"
	@echo "    TAG=test make tag"
	@echo


all: build tag push


build:
	docker build -f php-base/Dockerfile -t dailygrommet/php-fpm-base php-base
	docker build -f php-base/Dockerfile.cli -t dailygrommet/php-cli-base php-base
	docker build -t dailygrommet/ci-php ci-php
	docker build -t dailygrommet/awscli aws-cli
	docker build -t dailygrommet/haproxy haproxy
	docker build -t dailygrommet/varnish varnish

tag:
	docker tag dailygrommet/php-cli-base:latest dailygrommet/php-cli-base:$(TAG)
	docker tag dailygrommet/php-fpm-base:latest dailygrommet/php-fpm-base:$(TAG)
	docker tag dailygrommet/ci-php:latest dailygrommet/ci-php:$(TAG)

push:
	docker push dailygrommet/php-cli-base:$(TAG)
	docker push dailygrommet/php-fpm-base:$(TAG)
	docker push dailygrommet/ci-php:$(TAG)
	docker push dailygrommet/awscli:$(TAG)
	docker push dailygrommet/haproxy:$(TAG)
	docker push dailygrommet/varnish:$(TAG)
