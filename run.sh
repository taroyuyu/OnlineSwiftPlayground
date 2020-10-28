#!/bin/bash
SWIFT_VERSION="5.3-RELEASE"
SWIFT="Toolchains/swift-$SWIFT_VERSION.xctoolchain/usr/bin/swift"

. bootstrap.sh

# Generate Xcode projects
if [ $(program_is_installed xcrun) == 1 ]; then
    echo "Generate Xcode project..."
    $SWIFT package generate-xcodeproj
fi

# Run
$(npm bin)/webpack --silent

$SWIFT run -c release --build-path .build/swift-$SWIFT_VERSION &

$(npm bin)/webpack --silent -w

killall -9 PlaygroundServer

