#!/bin/sh

if [ -z "${INPUT_TAG}" ]; then
  INPUT_TAG="$(date +%Y%m%d%H%M%S)"
fi

hub release create -m "${INPUT_TITLE}" "${INPUT_TAG}" 
