#!/bin/sh

set -eo pipefail

xcodebuild -scheme "Afterparty Prod" \
           -target Afterparty \
           -sdk iphonesimulator \
            clean build