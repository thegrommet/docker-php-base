all:
	cd php-base && docker build -f Dockerfile.cli -t dailygrommet/php-cli-base .
	cd php-base && docker build -f Dockerfile.fpm -t dailygrommet/php-fpm-base .
	cd circleci-php && docker build -t dailygrommet/circleci-php .
push:
	cd php-base && docker push dailygrommet/php-cli-base 
	cd php-base && docker push dailygrommet/php-fpm-base
	cd circleci-php && docker push dailygrommet/circleci-php
