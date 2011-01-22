LIBRARY_NAME = LoadLog
LoadLog_INSTALL_PATH = /Library/MobileSubstrate/DynamicLibraries
LoadLog_OBJC_FILES = LoadLog.m
LoadLog_FRAMEWORKS = Foundation

ADDITIONAL_CFLAGS = -std=c99

include framework/makefiles/common.mk
include framework/makefiles/library.mk
