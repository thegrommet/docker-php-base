FROM dailygrommet/php-cli-base
LABEL description="The Grommet PHP for CI"
LABEL maintainer="aria@thegrommet.com"

RUN apt-get install -y gnupg2
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    apt-get install -y \
        nodejs \
        git \
        wget \
        libappindicator3-1 fonts-liberation libasound2 libatk-bridge2.0-0 libgtk-3-0 libnspr4 libnss3 libx11-xcb1 libxss1 libxtst6 xdg-utils && \
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i google-chrome*.deb

RUN pecl install xdebug-2.7.0beta1 && \
    docker-php-ext-enable xdebug && \
    touch /var/log/xdebug.log && \
    chown www-data:www-data /var/log/xdebug.log

COPY xdebug.ini /usr/local/etc/php/conf.d/

RUN groupadd --gid 3434 ci \
  && useradd --uid 3434 --gid ci --shell /bin/bash --create-home ci

# Install composer
RUN php -r "copy('https://raw.githubusercontent.com/composer/getcomposer.org/master/web/installer', 'composer-setup.php');" &&     php composer-setup.php &&     php -r "unlink('composer-setup.php');" &&     mv composer.phar /usr/local/bin/composer

USER ci

CMD ["/bin/sh"]
