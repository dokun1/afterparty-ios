#!/bin/sh

set -eo pipefail

xcodebuild -scheme "Afterparty Prod" \
           -sdk iphoneos \
           -target Afterparty \
           -archivePath ./Afterparty.xcarchive \
           -exportProvisioningProfile "AfterpartyAdHoc.mobileprovision" \
            build archive | xcpretty