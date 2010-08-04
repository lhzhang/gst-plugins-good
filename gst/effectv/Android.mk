LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES :=				\
	gsteffectv.c				\
	gstedge.c				\
	gstaging.c				\
	gstdice.c				\
	gstwarp.c				\
	gstshagadelic.c				\
	gstvertigo.c				\
	gstrev.c				\
	gstquark.c				\
	gstop.c					\
	gstradioac.c				\
	gststreak.c				\
	gstripple.c

LOCAL_MODULE := libgsteffectv$(GST_PLUGINS_SUFFIX)

LOCAL_C_INCLUDES :=				\
	$(GST_PLUGINS_BASE_LIBS_C_INCLUDES)	\
	$(GST_PLUGINS_GOOD_TOP)/android-internal

LOCAL_CFLAGS :=					\
	-DHAVE_CONFIG_H

ifeq ($(GST_BUILD_STATIC),true)
GST_PLUGINS_STATIC_LIBRARIES +=			\
	$(LOCAL_MODULE)				\
	libgst-plugins-base-libs-$(GST_MAJORMINOR)

LOCAL_CFLAGS +=					\
	-DSTATIC_PLUGIN_NAME=$(LOCAL_MODULE)

include $(BUILD_STATIC_LIBRARY)
else
LOCAL_SHARED_LIBRARIES :=			\
	$(GLIB_SHARED_LIBRARIES)		\
	$(GST_SHARED_LIBRARIES)			\
	$(GST_BASE_SHARED_LIBRARIES)		\
	libgst-plugins-base-libs-$(GST_MAJORMINOR)

include $(BUILD_SHARED_LIBRARY)
endif
