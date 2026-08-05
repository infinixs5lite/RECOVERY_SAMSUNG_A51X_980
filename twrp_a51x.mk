#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 The TWRP Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
DEVICE_PATH := device/samsung/a51x

# Release name
PRODUCT_RELEASE_NAME := a51x

# Inherit from common AOSP config
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common TWRP stuff.
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit device configuration
$(call inherit-product, $(DEVICE_PATH)/device.mk)

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

- PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(DEVICE_PATH)/recovery/root,recovery/root)
+ PRODUCT_COPY_FILES += $(call cc_prebuilt_binary, sgdisk)
+ PRODUCT_COPY_FILES += $(call cc_prebuilt_binary, gdisk)
+ PRODUCT_COPY_FILES += $(call cc_prebuilt_binary, fixparts)
+ PRODUCT_COPY_FILES += $(call cc_prebuilt_binary, lz4.bin)

PRODUCT_DEVICE := a51x
PRODUCT_NAME := twrp_a51x
PRODUCT_BRAND := samsung
PRODUCT_MODEL := SM-A516N
PRODUCT_MANUFACTURER := samsung

PRODUCT_GMS_CLIENTID_BASE := android-samsung-ss

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="a51xks-user 13 TP1A.220624.014 A516NKSU4EVL4 release-keys"

BUILD_FINGERPRINT := samsung/a51xks/a51x:13/TP1A.220624.014/A516NKSU4EVL4:user/release-keys
