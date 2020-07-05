#!/bin/sh

set -eo pipefail

xcodebuild -exportArchive \ 
           -archivePath ./Afterparty.xcarchive \
           -exportOptionsPlist ./ExportOptions.plist \
           -exportPath ./AfterpartyProducts | xcpretty