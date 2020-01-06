#!/usr/bin/env bash

# Map Caps Lock key to Left Control key
# https://developer.apple.com/library/content/technotes/tn2450/_index.html
# This doesnt work. Reverts on restart
# hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x7000000E0}]}'
# References:
# https://github.com/mathiasbynens/dotfiles/issues/310
# https://gist.github.com/scottstanfield/0f8ce63271bebfb5cf2bb91e72c71f91
# The last link didnt work for me on Sierra or High Sierra. I could not find IOHIDKeyboard but
# IOHIDInterface had the values I was looking for

VENDOR_ID=$(ioreg -n IOHIDInterface -r | awk '$2 == "\"VendorID\"" { print $4 }')
PRODUCT_ID=$(ioreg -n IOHIDInterface -r | awk '$2 == "\"ProductID\"" { print $4 }')

n1=$(echo -n "$VENDOR_ID" | grep -c "^")
n2=$(echo -n "$PRODUCT_ID" | grep -c "^")

if [ $n1 -eq $n2 ]; then
	KBS=""
	# Handling multiple VendorID and ProductID combos
	while read -r VID && read -r PID <&3; do
		if [ -n "$KBS" ]; then
			KBS+=" "
		fi
		KBS+="$VID-$PID-0"
		done <<< "$VENDOR_ID" 3<<< "$PRODUCT_ID"

		KBS=$(echo $KBS | xargs -n1 | sort -u)
		while read -r KB; do
			defaults -currentHost write -g com.apple.keyboard.modifiermapping.$KB -array \
'<dict>
<key>HIDKeyboardModifierMappingDst</key>
<integer>30064771296</integer>
<key>HIDKeyboardModifierMappingSrc</key>
<integer>30064771129</integer>
</dict>'
		done <<< "$KBS"
fi
