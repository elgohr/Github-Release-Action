FROM debian:10.1
LABEL "com.github.actions.name"="Github Release"
LABEL "com.github.actions.description"="Publish Github releases in an action"
LABEL "com.github.actions.icon"="git-branch"
LABEL "com.github.actions.color"="gray-dark"

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
