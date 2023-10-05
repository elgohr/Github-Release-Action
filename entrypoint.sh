#!/bin/sh
gh release create -t "${INPUT_TITLE}" "$(date +%Y%m%d%H%M%S)" --generate-notes
