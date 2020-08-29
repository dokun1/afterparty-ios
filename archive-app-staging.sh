#!/bin/sh

set -eo pipefail

xcodebuild -project Afterparty.xcodeproj \
           -scheme "Afterparty Staging" \
           -sdk iphoneos \
           -archivePath ./Afterparty.xcarchive \
           -configuration "Release Staging" \
           clean archive