FROM ubuntu:26.04@sha256:513c074113a871b51a8d16ab445c88779d6452d937a164fb5cc479f32668a41d as testEnv
RUN apt-get update && apt-get install -y coreutils bats

ADD mock.sh /usr/local/mock/gh
ADD mock.sh /usr/local/mock/cd

ADD entrypoint.sh /entrypoint.sh
ADD test.bats /test.bats

RUN /test.bats
