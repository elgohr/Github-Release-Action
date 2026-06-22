FROM ubuntu:26.04@sha256:53958ec7b67c2c9355df922dd08dbf0360611f8c3cdb656875e81873db9ffdba as testEnv
RUN apt-get update && apt-get install -y coreutils bats

ADD mock.sh /usr/local/mock/gh
ADD mock.sh /usr/local/mock/cd

ADD entrypoint.sh /entrypoint.sh
ADD test.bats /test.bats

RUN /test.bats
