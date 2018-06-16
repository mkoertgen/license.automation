FROM jruby:9.1.17.0-jre-alpine

WORKDIR /usr/src/app
COPY Gemfile* ./
RUN bundle install

COPY . ./
RUN rake test

EXPOSE 3000
CMD [ "rails", "s" ]

