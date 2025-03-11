FROM ruby:3.2.7-alpine3.21

# Prepare Docker image for Nokogiri

RUN apk add --update \
  build-base \
  libxml2-dev \
  libxslt-dev \
  jq \
  nodejs \
  npm \
  postgresql-dev \
  python3-dev \
  sqlite-dev \
  gnu-libiconv \
  shared-mime-info \
  && rm -rf /var/cache/apk/*

# Install AWS CLI
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN python3 -m ensurepip
RUN pip3 install awscli

# Use libxml2, libxslt a packages from alpine for building nokogiri
RUN bundle config build.nokogiri --use-system-libraries

# Install Codefresh CLI
RUN wget https://github.com/codefresh-io/cli/releases/download/v0.31.1/codefresh-v0.31.1-alpine-x64.tar.gz
RUN tar -xf codefresh-v0.31.1-alpine-x64.tar.gz -C /usr/local/bin/