#!/bin/sh

testEquality() {
    assertEquals 1 1
}

# Needed for zsh
# SHUNIT_PARENT=$0
# setopt shwordsplit

. shunit2/source/2.1/src/shunit2
