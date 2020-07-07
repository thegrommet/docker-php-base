all:
	docker build -f php-base/Dockerfile.cli -t dailygrommet/php-cli-base php-base
	docker build -f php-base/Dockerfile.fpm -t dailygrommet/php-fpm-base php-base
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
