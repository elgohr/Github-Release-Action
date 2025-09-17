FROM ubuntu:24.04@sha256:353675e2a41babd526e2b837d7ec780c2a05bca0164f7ea5dbbd433d21d166fc as testEnv
RUN apt-get update && apt-get install -y coreutils bats

ADD mock.sh /usr/local/mock/gh
ADD mock.sh /usr/local/mock/cd

ADD entrypoint.sh /entrypoint.sh
ADD test.bats /test.bats

RUN /test.bats
