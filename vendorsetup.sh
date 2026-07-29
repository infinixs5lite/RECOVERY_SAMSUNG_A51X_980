#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#set -o xtrace
FDEVICE="a51x"
THIS_DEVICE=${BASH_ARGV[2]}

fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep -w \"$FDEVICE\")
   if [ -n "$chkdev" ]; then
      FOX_BUILD_DEVICE="$FDEVICE"
   else
      chkdev=$(set | grep BASH_ARGV | grep -w \"$FDEVICE\")
      [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
   fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
	fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
	if [ -z "$THIS_DEVICE" ]; then
		echo "ERROR! This script requires bash. Run '/bin/bash' and build again."
		exit 1
	fi

	export TW_DEFAULT_LANGUAGE="en"
	export LC_ALL="C"
	export ALLOW_MISSING_DEPENDENCIES=true
	export FOX_VANILLA_BUILD=1
	export FOX_NO_SAMSUNG_SPECIAL=1
	export FOX_ENABLE_APP_MANAGER=1
	export FOX_USE_BASH_SHELL=1
	export FOX_ASH_IS_BASH=1
	export FOX_USE_TAR_BINARY=1
	export FOX_USE_XZ_UTILS=1
	export FOX_USE_LZ4_BINARY=1
	export FOX_USE_ZSTD_BINARY=1
	export FOX_DELETE_AROMAFM=1
	export FOX_DELETE_INITD_ADDON=1	
	export FOX_USE_DATE_BINARY=1
	export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
	export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"
	export FOX_USE_SPECIFIC_MAGISK_ZIP=~/Magisk/Magisk-v30.7.zip

	export FOX_USE_BUSYBOX_BINARY=1

	# enable AVB settings
	export FOX_ENABLE_AVB=1

	# no decryption - where to store settings? Try microSD
	USE_MICRO_SD_FOR_SETTINGS=1;
	if [ "$USE_MICRO_SD_FOR_SETTINGS" = "1" ]; then
		export FOX_SETTINGS_ROOT_DIRECTORY="/sdcard1/recovery"
		export FOX_MISCELLANEOUS_ROOT_DIRECTORY=$FOX_SETTINGS_ROOT_DIRECTORY
	fi
else
	if [ -z "$FOX_BUILD_DEVICE" -a -z "$BASH_SOURCE" ]; then
		echo "I: This script requires bash. Not processing the $FDEVICE $(basename $0)"
	fi
fi
#
