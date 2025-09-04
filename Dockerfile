FROM ubuntu:24.04@sha256:9cbed754112939e914291337b5e554b07ad7c392491dba6daf25eef1332a22e8 as testEnv
RUN apt-get update && apt-get install -y coreutils bats

ADD mock.sh /usr/local/mock/gh
ADD mock.sh /usr/local/mock/cd

ADD entrypoint.sh /entrypoint.sh
ADD test.bats /test.bats

RUN /test.bats
