#!/bin/sh

. os_info.sh

testOS() {
    if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
    	assertEquals $(get_os) "macos"
    elif [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
    	assertEquals $(get_os) "linux"
    fi
}

# Needed for zsh
# SHUNIT_PARENT=$0
# setopt shwordsplit

. shunit2/source/2.1/src/shunit2
