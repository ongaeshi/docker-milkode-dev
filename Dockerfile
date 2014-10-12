FROM ruby:2.1.3

# Groonga
ADD groonga.list /etc/apt/sources.list.d/groonga.list
RUN apt-get update
RUN apt-get install -y --allow-unauthenticated groonga-keyring
RUN apt-get update
RUN apt-get -y install libgroonga-dev

# Milkode
RUN gem install bundler --no-ri --no-rdoc
RUN gem install thin --no-ri --no-rdoc
RUN gem install milkode --no-ri --no-rdoc
RUN gem install --no-ri --no-rdoc multi_json power_assert rack-test sinatra-contrib sinatra-reloader test-unit

# Test
RUN apt-get -y install wget
RUN cd /root && wget https://rubygems.org/downloads/jmail-0.3.0.gem
RUN cd /root && gem unpack jmail-0.3.0.gem

RUN milk init
ADD milkode/ /root/milkode/
RUN cd /root/milkode && bundle install

RUN cd /root/milkode && bundle exec milk add ../jmail-0.3.0

# Test2
RUN mkdir /root/z
RUN ruby -e 'File.open("/root/z/\xff", "w")'
RUN cd /root/milkode && bundle exec milk add ../z







