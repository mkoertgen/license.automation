FROM ruby:2.5.1-alpine

# Minimal requirements to run a Rails app
RUN apk add --no-cache --update build-base \
                                linux-headers \
                                git \
                                #postgresql-dev \
                                nodejs \
                                tzdata
WORKDIR /usr/src/app
COPY Gemfile* ./
RUN bundle install

COPY . ./
EXPOSE 3000
CMD [ "rails", "s" ]

