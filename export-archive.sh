#!/bin/sh

set -eo pipefail

xcodebuild -archivePath ./Afterparty.xcarchive \
           -exportOptionsPlist ./ExportOptions.plist \
           -exportPath ./AfterpartyProducts \
           -allowProvisioningUpdates \
           -exportArchive  | xcpretty