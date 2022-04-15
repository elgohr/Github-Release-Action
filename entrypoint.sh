#!/bin/sh
hub release create -m "${INPUT_TITLE}" "$(date +%Y%m%d%H%M%S)"
