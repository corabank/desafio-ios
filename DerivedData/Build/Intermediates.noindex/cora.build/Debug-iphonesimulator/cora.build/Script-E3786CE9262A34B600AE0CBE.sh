#!/bin/sh
# Type a script or drag a script file from your workspace to insert its path.
if which "${PODS_ROOT}/SwiftLint/swiftlint" >/dev/null; then
    ${PODS_ROOT}/SwiftLint/swiftlint
else
    echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi


