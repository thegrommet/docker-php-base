FROM dailygrommet/php-cli-base
LABEL description="The Grommet PHP for Circle CI"
LABEL maintainer="aria@thegrommet.com"

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    apt-get install -y \
        gnupg2 \
        nodejs \
        git \
        wget \
        libappindicator3-1 fonts-liberation libasound2 libatk-bridge2.0-0 libgtk-3-0 libnspr4 libnss3 libx11-xcb1 libxss1 libxtst6 xdg-utils && \
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i google-chrome*.deb
