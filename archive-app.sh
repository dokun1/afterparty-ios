#!/bin/sh

set -eo pipefail

xcodebuild -scheme "Afterparty Prod" \
           -destination generic/platform=iOS \
           -target Afterparty \
           -archivePath ./Afterparty.xcarchive \
            build archive | xcpretty