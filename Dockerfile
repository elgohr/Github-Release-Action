FROM ubuntu:24.04@sha256:a328b84b92f71a85f459722a1c73c0363f9f8e3f66bf74a204bb35c605cf670c as testEnv
RUN apt-get update && apt-get install -y coreutils bats

ADD mock.sh /usr/local/mock/gh
ADD mock.sh /usr/local/mock/cd

ADD entrypoint.sh /entrypoint.sh
ADD test.bats /test.bats

RUN /test.bats
