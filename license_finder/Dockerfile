FROM licensefinder/license_finder:5.2.3

# TODO: add nuget
# https://docs.microsoft.com/en-us/nuget/install-nuget-client-tools#macoslinux
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF &&\
  #apt-get install apt-transport-https &&\
  echo "deb https://download.mono-project.com/repo/ubuntu stable-trusty main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list &&\
  apt-get update &&\ 
  apt-get install -y mono-complete &&\
  curl -o /usr/local/bin/nuget.exe https://dist.nuget.org/win-x86-commandline/latest/nuget.exe &&\
  echo "alias nuget=\"mono /usr/local/bin/nuget.exe\"" >> ~/.bash_aliases

# TODO: labels?

### app
COPY ./requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip install -r requirements.txt

COPY . /app

EXPOSE 5000

CMD [ "python", "app.py" ]