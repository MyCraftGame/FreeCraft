#!/bin/bash -e

echo
echo "Starting build FreeCraft for iOS..."

echo
echo "Build Libraries:"

./libraries.sh

echo
echo "Creating Assets:"

./assets.sh

echo
echo "Creating App Icon:"

./appicon.sh

echo
echo "Install CocoaPods:"

pod install

echo
echo "All done! You can continue in Xcode!"
