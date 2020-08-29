#!/bin/sh

set -eo pipefail

xcodebuild -archivePath ./Afterparty.xcarchive \
           -exportOptionsPlist ./ExportOptionsStaging.plist \
           -exportPath ./AfterpartyProducts \
           -allowProvisioningUpdates \
           -exportArchive