FROM ubuntu:24.04@sha256:47d12cfcd8a60e27ffe5cb3471487c491ab2093acd8daeee9751c250a3a10c54 as testEnv
RUN apt-get update && apt-get install -y coreutils bats

ADD mock.sh /usr/local/mock/gh
ADD mock.sh /usr/local/mock/cd

ADD entrypoint.sh /entrypoint.sh
ADD test.bats /test.bats

RUN /test.bats
