#!/usr/bin/env sh

main() {
    if uses "${INPUT_WORKDIR}"; then
        cd "${INPUT_WORKDIR}"
    fi

    if ! uses "${INPUT_TAG}"; then
        INPUT_TAG="release-$(date +%Y%m%d%H%M%S)"
    fi

    OPTIONS="--generate-notes"
    if usesBoolean "${INPUT_PRERELEASE}"; then
        OPTIONS="${OPTIONS} --prerelease"
    fi

    gh release create $INPUT_TAG -t "${INPUT_TITLE}" $OPTIONS
}

uses() {
  [ ! -z "${1}" ]
}

usesBoolean() {
    [ ! -z "${1}" ] && [ "${1}" = "true" ]
}

main
