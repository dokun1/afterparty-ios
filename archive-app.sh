#!/bin/sh

set -eo pipefail

xcodebuild -scheme "Afterparty Prod" \
           -sdk iphoneos \
           -target Afterparty \
           -archivePath ./Afterparty.xcarchive \
           -allowProvisioningUpdates -allowProvisioningDeviceRegistration \
            build archive | xcpretty