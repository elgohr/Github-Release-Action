FROM ubuntu:24.04@sha256:35b7fc72eb7c652dc1f4e5bfbdb9cdb308c3a6b1b96abc61317b931007b9aac8 as testEnv
RUN apt-get update && apt-get install -y coreutils bats

ADD mock.sh /usr/local/mock/gh
ADD mock.sh /usr/local/mock/cd

ADD entrypoint.sh /entrypoint.sh
ADD test.bats /test.bats

RUN /test.bats
