#!/bin/sh

INPUT_TITLE="$(echo "$INPUT_TITLE" | tr -d ' ')"

if [ -z "${INPUT_TAG}" ]; then
  INPUT_TAG="$(date +%Y%m%d%H%M%S)"
fi

if [ -z "${INPUT_BODY}" ]; then
  hub release create -m "${INPUT_TITLE}" "${INPUT_TAG}" 
else
  hub release create -m "${INPUT_TITLE}" -m "${INPUT_BODY}" "${INPUT_TAG}" 
fi
