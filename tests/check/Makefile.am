include $(top_srcdir)/common/check.mak

CHECK_REGISTRY = $(top_builddir)/tests/check/test-registry.reg
TEST_FILES_DIRECTORY = $(top_srcdir)/tests/files

REGISTRY_ENVIRONMENT = \
	GST_REGISTRY=$(CHECK_REGISTRY)

TESTS_ENVIRONMENT = \
	$(REGISTRY_ENVIRONMENT)					\
	GST_PLUGIN_SYSTEM_PATH=					\
	GST_PLUGIN_PATH=$(top_builddir)/gst:$(top_builddir)/ext:$(top_builddir)/sys:$(GSTPB_PLUGINS_DIR):$(GST_PLUGINS_DIR)			\
	GST_PLUGIN_LOADING_WHITELIST="gstreamer@$(GST_PLUGINS_DIR):gst-plugins-base@$(GSTPB_PLUGINS_DIR):gst-plugins-good@$(top_builddir)"	\
	STATE_IGNORE_ELEMENTS="aasink autoaudiosrc autoaudiosink autovideosrc autovideosink \
		cacasink cairotextoverlay gconfaudiosrc gconfvideosrc gconfaudiosink gconfvideosink \
		halaudiosrc halaudiosink v4l2src osssrc osssink pulsesink pulsesrc pulsemixer \
		osxaudiosink osxaudiosrc osxvideosrc osxvideosink"

# fake device drivers: we could run hardware element tests against dummy drivers
# v4l2: vivo (part of normal kernel)
#   modprobe vivo;
#   gst-launch v4l2src device="/dev/video1" ! xvimagesink;
#   rmmod vivo
#
# alsa: snd-dummy (part of normal alsa, not removable)
#   modprobe snd-dummy;
#   gst-launch alsasrc device="hw:2" ! fakesink
#   gst-launch fakesrc ! alsasink device="hw:2"
#
# need a way to figure out value for the device property

# the core dumps of some machines have PIDs appended
CLEANFILES = core.* test-registry.*

clean-local: clean-local-check clean-local-orc

if USE_ANNODEX
check_annodex = \
	elements/cmmldec \
	elements/cmmlenc
else
check_annodex = 
endif

if USE_FLAC
check_flac = pipelines/flacdec
else
check_flac =
endif

if USE_GDK_PIXBUF
check_gdkpixbuf = elements/gdkpixbufsink
else
check_gdkpixbuf = 
endif

if USE_JPEG
check_jpeg = elements/jpegenc
else
check_jpeg =
endif

if USE_SOUP
check_soup = elements/souphttpsrc
else
check_soup =
endif

if USE_SUNAUDIO
check_sunaudio = elements/sunaudio
else
check_sunaudio = 
endif

if USE_TAGLIB
check_taglib = \
	elements/id3v2mux \
	elements/apev2mux
else
check_taglib =
endif

if USE_WAVPACK
check_wavpack = \
       elements/wavpackparse \
       elements/wavpackdec \
       elements/wavpackenc \
       pipelines/wavpack
else
check_wavpack =
endif

if HAVE_ORC
check_orc = orc/deinterlace orc/videomixer orc/videobox
else
check_orc =
endif


check_PROGRAMS = \
	generic/states \
	$(check_annodex) \
	elements/alphacolor \
	elements/aspectratiocrop \
	elements/audioamplify \
	elements/audiochebband \
	elements/audiocheblimit \
	elements/audiodynamic \
	elements/audioecho \
	elements/audiofirfilter \
	elements/audioiirfilter \
	elements/audioinvert \
	elements/audiopanorama \
	elements/audiowsincband \
	elements/audiowsinclimit \
	elements/avimux \
	elements/avisubtitle \
	elements/capssetter \
	elements/deinterlace \
	elements/deinterleave \
	elements/equalizer \
	elements/flvdemux \
	elements/flvmux \
	elements/icydemux \
	elements/id3demux \
	elements/imagefreeze \
	elements/interleave \
	elements/level \
	elements/matroskamux \
	elements/multifile \
	elements/rganalysis \
	elements/rglimiter \
	elements/rgvolume \
	elements/rtp-payloading \
	elements/rtpbin \
	elements/rtpbin_buffer_list \
	elements/rtpjitterbuffer \
	elements/shapewipe \
	elements/spectrum \
	elements/udpsink \
	elements/videocrop \
	elements/videofilter \
	elements/y4menc \
	pipelines/simple-launch-lines \
	pipelines/effectv \
	$(check_flac) \
	$(check_gdkpixbuf) \
        $(check_jpeg) \
	$(check_soup) \
	$(check_sunaudio) \
	$(check_taglib) \
	$(check_wavpack) \
	$(check_orc)

VALGRIND_TO_FIX = \
	elements/rtp-payloading

TESTS = $(check_PROGRAMS)

# these tests don't even pass
# autodetect: temporarily disabled because of broken videosinks in -bad
noinst_PROGRAMS = \
	elements/autodetect

AM_CFLAGS = $(GST_OBJ_CFLAGS) $(GST_CHECK_CFLAGS) $(CHECK_CFLAGS) \
	$(GST_OPTION_CFLAGS) -DGST_TEST_FILES_PATH="\"$(TEST_FILES_DIRECTORY)\""
LDADD = $(GST_OBJ_LIBS) $(GST_CHECK_LIBS) $(CHECK_LIBS)

# valgrind testing
# videocrop disabled since it takes way too long in valgrind
VALGRIND_TESTS_DISABLE = \
	elements/videocrop \
	$(VALGRIND_TO_FIX)

SUPPRESSIONS = $(top_srcdir)/common/gst.supp $(srcdir)/gst-plugins-good.supp

elements_aspectratiocrop_LDADD = $(LDADD)
elements_aspectratiocrop_CFLAGS = $(GST_PLUGINS_BASE_CFLAGS) $(CFLAGS) $(AM_CFLAGS)

elements_audiopanorama_LDADD = \
	$(GST_BASE_LIBS) $(GST_CONTROLLER_LIBS) \
	$(LDADD)

elements_audiopanorama_CFLAGS = \
	$(GST_BASE_CFLAGS) $(GST_CONTROLLER_CFLAGS) \
	$(CFLAGS) $(AM_CFLAGS)

elements_cmmldec_CFLAGS = $(GST_PLUGINS_BASE_CFLAGS) $(CFLAGS) $(AM_CFLAGS)
elements_cmmlenc_CFLAGS = $(GST_PLUGINS_BASE_CFLAGS) $(CFLAGS) $(AM_CFLAGS)

elements_alphacolor_CFLAGS = $(GST_PLUGINS_BASE_CFLAGS) $(CFLAGS) $(AM_CFLAGS)

elements_deinterlace_CFLAGS = $(GST_PLUGINS_BASE_CFLAGS) $(CFLAGS) $(AM_CFLAGS)
elements_deinterlace_LDADD = $(GST_PLUGINS_BASE_LIBS) -lgstvideo-$(GST_MAJORMINOR) $(LDADD)

elements_deinterleave_CFLAGS = $(GST_PLUGINS_BASE_CFLAGS) $(CFLAGS) $(AM_CFLAGS)
elements_deinterleave_LDADD = $(GST_PLUGINS_BASE_LIBS) -lgstaudio-$(GST_MAJORMINOR) $(LDADD)
elements_interleave_CFLAGS = $(GST_PLUGINS_BASE_CFLAGS) $(CFLAGS) $(AM_CFLAGS)
elements_interleave_LDADD = $(GST_PLUGINS_BASE_LIBS) -lgstaudio-$(GST_MAJORMINOR) $(LDADD)

elements_imagefreeze_CFLAGS = $(GST_PLUGINS_BASE_CFLAGS) $(GST_BASE_CFLAGS) $(AM_CFLAGS)
elements_imagefreeze_LDADD = $(GST_BASE_LIBS) $(LDADD) -lgstvideo-0.10

elements_level_LDADD = $(LDADD) $(LIBM)

elements_matroskamux_LDADD = $(GST_BASE_LIBS) $(LDADD) $(LIBM)

elements_rtpbin_buffer_list_CFLAGS = $(GST_PLUGINS_BASE_CFLAGS) $(GST_CFLAGS) \
	$(WARNING_CFLAGS) $(ERROR_CFLAGS) $(GST_CHECK_CFLAGS)
elements_rtpbin_buffer_list_LDADD = $(GST_PLUGINS_BASE_LIBS) \
             -lgstnetbuffer-@GST_MAJORMINOR@ -lgstrtp-@GST_MAJORMINOR@ \
             $(GST_BASE_LIBS) $(GST_LIBS_LIBS) $(GST_CHECK_LIBS)
elements_rtpbin_buffer_list_SOURCES = elements/rtpbin_buffer_list.c

elements_souphttpsrc_CFLAGS = $(SOUP_CFLAGS) $(AM_CFLAGS)
elements_souphttpsrc_LDADD = $(SOUP_LIBS) $(LDADD)

elements_sunaudio_CFLAGS = \
	$(GST_PLUGINS_BASE_CFLAGS) $(CFLAGS) \
	$(AM_CFLAGS)
elements_sunaudio_LDADD = \
	$(GST_PLUGINS_BASE_LIBS) -lgstinterfaces-@GST_MAJORMINOR@ \
	$(LDADD)

elements_videocrop_LDADD = $(GST_BASE_LIBS) $(LDADD)
elements_videocrop_CFLAGS = $(GST_BASE_CFLAGS) $(CFLAGS) $(AM_CFLAGS)

elements_videofilter_CFLAGS = $(GST_PLUGINS_BASE_CFLAGS) $(CFLAGS) $(AM_CFLAGS)
elements_videofilter_LDADD = $(GST_PLUGINS_BASE_LIBS) -lgstvideo-$(GST_MAJORMINOR) $(LDADD)

# FIXME: configure should check for gdk-pixbuf not gtk
# only need video.h header, not the lib
elements_gdkpixbufsink_CFLAGS = \
	$(GST_PLUGINS_BASE_CFLAGS) $(CFLAGS) $(AM_CFLAGS) $(GDK_PIXBUF_CFLAGS)
elements_gdkpixbufsink_LDADD = \
	$(LDADD) $(GDK_PIXBUF_LIBS)


pipelines_wavpack_LDADD = $(LDADD) $(GST_BASE_LIBS)
pipelines_wavpack_CFLAGS = $(GST_BASE_CFLAGS) $(CFLAGS) $(AM_CFLAGS)

orc_deinterlace_CFLAGS = $(ORC_CFLAGS)
orc_deinterlace_LDADD = $(ORC_LIBS) -lorc-test-0.4
orc_videomixer_CFLAGS = $(ORC_CFLAGS)
orc_videomixer_LDADD = $(ORC_LIBS) -lorc-test-0.4
orc_videobox_CFLAGS = $(ORC_CFLAGS)
orc_videobox_LDADD = $(ORC_LIBS) -lorc-test-0.4

orc/deinterlace.c: $(top_srcdir)/gst/deinterlace/tvtime.orc
	$(MKDIR_P) orc/
	$(ORCC) --test -o $@ $<

orc/videomixer.c: $(top_srcdir)/gst/videomixer/blendorc.orc
	$(MKDIR_P) orc/
	$(ORCC) --test -o $@ $<

orc/videobox.c: $(top_srcdir)/gst/videobox/gstvideoboxorc.orc
	$(MKDIR_P) orc/
	$(ORCC) --test -o $@ $<

clean-local-orc:
	rm -rf orc

EXTRA_DIST = gst-plugins-good.supp
