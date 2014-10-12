# ref: https://github.com/nicklegr/docker-milkode
FROM ubuntu

# @todo set timezone

RUN apt-get -y update
RUN apt-get -y install git
RUN apt-get -y install ruby
RUN apt-get -y install ruby-dev
RUN apt-get -y install build-essential

ADD groonga.list /etc/apt/sources.list.d/groonga.list
RUN apt-get update
RUN apt-get install -y --allow-unauthenticated groonga-keyring
RUN apt-get update
RUN apt-get -y install libgroonga-dev

RUN gem install thin --no-ri --no-rdoc
RUN gem install milkode --no-ri --no-rdoc

