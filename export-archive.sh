#!/bin/sh

set -eo pipefail

xcodebuild -exportArchive \ 
           -allowProvisioningUpdates -allowProvisioningDeviceRegistration \
           -archivePath ./Afterparty.xcarchive \
           -exportOptionsPlist ./ExportOptions.plist \
           -exportPath ./AfterpartyProducts | xcpretty