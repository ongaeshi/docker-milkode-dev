# ref: https://github.com/nicklegr/docker-milkode
FROM debian

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

RUN gem install bundler --no-ri --no-rdoc

RUN apt-get -y install wget
RUN cd /root && wget https://rubygems.org/downloads/jmail-0.3.0.gem
RUN cd /root && gem unpack jmail-0.3.0.gem

# milkode gem for development
RUN gem install --no-ri --no-rdoc multi_json power_assert rack-test sinatra-contrib sinatra-reloader test-unit

RUN milk init
ADD milkode/ /root/milkode/
RUN cd /root/milkode && bundle install

RUN cd /root/milkode && bundle exec milk add ../jmail-0.3.0





