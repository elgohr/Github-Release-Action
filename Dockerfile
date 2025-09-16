FROM ubuntu:24.04@sha256:590e57acc18d58cd25d00254d4ca989bbfcd7d929ca6b521892c9c904c391f50 as testEnv
RUN apt-get update && apt-get install -y coreutils bats

ADD mock.sh /usr/local/mock/gh
ADD mock.sh /usr/local/mock/cd

ADD entrypoint.sh /entrypoint.sh
ADD test.bats /test.bats

RUN /test.bats
