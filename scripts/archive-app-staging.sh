#!/bin/sh

set -eo pipefail

# set build number to todays date
/usr/libexec/Plistbuddy -c "Set CFBundleVersion ${date +"%Y%m%d"}" "./Afterparty/Info.plist"

xcodebuild -project Afterparty.xcodeproj \
           -scheme "Afterparty Staging" \
           -sdk iphoneos \
           -archivePath ./Afterparty.xcarchive \
           -configuration "Release Staging" \
           clean archive