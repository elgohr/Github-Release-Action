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

    if usesBoolean "${INPUT_UPLOAD_ASSETS}"; then
        for file in *; do
            if [ -f "$file" ]; then
                gh release create $INPUT_TAG "$file#$INPUT_TAG" -t "${INPUT_TITLE}" $OPTIONS
            fi
        done
    else
        gh release create $INPUT_TAG -t "${INPUT_TITLE}" $OPTIONS
    fi
}

uses() {
  [ ! -z "${1}" ]
}

usesBoolean() {
    [ ! -z "${1}" ] && [ "${1}" = "true" ]
}

main
