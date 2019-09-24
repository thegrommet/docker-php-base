all:
	docker build -f php-base/Dockerfile.cli -t dailygrommet/php-cli-base php-base
	docker build -f php-base/Dockerfile.fpm -t dailygrommet/php-fpm-base php-base
	docker build -t dailygrommet/ci-php ci-php
	docker build -t dailygrommet/awscli aws-cli
	docker build -t dailygrommet/haproxy haproxy
	docker build -t dailygrommet/varnish varnish
push:
	docker push dailygrommet/php-cli-base
	docker push dailygrommet/php-fpm-base
	docker push dailygrommet/ci-php
	docker push dailygrommet/awscli
	docker push dailygrommet/haproxy
	docker push dailygrommet/varnish
