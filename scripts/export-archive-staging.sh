#!/bin/sh

set -eo pipefail

xcodebuild -archivePath ./Afterparty.xcarchive \
           -exportOptionsPlist ./config/ExportOptionsStaging.plist \
           -exportPath ./AfterpartyProducts \
           -allowProvisioningUpdates \
           -exportArchive