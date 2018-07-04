#FROM jruby:9.1.17.0-jre-alpine

# TODO: One we have mono/nuget-PR accepted (5.3.1?) skip installation
FROM licensefinder/license_finder:5.3.0
# install nuget/mono, cf.:
# - https://docs.microsoft.com/en-us/nuget/install-nuget-client-tools#macoslinux
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF &&\
  echo "deb https://download.mono-project.com/repo/ubuntu stable-trusty main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list &&\
  apt-get update &&\
  apt-get install -y mono-complete &&\
  curl -o /usr/local/bin/nuget.exe https://dist.nuget.org/win-x86-commandline/latest/nuget.exe &&\
  echo "alias nuget=\"mono /usr/local/bin/nuget.exe\"" >> ~/.bash_aliases

ENV LICENSE_CACHE_DIR  '/tmp/license_scanner/cache'

RUN mkdir -p /usr/share/license_scanner
WORKDIR /usr/share/license_scanner
COPY Gemfile* ./
RUN bash -lc 'bundle install'

COPY . ./
RUN bash -lc 'rake test'

EXPOSE 3000
CMD bash -lc 'rm -f ./tmp/pids/server.pid && rails s'

