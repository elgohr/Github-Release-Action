#!/bin/sh

if [ ! -z "${INPUT_WORKDIR}" ]; then
    cd "${INPUT_WORKDIR}"
fi

# Generate a tag if not provided
if [ -z "${INPUT_TAG}" ]; then
    INPUT_TAG="release-$(date +%Y%m%d%H%M%S)"
    echo "No tag provided. Generated tag: ${INPUT_TAG}"
fi

# Create the release
gh release create "${INPUT_TAG}" -t "${INPUT_TITLE}" --generate-notes
