#!/bin/sh

set -eo pipefail

xcodebuild -project Afterparty.xcodeproj \
           -scheme "Afterparty Prod" \
           -sdk iphoneos \
           -archivePath ./Afterparty.xcarchive \
            build archive | xcpretty