#!/bin/sh

set -eo pipefail

xcodebuild -project Afterparty.xcodeproj \
           -scheme "Afterparty Prod Tests" \
           -sdk iphonesimulator \
           -destination 'platform=iOS Simulator,name=iPhone 14,OS=latest' \
            test