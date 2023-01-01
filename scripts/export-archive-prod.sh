#!/bin/sh

set -eo pipefail

xcodebuild -archivePath ./Afterparty.xcarchive \
           -exportOptionsPlist ./config/ExportOptions.plist \
           -exportPath ./AfterpartyProducts \
           -allowProvisioningUpdates \
           -exportArchive