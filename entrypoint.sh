#!/bin/bash
echo ">> elgohr/Github-Release-Action@master is deprecated!"
echo ">> Please switch to elgohr/Github-Release-Action@v4"

MESSAGE=$*
hub release create -m ${MESSAGE} $(date +%Y%m%d%H%M%S)
