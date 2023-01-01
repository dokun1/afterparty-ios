#!/bin/sh

set -eo pipefail

IOS_PROJECT_KEYS=${1}

echo "========================================"
echo "Decrypting certs and profiles..."

gpg --quiet --batch --yes --decrypt --passphrase="$IOS_PROJECT_KEYS" --output ./.github/secrets/AfterpartyAdHoc.mobileprovision ./.github/secrets/AfterpartyAdHoc.mobileprovision.gpg
gpg --quiet --batch --yes --decrypt --passphrase="$IOS_PROJECT_KEYS" --output ./.github/secrets/AfterpartyAdHocStaging.mobileprovision ./.github/secrets/AfterpartyAdHocStaging.mobileprovision.gpg
gpg --quiet --batch --yes --decrypt --passphrase="$IOS_PROJECT_KEYS" --output ./.github/secrets/AfterpartyDev.mobileprovision ./.github/secrets/AfterpartyDev.mobileprovision.gpg
gpg --quiet --batch --yes --decrypt --passphrase="$IOS_PROJECT_KEYS" --output ./.github/secrets/AfterpartyAppStore.mobileprovision ./.github/secrets/AfterpartyAppStore.mobileprovision.gpg
gpg --quiet --batch --yes --decrypt --passphrase="$IOS_PROJECT_KEYS" --output ./.github/secrets/Certificates.p12 ./.github/secrets/Certificates.p12.gpg

echo "========================================"
echo "Making Provisioning Profiles directory..."

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles

echo "========================================"
echo "Copying provisioning profile..."

cp ./.github/secrets/AfterpartyAdHoc.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/AfterpartyAdHoc.mobileprovision
cp ./.github/secrets/AfterpartyAdHocStaging.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/AfterpartyAdHocStaging.mobileprovision
cp ./.github/secrets/AfterpartyDev.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/AfterpartyDev.mobileprovision
cp ./.github/secrets/AfterpartyAppStore.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/AfterpartyAppStore.mobileprovision

echo "========================================"
echo "Creating keychain..."

security create-keychain -p "" build.keychain

echo "========================================"
echo "Importing certs into keychain..."

security import ./.github/secrets/Certificates.p12 -t agg -k ~/Library/Keychains/build.keychain -P $IOS_PROJECT_KEYS -A

echo "========================================"
echo "Unlocking main keychain..."

security list-keychains -s ~/Library/Keychains/build.keychain
security default-keychain -s ~/Library/Keychains/build.keychain
security unlock-keychain -p "" ~/Library/Keychains/build.keychain

echo "========================================"
echo "Setting key partition..."

security set-key-partition-list -S apple-tool:,apple: -s -k "" ~/Library/Keychains/build.keychain

echo "========================================"
echo "Available Certificates:"

security find-identity -p codesigning -v

echo "========================================"
echo "Available Provisioning Profiles:"

ls ~/Library/MobileDevice/Provisioning\ Profiles/