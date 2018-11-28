all:
	docker build -f Dockerfile.cli -t dailygrommet/php-cli-base .
	docker build -f Dockerfile.fpm -t dailygrommet/php-fpm-base .
