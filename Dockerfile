FROM bash:latest

RUN apk upgrade

RUN apk add git
RUN git clone https://github.com/bats-core/bats-core.git \
	&& cd bats-core \
  && ./install.sh /usr/local

RUN apk add shellcheck
