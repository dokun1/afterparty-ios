#!/bin/sh

set -eo pipefail

xcodebuild -exportArchive \ 
           -archivePath ./Afterparty.xcarchive \
           -allowProvisioningUpdates \
           -exportOptionsPlist ./ExportOptions.plist \
           -exportPath ./AfterpartyProducts | xcpretty