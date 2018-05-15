ARCHS = arm64
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = CentrifyEmoji
CentrifyEmoji_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
