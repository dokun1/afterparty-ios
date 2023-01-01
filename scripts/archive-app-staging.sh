#!/bin/sh

set -eo pipefail

# get todays date
DATE=`date +'%Y%m%d'`
# set build number to todays date
/usr/libexec/Plistbuddy -c "Set CFBundleVersion $DATE" "./Afterparty/Info.plist"

xcodebuild -project Afterparty.xcodeproj \
           -scheme "Afterparty Staging" \
           -sdk iphoneos \
           -archivePath ./Afterparty.xcarchive \
           -configuration "Release Staging" \
           clean archive