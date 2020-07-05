#!/bin/sh

set -eo pipefail

xcodebuild -exportArchive \ 
           -exportProvisioningProfile "AfterpartyAdHoc.mobileprovision" \
           -archivePath ./Afterparty.xcarchive \
           -exportOptionsPlist ./ExportOptions.plist \
           -exportPath ./AfterpartyProducts | xcpretty