FROM dailygrommet/php-cli-base
LABEL description="The Grommet PHP for CI"
LABEL maintainer="aria@thegrommet.com"

RUN apt-get install -y \
    libappindicator3-1 \
    fonts-liberation \
    libasound2 \
    libatk-bridge2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libx11-xcb1 \
    libxss1 \
    libxtst6 \
    xdg-utils \
    libgbm1 \
    gcc \
    g++ \
&& \
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i google-chrome*.deb && \
    rm google-chrome*.deb \
&& \
    pecl install xdebug-2.9.6 && \
    docker-php-ext-enable xdebug \
&& \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN groupadd --gid 3434 ci \
  && useradd --uid 3434 --gid ci --shell /bin/bash --create-home ci

USER ci

CMD ["/bin/sh"]
