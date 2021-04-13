#!/bin/sh

USAGE='USAGE:\n\tremap_keys.sh [set|reset]'

RESET_KEYMAP='
{"UserKeyMapping":[]}
'

# Key codes are here:
# https://developer.apple.com/library/archive/technotes/tn2450/_index.html
# 0x52 = Up Arrow
# 0xE5 = Right Shift
# 0x51 = Down Arrow
# 0x4F = Right Arrow
SET_KEYMAP='
{"UserKeyMapping":[
    {"HIDKeyboardModifierMappingSrc":0x700000052,"HIDKeyboardModifierMappingDst":0x7000000E5},
    {"HIDKeyboardModifierMappingSrc":0x7000000E5,"HIDKeyboardModifierMappingDst":0x700000052},
    {"HIDKeyboardModifierMappingSrc":0x700000051,"HIDKeyboardModifierMappingDst":0x70000004F},
    {"HIDKeyboardModifierMappingSrc":0x70000004F,"HIDKeyboardModifierMappingDst":0x700000051},
]}'

if [[ "$1" = 'set' ]]; then
    echo "Mapping keys..."
    set -x
    hidutil property --set "$SET_KEYMAP"
    exit $?
elif [[ "$1" = 'reset' ]]; then
    echo "Resetting key maps..."
    set -x
    hidutil property --set "$RESET_KEYMAP"
    exit $?
else
    echo "$USAGE"
fi


