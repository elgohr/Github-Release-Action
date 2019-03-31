#!/bin/bash

MESSAGE=$*
hub release create -m ${MESSAGE} $(date +%Y%m%d%H%M%S)
