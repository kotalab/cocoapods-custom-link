#!/bin/bash

set -exo pipefail

PROJECT_ROOT=$(cd $(dirname $0); cd ..; pwd)
PODS_ROOT="$PROJECT_ROOT/Pods"
PODS_PROJECT="$PODS_ROOT/Pods.xcodeproj"
SYMROOT="$PODS_ROOT/Build"

(cd "$PROJECT_ROOT"; rbenv exec bundle exec pod repo update)
(cd "$PROJECT_ROOT"; COCOAPODS_DISABLE_STATS=true rbenv exec bundle exec pod install)

xcodebuild -project "$PODS_PROJECT" \
  -sdk iphoneos -configuration Release -alltargets \
  ONLY_ACTIVE_ARCH=NO ENABLE_TESTABILITY=NO SYMROOT="$SYMROOT" \
  CLANG_ENABLE_MODULE_DEBUGGING=NO \
  BITCODE_GENERATION_MODE=bitcode | rbenv exec bundle exec xcpretty
xcodebuild -project "$PODS_PROJECT" \
  -sdk iphonesimulator -configuration Release -alltargets \
  ONLY_ACTIVE_ARCH=NO ENABLE_TESTABILITY=NO SYMROOT="$SYMROOT" \
  CLANG_ENABLE_MODULE_DEBUGGING=NO | rbenv exec bundle exec xcpretty
xcodebuild -project "$PODS_PROJECT" \
  -sdk iphoneos -configuration Debug -alltargets \
  ONLY_ACTIVE_ARCH=NO ENABLE_TESTABILITY=NO SYMROOT="$SYMROOT" \
  CLANG_ENABLE_MODULE_DEBUGGING=NO \
  BITCODE_GENERATION_MODE=bitcode | rbenv exec bundle exec xcpretty
xcodebuild -project "$PODS_PROJECT" \
  -sdk iphonesimulator -configuration Debug -alltargets \
  ONLY_ACTIVE_ARCH=NO ENABLE_TESTABILITY=NO SYMROOT="$SYMROOT" \
  CLANG_ENABLE_MODULE_DEBUGGING=NO | rbenv exec bundle exec xcpretty