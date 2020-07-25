#!/bin/sh

set -eo pipefail

xcodebuild -project Afterparty.xcodeproj \
           -scheme "Afterparty Staging Tests" \
           -sdk iphonesimulator \
           -destination 'platform=iOS Simulator,name=iPhone 11,OS=13.6' \
            test