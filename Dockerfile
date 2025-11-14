FROM ubuntu:24.04@sha256:4a5ffc07dd015f03d6cb56f209db27ed2378056f7cc8a70ae11d0c35718ed3e6 as testEnv
RUN apt-get update && apt-get install -y coreutils bats

ADD mock.sh /usr/local/mock/gh
ADD mock.sh /usr/local/mock/cd

ADD entrypoint.sh /entrypoint.sh
ADD test.bats /test.bats

RUN /test.bats
