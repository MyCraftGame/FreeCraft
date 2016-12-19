#!/bin/bash -e

# This file sets the appropiate compiler and flags for compiling for iOS without XCode
sdk=iphoneos
osver=8.0

export IOS_COMPILER=$(xcrun --sdk $sdk --find clang)
export IOS_CC=$IOS_COMPILER
export IOS_CXX=$IOS_COMPILER
export IOS_FLAGS="-isysroot $(xcrun --sdk $sdk --show-sdk-path) -arch armv7 -arch arm64 -miphoneos-version-min=$osver -Ofast -fvisibility=hidden"
