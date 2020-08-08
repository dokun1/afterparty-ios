#!/bin/sh

set -eo pipefail

sudo xcode-select -switch /Applications/Xcode_11.6.app

xcodebuild -project Afterparty.xcodeproj \
	   -scheme "Afterparty Staging Tests" \
           -sdk iphonesimulator \
           -destination 'platform=iOS Simulator,name=iPhone 11 Pro Max,OS=latest' \
            test
