# Grommet Docker Images

## Examples

Upgrading to the latest PHP version:

```shell
# build using latest images, tagging as lastest and 7.3 (current version)
docker build --pull \
    -f php-base/Dockerfile.cli \
    -t dailygrommet/php-cli-base -t dailygrommet/php-cli-base:7.3 \
    php-base
# push to docker hub
docker push dailygrommet/php-cli-base

docker build --pull \
    -f php-base/Dockerfile.fpm \
    -t dailygrommet/php-fpm-base -t dailygrommet/php-fpm-base:7.3 \
    php-base
docker push dailygrommet/php-fpm-base

docker build --pull \
    -t dailygrommet/ci-php -t dailygrommet/ci-php:7.3 \
    ci-php
docker push dailygrommet/ci-php
```
