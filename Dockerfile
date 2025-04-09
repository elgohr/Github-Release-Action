FROM ubuntu:24.04@sha256:4a988f87aabbee19c3935e3106dbfbf63a505d4baf4a5192eb5c8cc45c8cb853 as testEnv
RUN apt-get update && apt-get install -y coreutils bats

ADD mock.sh /usr/local/mock/gh
ADD mock.sh /usr/local/mock/cd

ADD entrypoint.sh /entrypoint.sh
ADD test.bats /test.bats

RUN /test.bats
