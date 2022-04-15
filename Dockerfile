FROM debian:11.3
LABEL "repository"="https://github.com/elgohr/Github-Release-Action"
LABEL "maintainer"="Lars Gohr"

RUN apt update \
	&& apt -y upgrade \
  && apt install -y hub \
  && apt autoremove \
	&& apt autoclean \
	&& apt clean

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
