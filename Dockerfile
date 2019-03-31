FROM ubuntu:16.04
LABEL "com.github.actions.name"="Github Hub"
LABEL "com.github.actions.description"="An easy way to interact with Github from Actions"
LABEL "com.github.actions.icon"="git-branch"
LABEL "com.github.actions.color"="gray-dark"

LABEL "repository"="https://github.com/elgohr/Github-Hub-Action"
LABEL "maintainer"="Lars Gohr"

RUN apt-get update \
  && apt-get install software-properties-common -y --no-install-recommends \
  && add-apt-repository ppa:cpick/hub \
  && apt-get update \
  && apt-get install hub -y --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
