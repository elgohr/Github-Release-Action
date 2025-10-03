FROM ubuntu:24.04@sha256:728785b59223d755e3e5c5af178fab1be7031f3522c5ccd7a0b32b80d8248123 as testEnv
RUN apt-get update && apt-get install -y coreutils bats

ADD mock.sh /usr/local/mock/gh
ADD mock.sh /usr/local/mock/cd

ADD entrypoint.sh /entrypoint.sh
ADD test.bats /test.bats

RUN /test.bats
