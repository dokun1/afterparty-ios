#!/bin/sh

set -eo pipefail

IOS_PROJECT_KEYS=${1}

echo "========================================"
echo "Decrypting certs and profiles..."
echo "========================================"

gpg --quiet --batch --yes --decrypt --passphrase="$IOS_PROJECT_KEYS" --output ./.github/secrets/Afterparty_2020_Ad_Hoc_Profile.mobileprovision ./.github/secrets/Afterparty_2020_Ad_Hoc_Profile.mobileprovision.gpg
gpg --quiet --batch --yes --decrypt --passphrase="$IOS_PROJECT_KEYS" --output ./.github/secrets/AfterpartyAdHocDistributionCert.p12 ./.github/secrets/AfterpartyAdHocDistributionCert.p12.gpg

echo "========================================"
echo "Making Provisioning Profiles directory"
echo "========================================"

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles

echo "========================================"
echo "Copying provisioning profile..."
echo "========================================"

cp ./.github/secrets/Afterparty_2020_Ad_Hoc_Profile.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/Afterparty_2020_Ad_Hoc_Profile.mobileprovision

echo "========================================"
echo "Creating keychain..."
echo "========================================"

security create-keychain -p "" build.keychain

echo "========================================"
echo "Importing certs into keychain"
echo "========================================"

security import ./.github/secrets/AfterpartyAdHocDistributionCert.p12 -t agg -k ~/Library/Keychains/build.keychain -P "" -A

security list-keychains -s ~/Library/Keychains/build.keychain
security default-keychain -s ~/Library/Keychains/build.keychain
security unlock-keychain -p "" ~/Library/Keychains/build.keychain

security set-key-partition-list -S apple-tool:,apple: -s -k "" ~/Library/Keychains/build.keychain
