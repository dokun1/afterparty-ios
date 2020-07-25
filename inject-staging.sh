#!/bin/bash

appCenterSecret=${1}
appCenterURLScheme=${2}
rootURLHost=${3}
rootURLScheme=${4}
rootURLPort=${5}
appName=${6}
appBundleID=${7}

echo '
MS_APP_CENTER_SECRET = '$appCenterSecret'
MS_APP_CENTER_URL_SCHEME = '$appCenterURLScheme'
ROOT_URL_HOST = '$rootURLHost'
ROOT_URL_SCHEME = '$rootURLScheme'
ROOT_URL_PORT = '$rootUrlPort'

APP_NAME = '$appName'
APP_BUNDLE_ID = '$appBundleID'
' > ./Afterparty/Config/Environment/Staging.xcconfig