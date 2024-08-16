#!/bin/sh

if [ ! -z "${INPUT_WORKDIR}" ]; then
    cd "${INPUT_WORKDIR}"
fi

gh release create $INPUT_TAG -t "${INPUT_TITLE}" "$(date +%Y%m%d%H%M%S)" --generate-notes
