ifndef QCONFIG
QCONFIG=qconfig.mk
endif
include $(QCONFIG)

NAME=GLOG
GLOG_INSTALL_ROOT ?= $(INSTALL_ROOT_$(OS))
GLOG_VERSION = .0.6

#choose Release or Debug
CMAKE_BUILD_TYPE ?= Debug


#override 'all' target to bypass the default QNX build system
ALL_DEPENDENCIES = GLOG_all
.PHONY: GLOG_all install check clean

CFLAGS += $(FLAGS)

include $(MKFILES_ROOT)/qtargets.mk

GLOG_ROOT = $(PROJECT_ROOT)/../../

# Add the line below
CMAKE_ARGS = -DCMAKE_TOOLCHAIN_FILE=$(PROJECT_ROOT)/qnx.nto.toolchain.cmake \
             -DCMAKE_SYSTEM_PROCESSOR=$(CPUVARDIR) \
             -DCMAKE_INSTALL_PREFIX=$(GLOG_INSTALL_ROOT) \
             -DCMAKE_INSTALL_INCLUDEDIR=usr/include \
             -DCMAKE_INSTALL_LIBDIR=$(CPUVARDIR)/usr/lib \
             -DCMAKE_INSTALL_BINDIR=$(CPUVARDIR)/usr/bin \
             -Dgflags_DIR=$(GLOG_INSTALL_ROOT)/$(CPUVARDIR)/usr/lib/cmake/gflags \
             -DGTest_DIR=$(GLOG_INSTALL_ROOT)/$(CPUVARDIR)/usr/lib/cmake/GTest \
             -DCMAKE_BUILD_TYPE=$(CMAKE_BUILD_TYPE) \
             -DEXTRA_CMAKE_C_FLAGS="$(CFLAGS)" \
             -DEXTRA_CMAKE_CXX_FLAGS="$(CFLAGS)" \
             -DEXTRA_CMAKE_ASM_FLAGS="$(FLAGS)" \
             -DEXTRA_CMAKE_LINKER_FLAGS="$(LDFLAGS)" \
             -DCMAKE_PREFIX_PATH=$(GLOG_INSTALL_ROOT) \
             -DCPU=$(CPU)

MAKE_ARGS ?= -j $(firstword $(JLEVEL) 1)

ifndef NO_TARGET_OVERRIDE
GLOG_all:
	@mkdir -p build
	@cd build && cmake $(CMAKE_ARGS) $(GLOG_ROOT)
	@cd build && make VERBOSE=1 all $(MAKE_ARGS)

install check: GLOG_all
	@cd build && make VERBOSE=1 install $(MAKE_ARGS)

clean iclean spotless:
	@rm -rf build
endif
