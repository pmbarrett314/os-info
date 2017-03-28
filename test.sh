#!/bin/sh

. os_info.sh

testOS() {
    if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
    	assertEquals "macos" $(get_os)
    elif [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
    	assertEquals "Linux" $(get_os)
    fi
}

# Needed for zsh
# SHUNIT_PARENT=$0
# setopt shwordsplit

. shunit2/source/2.1/src/shunit2
