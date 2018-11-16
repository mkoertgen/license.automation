FROM licensefinder/license_finder:5.5.2

ARG http_proxy=
ARG https_proxy=
ARG no_proxy=

ENV LICENSE_CACHE_DIR  '/tmp/license_scanner/cache'

RUN mkdir -p /usr/share/license_scanner
WORKDIR /usr/share/license_scanner
COPY Gemfile* ./
RUN bash -lc 'bundle install'

COPY . ./
RUN bash -lc 'rake test'

EXPOSE 3000
CMD bash -lc 'rm -f ./tmp/pids/server.pid && rails s'

