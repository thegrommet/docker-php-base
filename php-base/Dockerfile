FROM php:7.3-fpm
LABEL description="The Grommet PHP FPM Base"
LABEL maintainer="todd@thegrommet.com"

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    apt-get update && apt-get install -y \
    gnupg2 \
    git \
    wget \
    unzip \
    nodejs \
    aspell-en \
\
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libicu-dev \
    libpng-dev \
    libxml2-dev \
    libxslt-dev \
    libc-client-dev \
    libkrb5-dev \
    libzip-dev \
&& \
    npm -g install yarn \
&& \
    docker-php-ext-install -j$(nproc) bcmath exif intl json mbstring pdo_mysql soap xml xsl zip && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) gd \
&& \
    apt-get install -y \
    libmagickcore-dev \
    libmagickwand-dev \
    libmcrypt-dev \
&& \
    pecl install apcu imagick mcrypt && \
    yes no | pecl install redis && \
    docker-php-ext-enable apcu imagick mcrypt redis \
&& \
    apt-get -y purge *-dev && apt-get clean

RUN php -v && php -m

COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN ln -s /usr/bin/composer /usr/local/bin/composer
COPY cacert.pem /usr/local/etc/php/cacert.pem
COPY php.ini /usr/local/etc/php/php.ini
