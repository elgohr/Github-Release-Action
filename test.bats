#!/usr/bin/env bats

setup(){
    export PATH="/usr/local/mock:/usr/bin"
    cat /dev/null >| mockArgs
    cat /dev/null >| mockStdin

    declare -A -p MOCK_RETURNS=(
    ['/usr/local/mock/gh']=""
    ['/usr/local/mock/cd']=""
    ) > mockReturns

    export INPUT_TITLE='TITLE'
}

teardown() {
    unset INPUT_WORKDIR
    unset INPUT_TAG
}

@test "it creates a release" {
    run /entrypoint.sh

    expectMockCalledIs "/usr/local/mock/gh release create release-$(date +%Y%m%d%H%M%S) -t TITLE --generate-notes"
}

@test "it creates a release with a predefined tag" {
    export INPUT_TAG="TAG"

    run /entrypoint.sh

    expectMockCalledIs "/usr/local/mock/gh release create ${INPUT_TAG} -t TITLE --generate-notes"
}

@test "it creates a release in a working directory" {
    export INPUT_WORKDIR="WORKDIR"
    export INPUT_TAG="TAG"

    run /entrypoint.sh

    expectMockCalledIs "/usr/local/mock/gh release create ${INPUT_TAG} -t TITLE --generate-notes"
}

expectMockCalledIs() {
    local expected=$(echo "${1}" | tr -d '\n')
    local got=$(cat mockArgs | tr -d '\n')
    echo "Expected: |${expected}|
    Got: |${got}|"
    [ "${got}" == "${expected}" ]
}
