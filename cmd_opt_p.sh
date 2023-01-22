#!/bin/sh
# https://hybridcattt.com/blog/fixing-swiftui-previews/
osascript -e 'activate application "Xcode"'
osascript -e 'tell application "System Events" to keystroke "p" using {command down, option down}'