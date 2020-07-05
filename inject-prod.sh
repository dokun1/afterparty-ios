#!/bin/bash

appCenterSecret=${1}
appCenterURLScheme=${2}
rootURL=${3}
appName=${4}
appBundleID=${5}

echo '
MS_APP_CENTER_SECRET = '$appCenterSecret'
MS_APP_CENTER_URL_SCHEME = '$appCenterURLScheme'
ROOT_URL = '$rootURL'

APP_NAME = '$appName'
APP_BUNDLE_ID = '$appBundleID'
' > ./Afterparty/Config/Environment/Prod.xcconfig