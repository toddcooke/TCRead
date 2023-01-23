#!/bin/bash

# /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app/Contents/MacOS/Simulator -CurrentDeviceUDID <YOUR-DEVICE-ID>

# xcrun simctl install <YOUR-DEVICE-ID> <PATH-TO-APPLICATION-BUNDLE>
# xcrun simctl launch <YOUR-DEVICE-ID> <BUNDLE-ID-OF-APP-BUNDLE>

DEVICE_ID="iPhone 14 Pro"
BUNDLE_PATH="/Users/toddcooke/Library/Developer/Xcode/DerivedData/TCRead-edihamwzczawlsadtxzlmbrzmqjp/Build/Products/Debug-iphonesimulator/TCRead.app"
BUNDLE_ID="com.toddcooke.TCRead"

xcrun simctl install "iPhone 14 Pro" /Users/toddcooke/Library/Developer/Xcode/DerivedData/TCRead-edihamwzczawlsadtxzlmbrzmqjp/Build/Products/Debug-iphonesimulator/TCRead.app
xcrun simctl launch "$DEVICE_ID" $BUNDLE_ID
