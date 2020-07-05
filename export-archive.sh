#!/bin/sh

set -eo pipefail

xcodebuild -exportArchive \ 
           DEVELOPMENT_TEAM=RQ632LL2X3 \
           CODE_SIGN_STYLE=Manual \
           CODE_SIGN_IDENTITY="Apple Distribution: David Okun" \
           PROVISION_PROFILE="AfterpartyAdHoc.mobileprovision" \
           -archivePath ./Afterparty.xcarchive \
           -exportOptionsPlist ./ExportOptions.plist \
           -exportPath ./AfterpartyProducts | xcpretty