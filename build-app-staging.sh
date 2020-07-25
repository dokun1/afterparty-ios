#!/bin/sh

set -eo pipefail

xcodebuild -scheme "Afterparty Staging" \
           -target Afterparty \
           -sdk iphonesimulator \
            clean build