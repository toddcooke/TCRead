#!/bin/bash
# https://github.com/fastlane/fastlane/issues/14201#issuecomment-465233805
set -e

rm -rf fastlane/screenshots

fastlane snapshot --concurrent_simulators false -s FastlaneScreenshotsScheme --devices "iPhone 8 Plus"
fastlane snapshot --concurrent_simulators false -s FastlaneScreenshotsScheme --devices "iPhone 14 Plus"
fastlane snapshot --concurrent_simulators false -s FastlaneScreenshotsScheme --devices "iPad Pro (12.9-inch) (2nd generation)"
fastlane snapshot --concurrent_simulators false -s FastlaneScreenshotsScheme --devices "iPad Pro (12.9-inch) (6th generation)"

echo "open ./fastlane/screenshots to view screenshots"

fastlane deliver
