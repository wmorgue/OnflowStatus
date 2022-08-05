#!/usr/bin/env zsh

#  swift_format.zsh
#  Onflow status
#
#  Created by Nikita Rossik on 8/5/22.
#  

ONFLOW_DIR=`pwd`

if which swiftformat >/dev/null; then
  swiftformat $ONFLOW_DIR . --config $ONFLOW_DIR/.swiftformat.conf
else
  echo "warning: SwiftFormat not installed, download from https://github.com/nicklockwood/SwiftFormat"
  echo "note: brew install swiftformat"
fi
