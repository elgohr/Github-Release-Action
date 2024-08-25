#!/bin/sh

if [ ! -z "${INPUT_WORKDIR}" ]; then
    cd "${INPUT_WORKDIR}"
fi

if [ -z "${INPUT_TAG}" ]; then
    INPUT_TAG="release-$(date +%Y%m%d%H%M%S)"
fi

gh release create $INPUT_TAG -t "${INPUT_TITLE}" --generate-notes
