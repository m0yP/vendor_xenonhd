# OTA default build type
ifeq ($(OTA_TYPE),)
OTA_TYPE=Unofficial
endif

# XenonHD version
XENONHD_VERSION := XenonHD-$(shell date +"%y%m%d")-$(OTA_TYPE)
DEVICE := $(subst xenonhd_,,$(TARGET_PRODUCT))

ifeq ($(XENONHD_DONATE),)
    XENONHD_DONATE=http://goo.gl/3z5jHW
endif

# XenonHD OTA app
PRODUCT_PACKAGES += \
    XenonOTA

# Proprietary libs
ifneq ($(filter arm64,$(TARGET_ARCH)),)
PRODUCT_COPY_FILES += \
    vendor/xenonhd/prebuilt/common/lib/libbypass.so:system/lib/libbypass.so
else
PRODUCT_COPY_FILES += \
    vendor/xenonhd/prebuilt/common/lib64/libbypass.so:system/lib64/libbypass.so
endif

# Build.prop overrides
PRODUCT_PROPERTY_OVERRIDES += \
    ro.xenonhd.version=$(XENONHD_VERSION) \
    ro.xenonhd.donate=$(XENONHD_DONATE) \
    ro.ota.systemname=XenonHD-$(OTA_TYPE) \
    ro.ota.device=$(DEVICE) \
    ro.ota.version=$(shell date +"%y%m%d") \
    ro.ota.manifest=https://mirrors.c0urier.net/android/teamhorizon/N/OTA/ota_nougat_$(DEVICE).xml
