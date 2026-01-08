#!/usr/bin/env bash

# Mac-compatible test script for entrypoint.sh
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counters
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Create a temporary directory for mocks
MOCK_DIR=$(mktemp -d)
trap "rm -rf ${MOCK_DIR}" EXIT

setup() {
    # Reset mock files
    echo "" > "${MOCK_DIR}/mockArgs"
    echo "" > "${MOCK_DIR}/mockStdin"

    # Create mock gh command
    cat > "${MOCK_DIR}/gh" << 'EOF'
#!/usr/bin/env bash
binary="$0"
parameters="$@"
echo "${binary} ${parameters}" >> mockArgs
exit 0
EOF
    chmod +x "${MOCK_DIR}/gh"

    # Set up PATH to use our mock
    export PATH="${MOCK_DIR}:${PATH}"

    # Set up working directory for mock files
    cd "${MOCK_DIR}"

    # Set default input
    export INPUT_TITLE='TITLE'
}

teardown() {
    unset INPUT_WORKDIR
    unset INPUT_TAG
    unset INPUT_PRERELEASE
    unset INPUT_UPLOAD_ASSETS
    unset INPUT_TITLE
}

expectMockCalledIs() {
    local expected=$(echo "${1}" | tr -d '\n')
    # Strip the full path from mock directory and only keep the command
    local got=$(cat "${MOCK_DIR}/mockArgs" | tr -d '\n' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | sed "s|${MOCK_DIR}/||g")

    if [ "${got}" == "${expected}" ]; then
        return 0
    else
        echo -e "${RED}Expected: |${expected}|${NC}"
        echo -e "${RED}Got: |${got}|${NC}"
        return 1
    fi
}

run_test() {
    local test_name="$1"
    local test_func="$2"

    TESTS_RUN=$((TESTS_RUN + 1))

    echo -e "${YELLOW}Running: ${test_name}${NC}"

    setup

    if $test_func; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "${GREEN}✓ PASS: ${test_name}${NC}\n"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "${RED}✗ FAIL: ${test_name}${NC}\n"
    fi

    teardown
}

# Test 1: it creates a release
test_creates_release() {
    "${SCRIPT_DIR}/entrypoint.sh"

    local timestamp=$(date +%Y%m%d%H%M%S)
    # Allow for a 1-second variance in timestamp
    local got=$(cat "${MOCK_DIR}/mockArgs" | tr -d '\n' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

    if echo "${got}" | grep -q "gh release create release-.*-t TITLE --generate-notes"; then
        return 0
    else
        echo -e "${RED}Expected: gh release create release-<timestamp> -t TITLE --generate-notes${NC}"
        echo -e "${RED}Got: ${got}${NC}"
        return 1
    fi
}

# Test 2: it creates a release with a predefined tag
test_creates_release_with_tag() {
    export INPUT_TAG="TAG"

    "${SCRIPT_DIR}/entrypoint.sh"

    expectMockCalledIs "gh release create ${INPUT_TAG} -t TITLE --generate-notes"
}

# Test 3: it creates a release in a working directory
test_creates_release_in_workdir() {
    export INPUT_WORKDIR="${MOCK_DIR}"
    export INPUT_TAG="TAG"

    "${SCRIPT_DIR}/entrypoint.sh"

    expectMockCalledIs "gh release create ${INPUT_TAG} -t TITLE --generate-notes"
}

# Test 4: it creates a prerelease
test_creates_prerelease() {
    export INPUT_TAG="TAG"
    export INPUT_PRERELEASE="true"

    "${SCRIPT_DIR}/entrypoint.sh"

    expectMockCalledIs "gh release create ${INPUT_TAG} -t TITLE --generate-notes --prerelease"
}

# Test 5: it doesn't create a prerelease on false
test_doesnt_create_prerelease_on_false() {
    export INPUT_TAG="TAG"
    export INPUT_PRERELEASE="false"

    "${SCRIPT_DIR}/entrypoint.sh"

    expectMockCalledIs "gh release create ${INPUT_TAG} -t TITLE --generate-notes"
}

# Run all tests
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Running Mac-Compatible Tests${NC}"
echo -e "${GREEN}========================================${NC}\n"

run_test "it creates a release" test_creates_release
run_test "it creates a release with a predefined tag" test_creates_release_with_tag
run_test "it creates a release in a working directory" test_creates_release_in_workdir
run_test "it creates a prerelease" test_creates_prerelease
run_test "it doesn't create a prerelease on false" test_doesnt_create_prerelease_on_false

# Print summary
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Test Summary${NC}"
echo -e "${GREEN}========================================${NC}"
echo -e "Tests run: ${TESTS_RUN}"
echo -e "${GREEN}Tests passed: ${TESTS_PASSED}${NC}"
if [ ${TESTS_FAILED} -gt 0 ]; then
    echo -e "${RED}Tests failed: ${TESTS_FAILED}${NC}"
    exit 1
else
    echo -e "${GREEN}All tests passed!${NC}"
    exit 0
fi

