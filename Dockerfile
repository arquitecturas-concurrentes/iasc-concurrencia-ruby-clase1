FROM ghcr.io/arquitecturas-concurrentes/iasc-rvm-debian-slim:main

RUN /bin/bash -l -c 'rvm pkg install openssl'

# install the required ruby versions
ENV OLD_RUBY "2.3.6"
RUN /bin/bash -l -c 'echo "Now installing Ruby $OLD_RUBY" && rvm install $OLD_RUBY --with-openssl-dir=/usr/local/rvm/usr'

ENV REQUIRED_RUBIES "2.7.5"
RUN /bin/bash -l -c 'for version in $REQUIRED_RUBIES; do echo "Now installing Ruby $version"; rvm install $version --autolibs=disable; rvm cleanup all; done'

ENV JRUBY "jruby-9.2.20.0"
RUN /bin/bash -l -c 'echo "Now installing Ruby $JRUBY" && rvm install $JRUBY && rvm cleanup all'
RUN /bin/bash -l -c 'rvm alias create jruby $JRUBY'

# Try to slim a bit the image
RUN apt-get remove -yq g++ gcc

# copy the code from our local repo.
RUN mkdir /app
WORKDIR /app

COPY . .

# login shell by default so rvm is sourced automatically and 'rvm use' can be used
CMD /bin/bash -c htop