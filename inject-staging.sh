#!/bin/bash

appCenterSecret=${1}
appCenterURLScheme=${2}
rootURLHost=${3}
rootURLScheme=${4}
appName=${5}
appBundleID=${6}
foursquareAPIKey=${7}
parseApplicationID=${8}

echo '
MS_APP_CENTER_SECRET = '$appCenterSecret'
MS_APP_CENTER_URL_SCHEME = '$appCenterURLScheme'
ROOT_URL_HOST = '$rootURLHost'
ROOT_URL_SCHEME = '$rootURLScheme'

APP_NAME = '$appName'
APP_BUNDLE_ID = '$appBundleID'
FOURSQUARE_API_KEY = '$foursquareAPIKey'
PARSE_APPLICATION_ID = '$parseApplicationID'
' > ./Afterparty/Config/Environment/Staging.xcconfig
