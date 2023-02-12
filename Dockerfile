FROM ruby:2.7.6-alpine

RUN echo "@edge http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

RUN apk update && apk upgrade && apk add build-base && apk --no-cache add \
  tzdata \
  bash \
  git \
  libstdc++ \
  ca-certificates \
  libffi-dev \
  postgresql-dev \
  postgresql-client \
  linux-headers \
  libpq \
  openssh \
  file \
  libxml2-dev \
  curl \
  nodejs \
  ncurses \
  gmp-dev \
  musl \
  gcompat \
  aws-cli@edge \
  shared-mime-info \
  libucontext-dev \
  && echo ‘gem: --no-document’ > /etc/gemrc 

RUN mkdir -p /app/vendor/gems
WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN gem install bundler:2.2.32

RUN bundle install

COPY . /app

COPY config/database.ci.yml config/database.yml

EXPOSE 3000
ENTRYPOINT ["bundle", "exec"]
CMD ./entrypoint.sh

