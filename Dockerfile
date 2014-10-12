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

# Locale
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq && apt-get install -y locales -qq && locale-gen en_US.UTF-8 en_us && dpkg-reconfigure locales && dpkg-reconfigure locales && locale-gen C.UTF-8 && /usr/sbin/update-locale LANG=C.UTF-8
ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8
ENV LC_ALL C.UTF-8

# Download
RUN cd /root && wget https://rubygems.org/downloads/bukovina-0.0.3.gem && gem unpack bukovina-0.0.3.gem
RUN cd /root && wget https://rubygems.org/downloads/drep-0.3.4.gem && gem unpack drep-0.3.4.gem

# Milkode
RUN milk init
ADD milkode/ /root/milkode/
RUN cd /root/milkode && bundle install

# Test1
RUN cd /root/milkode && bundle exec milk add ../jmail-0.3.0

# Test2
RUN mkdir /root/z
RUN ruby -e 'File.open("/root/z/\xff", "w")'
RUN cd /root/milkode && bundle exec milk add ../z

# Test3
RUN cd /root/milkode && bundle exec milk add ../bukovina-0.0.3

# Test4
RUN cd /root/milkode && bundle exec milk add ../drep-0.3.4






