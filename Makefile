#!/usr/bin/env make -f

# reactive-firewall/XCMBuild Repo Makefile
# ..................................
# Copyright (c) 2014-2023, Mr. Walls
# ..................................
# Licensed under APACHE-2 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# ..........................................
# http://www.apache.org/licenses/LICENSE-2.0
# ..........................................
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


# Some of the following code was inspired from CC BY-SA (v3) content
# namely regarding the auto-percentage via ECHO overloading of this Makefile
# see https://stackoverflow.com/help/licensing for details
#
# This Modified Code is under dual-licenses APACHE-2 and CC BY-SA 3.0
# with regard to the code from https://stackoverflow.com/a/35320895
#
# CC BY-SA3.0 Attribution:
# THANKS to the user https://stackoverflow.com/users/999943/phyatt
# For the solid answer to https://stackoverflow.com/a/35320895

ifeq "$(LC_CTYPE)" ""
	LC_CTYPE="en_US.UTF-8"
endif

# start of CC-SA-v3 inpired content below
ifneq ($(words $(MAKECMDGOALS)),1) # if no argument was given to make...
.DEFAULT_GOAL = all # set the default goal to all

ifeq "$(ECHO)" ""
	ECHO=command -p echo -e
endif

%:		# define a last resort default rule
	@$(MAKE) $@ --no-print-directory -rRf $(firstword $(MAKEFILE_LIST)) # recursive make call,

else
# start of modification to above CC-SA-v3 inpired content starts below
# exception to CC-SA-v3 inpired content below
ifndef SHELL
	SHELL:=command -pv bash
endif
# exception to CC-SA-v3 inpired content above
# exception to CC-SA-v3 inpired content below
ifeq "$(COMMAND)" ""
	COMMAND_CMD!=`command -v xcrun || command which which || command -v which || command -v command`
	ifeq "$(COMMAND_CMD)" "*xcrun"
		COMMAND_ARGS=--find
	endif
	ifeq "$(COMMAND_CMD)" "*command"
		COMMAND_ARGS=-pv
	endif
	COMMAND=$(COMMAND_CMD) $(COMMAND_ARGS)
endif
# exception to CC-SA-v3 inpired content above
# exception to CC-SA-v3 inpired content below
ifeq "$(MAKE)" ""
	#  just no cmake please
	MAKEFLAGS=$(MAKEFLAGS) -s
	MAKE!=`$(COMMAND) make || $(COMMAND) gnumake`
endif
# exception to CC-SA-v3 inpired content above
# end of modification to above CC-SA-v3 inpired content ends above
# start of CC-SA-v3 inpired content below (resumed)
ifndef ECHO
LOG=no
T := $(shell $(MAKE) $(MAKECMDGOALS) --no-print-directory \
	-nrRf $(firstword $(MAKEFILE_LIST)) \
	ECHO="COUNTTHIS" | grep -cF "COUNTTHIS" 2>/dev/null)
N := x
C = $(words $N)$(eval N := x $N)
ECHO = $(COMMAND) echo -e "\r [`expr $C '*' 100 / $T`%]"
endif
# end of CC-SA-v3 inpired content above

ifeq "$(CONFIGURATION)" ""
	CONFIGURATION="Default"
endif

ifndef SET_FILE_ATTR
	SET_FILE_ATTR=$(COMMAND) xattr
endif

ifeq "$(NOOP)" ""
	NOOP=`:`
endif

ifndef PROJECT_ROOT
	PROJECT_ROOT=$(dir $(abspath $(firstword $(MAKEFILE_LIST))))
endif

ifndef BUILD_ROOT
	BUILD_ROOT=$(abspath $(abspath $(PROJECT_ROOT)/build))
endif

ifndef SYMROOT
	SYMROOT=$(abspath $(abspath $(BUILD_ROOT)/$(CONFIGURATION)))
endif

ifndef DSTROOT
	DSTROOT=$(abspath $(abspath $(PROJECT_ROOT)/dist))
endif

ifneq "$(SET_FILE_ATTR)" ""
	CREATEDBYBUILDSYSTEM=-sw com.apple.xcode.CreatedByBuildSystem true
	BSMARK=$(SET_FILE_ATTR) $(CREATEDBYBUILDSYSTEM)
else
	BSMARK=$(COMMAND) touch -a
endif

ifneq "$(SET_FILE_ATTR)" ""
	CLEARBYBUILDSYSTEM=-c
	UNMARK=$(SET_FILE_ATTR) $(CLEARBYBUILDSYSTEM)
else
	UNMARK=$(COMMAND) touch -a
endif

#-d com.apple.xcode.CreatedByBuildSystem -d com.apple.ResourceFork -d com.apple.FinderInfo

ifeq "$(RMDIR)" ""
	RMDIR=$(COMMAND) bin/prunefile
endif

include shared/includes/preamble.make
include shared/includes/version.make

#TMPDIR!=`$(getconf DARWIN_USER_TEMP_DIR)`

ifeq "$(TMPDIR)" ""
	TMPDIR=/var/tmp
endif

ifeq "$(LOCAL_LIBRARY_DIR)" ""
	LOCAL_LIBRARY_DIR=Library
endif

ifeq "$(INSTALL_PATH)" ""
	INSTALL_PATH=Library
endif

ifeq "$(DYLIB_INSTALL_NAME_BASE)" ""
	DYLIB_INSTALL_NAME_BASE=$(INSTALL_PATH)/Frameworks
endif

ifeq "$(PROJECT_TEMP_ROOT)" ""
	PROJECT_TEMP_ROOT=$(abspath $(TMPDIR))
endif

ifeq "$(TARGET_TEMP_DIR)" ""
	TARGET_TEMP_DIR=$(abspath $(abspath $(PROJECT_TEMP_ROOT))/Cache/XCMBuild.tmp)
endif

ifndef UNINSTALLED_PRODUCTS_DIR
	UNINSTALLED_PRODUCTS_DIR=$(abspath $(abspath $(TARGET_TEMP_DIR))/UninstalledProducts)
endif

ifndef OBJECT_FILE_DIR
	OBJECT_DIR=obj
	OBJECT_FILE_DIR=$(TARGET_TEMP_DIR)/$(OBJECT_DIR)
endif

include shared/includes/compilerflags.make

ifeq "$(LOG)" "no"
	QUIET=@
	ifeq "$(DO_FAIL)" ""
		DO_FAIL=$(QUIET)$(NOOP)
	endif
else
	ifeq "$(DO_FAIL)" ""
		# any other log mode MAY CAUSE ISSUES with progress logic b/c extra echo in loop
		DO_FAIL=@$(PRINT) "%s\n" "Successful"
	endif
endif

.SUFFIXES: .zip .php .css .html .bash .sh .py .pyc .txt .js .plist .icns .lproj .dmg .LinkFileList .o .dylib .c .h .m .framework

.PHONY: all clean init init-start must_be_root bootstrap cleanup cleanup_DS_Store cleanup_temps cleanup_tmp_obj checkin install uninstall test

all:: init build XCMBuild-framework bootstrap xcrunshell-cli XCMTest-cli XCMClean-cli install test
	$(QUITE)$(DO_FAIL) ;
	$(QUIET)$(ECHO) "$@: Done."

bootstrap:: |build install-XCMBuild-fmwk init
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: Done."

checkin: |init
	$(QUIET)$(WAIT) ;
	$(QUIET)$(SYNC) ;
	$(DO_FAIL) ;

build: $(BUILD_ROOT)/$(CONFIGURATION) $(TARGET_TEMP_DIR) $(UNINSTALLED_PRODUCTS_DIR) |init
	$(QUIET)$(ECHO) "Building..." ;
	$(QUITE)$(DO_FAIL) ;

$(BUILD_ROOT): $(PROJECT_ROOT) |init
	$(QUIET)$(ECHO) "Create Build Directory: $@" ;
	$(QUIET)$(MKDIR) $(BUILD_ROOT) || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $(BUILD_ROOT) || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $(BUILD_ROOT) || DO_FAIL="exit 2" ;
	$(QUITE)$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Build Directory Ready" ;

$(BUILD_ROOT)/$(CONFIGURATION): |$(BUILD_ROOT)
	$(QUIET)$(ECHO) "Configuring for $(CONFIGURATION) ..." ;
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(QUITE)$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Using configuration: $(CONFIGURATION)" ;

$(UNINSTALLED_PRODUCTS_DIR): $(TARGET_TEMP_DIR) |init
	$(QUIET)$(ECHO) "Create Target Products Staging Directory: $@" ;
	$(QUIET)$(MKDIR) $(UNINSTALLED_PRODUCTS_DIR) || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $(UNINSTALLED_PRODUCTS_DIR) || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $(UNINSTALLED_PRODUCTS_DIR) || DO_FAIL="exit 2" ;
	$(QUIET)$(WAIT) ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR): |init-start
	$(QUIET)$(ECHO) "Create Target Cache Directory: $@" ;
	$(QUIET)$(MKDIR) $(TARGET_TEMP_DIR) || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $(TARGET_TEMP_DIR) || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $(TARGET_TEMP_DIR) || DO_FAIL="exit 2" ;
	$(QUIET)$(WAIT) ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Target Cache Ready" ;

init-start::
	$(QUIET)$(ECHO) "Starting fresh." ;

init: |init-start init-tmp-dirs init-tool-dirs
	$(QUIET)$(ECHO) "$(SDKROOT)" || DO_FAIL="exit 2" ;
	$(QUIET)$(ECHO) "$(SET_FILE_ATTR)" || DO_FAIL="exit 2" ;
	$(QUIET)$(ECHO) "$(UNMARK)" || DO_FAIL="exit 2" ;
	$(QUIET)$(ECHO) "$@: Done."

init-tmp-dirs-Release: $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/Binary $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/Binary $(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/Binary $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64 $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64 $(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64 $(TARGET_TEMP_DIR)/build/Object-x86_64-normal $(TARGET_TEMP_DIR)/build/Object-arm64-normal $(TARGET_TEMP_DIR)/build/Object-arch64-normal $(TARGET_TEMP_DIR)/build $(TARGET_TEMP_DIR) |init-start
	$(DO_FAIL) ;

init-tmp-dirs-Debug: $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/Binary $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/Binary $(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/Binary |init-start
	$(DO_FAIL) ;

init-tmp-dirs-Profile: $(TARGET_TEMP_DIR)/build/Object-x86_64-profile/x86_64/Binary $(TARGET_TEMP_DIR)/build/Object-arm64-profile/arm64/Binary $(TARGET_TEMP_DIR)/build/Object-arch64-profile/arch64/Binary |init-start
	$(DO_FAIL) ;

init-tmp-dirs: init-tmp-dirs-Release init-tmp-dirs-Debug init-tmp-dirs-Profile |init-start
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Target Products Staging Cache Ready" ;

init-tool-dirs: $(TARGET_TEMP_DIR)/build/bin init-lib-shlock init-tool-snooze init-tool-prunefile init-tool-clonefile init-tool-setIcon init-tool-fxip |init-start
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Meta Toolchain Cache Ready" ;

init-lib-serialize: $(TARGET_TEMP_DIR)/build/bin/serialized |$(TARGET_TEMP_DIR)/build/bin
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Added serialize to Cache." ;

init-lib-shlock: $(TARGET_TEMP_DIR)/build/bin/tool_shlock_helper.bash |$(TARGET_TEMP_DIR)/build/bin
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Added shlock helper to Cache." ;

init-lib-flatten: $(TARGET_TEMP_DIR)/build/bin/flatten |$(TARGET_TEMP_DIR)/build/bin
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Added flatten to Cache." ;

init-tool-snooze: $(TARGET_TEMP_DIR)/build/bin/snooze |$(TARGET_TEMP_DIR)/build/bin
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Added snooze to Cache." ;

init-tool-fxip: $(TARGET_TEMP_DIR)/build/bin/fxip |$(TARGET_TEMP_DIR)/build/bin
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Added fixup tool to Cache." ;

init-tool-setIcon: $(TARGET_TEMP_DIR)/build/bin/setIcon |$(TARGET_TEMP_DIR)/build/bin
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Added setIcon tool to Cache." ;

init-tool-prunefile: $(TARGET_TEMP_DIR)/build/bin/prunefile |init-lib-flatten
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Added prunefile to Cache." ;

init-tool-clonefile: $(TARGET_TEMP_DIR)/build/bin/xcode_clonefile.bash $(TARGET_TEMP_DIR)/build/bin/clonefile |init-lib-serialize
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Added clonefile to Cache." ;

install:: |build bootstrap init
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: Done."

init-env: must_be_root XCMBuild_environment |init-start
	$(QUIET)$(WAIT)
	$(QUIET)source XCMBuild_environment ;
	$(QUIET)$(ECHO) "$@: Done."

$(DSTROOT)/$(DYLIB_INSTALL_NAME_BASE): $(DSTROOT)/$(INSTALL_PATH) |$(DSTROOT)
	$(QUIET)$(ECHO) "Creating $@" ;
	$(QUIET)$(MKDIR) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(WAIT) ;
	$(DO_FAIL) ;

$(DSTROOT)/$(INSTALL_PATH): |$(DSTROOT)
	$(QUIET)$(ECHO) "Creating $@" ;
	$(QUIET)$(MKDIR) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(WAIT) ;
	$(DO_FAIL) ;

$(DSTROOT):
	$(QUIET)$(ECHO) "Creating $@" ;
	$(QUIET)$(MKDIR) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(WAIT) ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build: $(TARGET_TEMP_DIR) |init-start
	$(QUIET)$(MKDIR) $(TARGET_TEMP_DIR)/build || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $(TARGET_TEMP_DIR)/build || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $(TARGET_TEMP_DIR)/build || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Target Build Cache Directory Ready" ;

$(TARGET_TEMP_DIR)/build/bin: $(TARGET_TEMP_DIR)/build |init-start
	$(QUIET)$(MKDIR) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(WAIT) ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/bin/%: bin/% |$(TARGET_TEMP_DIR)/build/bin
	$(QUIET)$(CP) "$<" "$@" 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(WAIT) ;
	$(DO_FAIL) ;

# Normal

$(TARGET_TEMP_DIR)/build/Object-x86_64-normal: $(TARGET_TEMP_DIR)/build
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Object Directory Ready ($@)" ;

$(TARGET_TEMP_DIR)/build/Object-arm64-normal: $(TARGET_TEMP_DIR)/build
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Object Directory Ready ($@)" ;

$(TARGET_TEMP_DIR)/build/Object-arch64-normal: $(TARGET_TEMP_DIR)/build
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Object Directory Ready ($@)" ;

$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64: $(TARGET_TEMP_DIR)/build/Object-x86_64-normal |$(TARGET_TEMP_DIR)/build
	$(QUIET)$(ECHO) "Create Object Sub-Directory: $@" ;
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Object Sub-Directory Ready" ;

$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64: $(TARGET_TEMP_DIR)/build/Object-arm64-normal |$(TARGET_TEMP_DIR)/build
	$(QUIET)$(ECHO) "Create Object Sub-Directory: $@" ;
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Object Sub-Directory Ready (arm64)" ;

$(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64: $(TARGET_TEMP_DIR)/build/Object-arch64-normal |$(TARGET_TEMP_DIR)/build
	$(QUIET)$(ECHO) "Create Object Sub-Directory: $@" ;
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Object Sub-Directory Ready (arch64)" ;

$(TARGET_TEMP_DIR)/build/Object-%-normal/%: $(TARGET_TEMP_DIR)/build/Object-%-normal |$(TARGET_TEMP_DIR)/build
	$(QUIET)$(ECHO) "Create Object Sub-Directory: $@" ;
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Object Sub-Directory Ready" ;

$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/Binary: $(TARGET_TEMP_DIR)/build/Object-x86_64-normal $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64 |$(TARGET_TEMP_DIR)/build
	$(QUIET)$(ECHO) "Create Binary Directory: $@" ;
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Binary Directory Ready" ;

$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/Binary: $(TARGET_TEMP_DIR)/build/Object-arm64-normal $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64 |$(TARGET_TEMP_DIR)/build
	$(QUIET)$(ECHO) "Create Binary Directory: $@" ;
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Binary Directory Ready (arm64)" ;

$(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/Binary: $(TARGET_TEMP_DIR)/build/Object-arch64-normal $(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64 |$(TARGET_TEMP_DIR)/build
	$(QUIET)$(ECHO) "Create Binary Directory: $@" ;
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Binary Directory Ready (arch64)" ;

$(TARGET_TEMP_DIR)/build/Object-%-normal/%/Binary: $(TARGET_TEMP_DIR)/build/Object-%-normal $(TARGET_TEMP_DIR)/build/Object-%-normal/% |$(TARGET_TEMP_DIR)/build
	$(QUIET)$(ECHO) "Create Binary Directory: $@" ;
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Binary Directory Ready" ;

# Debug

$(TARGET_TEMP_DIR)/build/Object-x86_64-debug: $(TARGET_TEMP_DIR)/build
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Object Directory Ready (debug)" ;

$(TARGET_TEMP_DIR)/build/Object-arm64-debug: $(TARGET_TEMP_DIR)/build
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Object Directory Ready (arm64 debug)" ;

$(TARGET_TEMP_DIR)/build/Object-arch64-debug: $(TARGET_TEMP_DIR)/build
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Object Directory Ready (arch64 debug)" ;

$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64: $(TARGET_TEMP_DIR)/build/Object-x86_64-debug |$(TARGET_TEMP_DIR)/build
	$(QUIET)$(ECHO) "Create Object Directory: $@" ;
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Object Sub-Directory Ready (debug)" ;

$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64: $(TARGET_TEMP_DIR)/build/Object-arm64-debug |$(TARGET_TEMP_DIR)/build
	$(QUIET)$(ECHO) "Create Object Directory: $@" ;
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Object Sub-Directory Ready (arm64 debug)" ;

$(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64: $(TARGET_TEMP_DIR)/build/Object-arch64-debug |$(TARGET_TEMP_DIR)/build
	$(QUIET)$(ECHO) "Create Object Directory: $@" ;
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Object Sub-Directory Ready (arch64 debug)" ;

$(TARGET_TEMP_DIR)/build/Object-%-debug/%: $(TARGET_TEMP_DIR)/build/Object-%-debug |$(TARGET_TEMP_DIR)/build
	$(QUIET)$(ECHO) "Create Object Directory: $@" ;
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Object Sub-Directory Ready ($@)" ;

$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/Binary: $(TARGET_TEMP_DIR)/build/Object-x86_64-debug $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64 |$(TARGET_TEMP_DIR)/build
	$(QUIET)$(ECHO) "Create Binary Directory: $@ (debug)" ;
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Binary Directory Ready (debug)" ;

$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/Binary: $(TARGET_TEMP_DIR)/build/Object-arm64-debug $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64 |$(TARGET_TEMP_DIR)/build
	$(QUIET)$(ECHO) "Create Binary Directory: $@ (arm64 debug)" ;
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Binary Directory Ready (arm64 debug)" ;

$(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/Binary: $(TARGET_TEMP_DIR)/build/Object-arch64-debug $(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64 |$(TARGET_TEMP_DIR)/build
	$(QUIET)$(ECHO) "Create Binary Directory: $@ (arch64 debug)" ;
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Binary Directory Ready (arch64 debug)" ;

$(TARGET_TEMP_DIR)/build/Object-%-debug/%/Binary: $(TARGET_TEMP_DIR)/build/Object-%-debug $(TARGET_TEMP_DIR)/build/Object-%-debug/% |$(TARGET_TEMP_DIR)/build
	$(QUIET)$(ECHO) "Create Binary Directory: $@ (debug)" ;
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Binary Directory Ready ($@)" ;

# Profile

$(TARGET_TEMP_DIR)/build/Object-x86_64-profile: $(TARGET_TEMP_DIR)/build
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Object Directory Ready ($@)" ;

$(TARGET_TEMP_DIR)/build/Object-arm64-profile: $(TARGET_TEMP_DIR)/build
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Object Directory Ready ($@)" ;

$(TARGET_TEMP_DIR)/build/Object-arch64-profile: $(TARGET_TEMP_DIR)/build
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Object Directory Ready ($@)" ;

$(TARGET_TEMP_DIR)/build/Object-x86_64-profile/x86_64: $(TARGET_TEMP_DIR)/build/Object-x86_64-profile |$(TARGET_TEMP_DIR)/build
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Object Sub-Directory Ready (profile)" ;

$(TARGET_TEMP_DIR)/build/Object-arm64-profile/arm64: $(TARGET_TEMP_DIR)/build/Object-arm64-profile |$(TARGET_TEMP_DIR)/build
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Object Sub-Directory Ready (arm64 profile)" ;

$(TARGET_TEMP_DIR)/build/Object-arch64-profile/arch64: $(TARGET_TEMP_DIR)/build/Object-arch64-profile |$(TARGET_TEMP_DIR)/build
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Object Sub-Directory Ready (arch64 profile)" ;

$(TARGET_TEMP_DIR)/build/Object-%-profile/%: $(TARGET_TEMP_DIR)/build/Object-%-profile |$(TARGET_TEMP_DIR)/build
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Object Sub-Directory Ready (profile)" ;

$(TARGET_TEMP_DIR)/build/Object-x86_64-profile/x86_64/Binary: $(TARGET_TEMP_DIR)/build/Object-x86_64-profile $(TARGET_TEMP_DIR)/build/Object-x86_64-profile/x86_64 |$(TARGET_TEMP_DIR)/build
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Binary Directory Ready (profile)" ;

$(TARGET_TEMP_DIR)/build/Object-arm64-profile/arm64/Binary: $(TARGET_TEMP_DIR)/build/Object-arm64-profile $(TARGET_TEMP_DIR)/build/Object-arm64-profile/arm64 |$(TARGET_TEMP_DIR)/build
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Binary Directory Ready (arm64 profile)" ;

$(TARGET_TEMP_DIR)/build/Object-arch64-profile/arch64/Binary: $(TARGET_TEMP_DIR)/build/Object-arch64-profile $(TARGET_TEMP_DIR)/build/Object-arch64-profile/arch64 |$(TARGET_TEMP_DIR)/build
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Binary Directory Ready (arch64 profile)" ;

$(TARGET_TEMP_DIR)/build/Object-%-profile/%/Binary: $(TARGET_TEMP_DIR)/build/Object-%-profile $(TARGET_TEMP_DIR)/build/Object-%-profile/% |$(TARGET_TEMP_DIR)/build
	$(QUIET)$(ECHO) "Create Binary Directory: $@" ;
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Binary Directory Ready (profile)" ;

XCMBuild-vers-hdr:: $(BUILD_ROOT)/XCMBuild_vers.c |build
	$(QUIET)$(ECHO) "Wrote Version Source: $< ( $(CURRENT_PROJECT_VERSION) )" ;
	$(DO_FAIL) ;

$(BUILD_ROOT)/XCMBuild_vers.c: |build
	$(QUIET)$(ECHO) "Generating Version Source: $@ ( XCMBuild )" ;
	$(QUIET)$(XCMB_GEN_VER_SRC_BUILD_TOOL) XCMBuild $(CURRENT_PROJECT_VERSION) >"$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(WAIT) ;
	$(DO_FAIL) ;

$(BUILD_ROOT)/XCMTest_vers.c: |build
	$(QUIET)$(ECHO) "Generating Version Source: $@ ( XCMTest )" ;
	$(QUIET)$(XCMB_GEN_VER_SRC_BUILD_TOOL) XCMTest $(CURRENT_PROJECT_VERSION) >"$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(WAIT) ;
	$(DO_FAIL) ;

$(BUILD_ROOT)/XCMClean_vers.c: |build
	$(QUIET)$(ECHO) "Generating Version Source: $@ ( XCMClean )" ;
	$(QUIET)$(XCMB_GEN_VER_SRC_BUILD_TOOL) XCMClean $(CURRENT_PROJECT_VERSION) >"$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(WAIT) ;
	$(DO_FAIL) ;

$(BUILD_ROOT)/xcrunshell_vers.c: |build
	$(QUIET)$(ECHO) "Generating Version Source: $@ ( xcrunshell )" ;
	$(QUIET)$(XCMB_GEN_VER_SRC_BUILD_TOOL) xcrunshell $(CURRENT_PROJECT_VERSION) >"$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(WAIT) ;
	$(DO_FAIL) ;

#$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/%.o: XCMBuild/%/%.m XCMBuild/%/%.h |$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64
#	$(QUIET)$(CLANG) -x objective-c -target x86_64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
#	-fmodules -fmodule-name\=XCMBuild.$% $(CLANG_FLAGS_ALL) $(CLANG_OBJC_FLAGS) \
#	-L/Library -F/Library/Frameworks -Fdist/Library/Frameworks \
#	-I XCMBuild/"$%" \
#	-c $< -o $@ || DO_FAIL="exit 2" ;
#
#$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/%.o: XCMBuild/%/%.m XCMBuild/%/%.h |$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64
#	$(QUIET)$(CLANG) -x objective-c -target arm64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
#	-fmodules -fmodule-name\=XCMBuild.$% $(CLANG_FLAGS_ALL) $(CLANG_OBJC_FLAGS) \
#	-L/Library -F/Library/Frameworks -Fdist/Library/Frameworks \
#	-I XCMBuild/"$%" \
#	-c $< -o $@ || DO_FAIL="exit 2" ;
#
#$(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/%.o: XCMBuild/%/%.m XCMBuild/%/%.h |$(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64
#	$(QUIET)$(CLANG) -x objective-c -target aarch64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
#	-fmodules -fmodule-name\=XCMBuild.$% $(CLANG_FLAGS_ALL) $(CLANG_OBJC_FLAGS) \
#	-L/Library -F/Library/Frameworks -Fdist/Library/Frameworks \
#	-I XCMBuild/"$%" \
#	-c $< -o $@ || DO_FAIL="exit 2" ;

#$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/xcrunshell.o: XCMBuild/xcrunshell/main.m XCMBuild/xcrunshell/xcrunshell.h $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/xcrunshell_vers.o |$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64
#	$(QUIET)$(ECHO) "Compile Tool: $@ (x86_64)" ;
#	$(CLANG) -x objective-c -target x86_64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) -Xlinker \
#	$(CLANG_FLAGS_ALL) $(CCFLAGS_DARWIN) \
#	$(CLANG_OBJC_FLAGS) \
#	-v \
#	-fmodules -fmodule-name\=XCMBuild.XCRunner \
#	-Fdist/Library/Frameworks -L/Library -F/Library/Frameworks \
#	-I$(BUILD_ROOT)/$(CONFIGURATION) -I$(PROJECT_ROOT) -I$(PROJECT_ROOT)/XCMBuild/xcrunshell/ \
#	-I$(PROJECT_ROOT)/XCMBuild -I$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64 \
#	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/xcrunshell.d \
#	-c $< -o $@ || DO_FAIL="exit 2" ;
#	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
#	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/xcrunshell/main.o: XCMBuild/xcrunshell/main.m XCMBuild/xcrunshell/xcrunshell.h $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/xcrunshell_vers.o |$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/xcrunshell
	$(QUIET)$(ECHO) "Compile Run-Tool: $@ (x86_64)" ;
	$(QUIET)$(CLANG) -x objective-c -target x86_64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit\=0 \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
	-fbuild-session-file\=$(BUILD_ROOT)/xcrunshell_vers.c \
	-fmodules -gmodules \
	-fmodule-name\=XCMBuild.XCRunner \
	-mincremental-linker-compatible \
	-O0 -flto\=thin -fno-common -isysroot $(SDKROOT) $(CCFLAGS_DARWIN) \
	-I$(PROJECT_ROOT)/XCMBuild/xcrunshell -I$(PROJECT_ROOT)/XCMBuild \
	-I$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/xcrunshell \
	-F/$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot $(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot usr/lib \
	-iframeworkwithsysroot usr/lib/System \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/xcrunshell.d \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/xcrunshell_vers.o:: $(BUILD_ROOT)/xcrunshell_vers.c $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64 |build
	$(QUIET)$(ECHO) "Compile Version Header: $@ (x86_64)" ;
	$(QUIET)$(CLANG) -target x86_64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit\=0 \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
	-fbuild-session-file\=$(BUILD_ROOT)/xcrunshell_vers.c \
	-fmodules -gmodules	-fmodule-name\=XCMBuild.XCMRunner \
	-mincremental-linker-compatible \
	-O0 -flto\=thin -fno-common -isysroot $(SDKROOT) $(CCFLAGS_DARWIN) \
	-F/$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot $(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot usr/lib \
	-iframeworkwithsysroot usr/lib/System \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-iframeworkwithsysroot /$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-x objective-c \
	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/xcrunshell_vers.d \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/xcrunshell/main.o: XCMBuild/xcrunshell/main.m XCMBuild/xcrunshell/xcrunshell.h $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/xcrunshell_vers.o |$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/xcrunshell
	$(QUIET)$(ECHO) "Compile Run-Tool: $@ (arm64)" ;
	$(QUIET)$(CLANG) -x objective-c -target arm64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit\=0 \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
	-fbuild-session-file\=$(BUILD_ROOT)/xcrunshell_vers.c \
	-fmodules -gmodules \
	-fmodule-name\=XCMBuild.XCRunner \
	-mincremental-linker-compatible \
	-O0 -flto\=thin -fno-common -isysroot $(SDKROOT) $(CCFLAGS_DARWIN) \
	-I$(PROJECT_ROOT)/XCMBuild/xcrunshell -I$(PROJECT_ROOT)/XCMBuild \
	-I$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/xcrunshell \
	-F/$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot $(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot usr/lib \
	-iframeworkwithsysroot usr/lib/System \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/xcrunshell.d \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/xcrunshell_vers.o:: $(BUILD_ROOT)/xcrunshell_vers.c $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64 |build
	$(QUIET)$(ECHO) "Compile Version Header: $@ (arm64)" ;
	$(QUIET)$(CLANG) -target arm64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit\=0 \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
	-fbuild-session-file\=$(BUILD_ROOT)/xcrunshell_vers.c \
	-fmodules -gmodules	-fmodule-name\=XCMBuild.XCMRunner \
	-mincremental-linker-compatible \
	-O0 -flto\=thin -fno-common -isysroot $(SDKROOT) $(CCFLAGS_DARWIN) \
	-F/$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot $(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot usr/lib \
	-iframeworkwithsysroot usr/lib/System \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-iframeworkwithsysroot /$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-x objective-c \
	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/xcrunshell_vers.d \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;


$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCMTest/main.o: XCMBuild/XCMTest/main.m XCMBuild/XCMTest/XCMTest.h $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCMTest_vers.o |$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCMTest
	$(QUIET)$(ECHO) "Compile XCMTest: $@ (x86_64)" ;
	$(QUIET)$(CLANG) -x objective-c -target x86_64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit\=0 \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
	-fbuild-session-file\=$(BUILD_ROOT)/XCMTest_vers.c \
	-fmodules -gmodules \
	-fmodule-name\=XCMBuild.XCMTest \
	-mincremental-linker-compatible \
	-O0 -flto\=thin -fno-common -isysroot $(SDKROOT) $(CCFLAGS_DARWIN) \
	-I$(PROJECT_ROOT)/XCMBuild/XCMTest -I$(PROJECT_ROOT)/XCMBuild \
	-I$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCMTest \
	-F/$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot $(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot usr/lib \
	-iframeworkwithsysroot usr/lib/System \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCMTest.d \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCMTest_vers.o:: $(BUILD_ROOT)/XCMTest_vers.c $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64 |build
	$(QUIET)$(ECHO) "Compile Version Header: $@ (x86_64)" ;
	$(QUIET)$(CLANG) -target x86_64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit\=0 \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
	-fbuild-session-file\=$(BUILD_ROOT)/XCMTest_vers.c \
	-fmodules -gmodules	-fmodule-name\=XCMBuild.XCMTest \
	-mincremental-linker-compatible \
	-O0 -flto\=thin -fno-common -isysroot $(SDKROOT) $(CCFLAGS_DARWIN) \
	-F/$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot $(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot usr/lib \
	-iframeworkwithsysroot usr/lib/System \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-iframeworkwithsysroot /$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-x objective-c \
	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCMTest_vers.d \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCMTest/main.o: XCMBuild/XCMTest/main.m XCMBuild/XCMTest/XCMTest.h $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCMTest_vers.o |$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCMTest
	$(QUIET)$(ECHO) "Compile XCMTest: $@ (arm64)" ;
	$(QUIET)$(CLANG) -x objective-c -target arm64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit\=0 \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
	-fbuild-session-file\=$(BUILD_ROOT)/XCMTest_vers.c \
	-fmodules -gmodules \
	-fmodule-name\=XCMBuild.XCMTest \
	-mincremental-linker-compatible \
	-O0 -flto\=thin -fno-common -isysroot $(SDKROOT) $(CCFLAGS_DARWIN) \
	-I$(PROJECT_ROOT)/XCMBuild/XCMTest -I$(PROJECT_ROOT)/XCMBuild \
	-I$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCMTest \
	-F/$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot $(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot usr/lib \
	-iframeworkwithsysroot usr/lib/System \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCMTest.d \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCMTest_vers.o:: $(BUILD_ROOT)/XCMTest_vers.c $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64 |build
	$(QUIET)$(ECHO) "Compile Version Header: $@ (arm64)" ;
	$(QUIET)$(CLANG) -target arm64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit\=0 \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
	-fbuild-session-file\=$(BUILD_ROOT)/XCMTest_vers.c \
	-fmodules -gmodules	-fmodule-name\=XCMBuild.XCMTest \
	-mincremental-linker-compatible \
	-O0 -flto\=thin -fno-common -isysroot $(SDKROOT) $(CCFLAGS_DARWIN) \
	-F/$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot /$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot usr/lib \
	-iframeworkwithsysroot usr/lib/System \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-iframeworkwithsysroot /$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-x objective-c \
	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCMTest_vers.d \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;


$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCMClean/main.o: XCMBuild/XCMClean/main.m XCMBuild/XCMClean/XCMClean.h $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCMClean_vers.o |$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCMClean
	$(QUIET)$(ECHO) "Compile XCMClean: $@ (x86_64)" ;
	$(QUIET)$(CLANG) -x objective-c -target x86_64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit\=0 \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
	-fbuild-session-file\=$(BUILD_ROOT)/XCMClean_vers.c \
	-fmodules -gmodules \
	-mincremental-linker-compatible \
	-O0 -flto\=thin -fno-common -isysroot $(SDKROOT) $(CCFLAGS_DARWIN) \
	-I$(PROJECT_ROOT)/XCMBuild/XCMClean -I$(PROJECT_ROOT)/XCMBuild \
	-I$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCMClean \
	-F/$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot $(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot usr/lib \
	-iframeworkwithsysroot usr/lib/System \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCMClean.d \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCMClean_vers.o:: $(BUILD_ROOT)/XCMClean_vers.c $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64 |build
	$(QUIET)$(ECHO) "Compile Version Header: $@ (x86_64)" ;
	$(QUIET)$(CLANG) -target x86_64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit\=0 \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
	-fbuild-session-file\=$(BUILD_ROOT)/XCMClean_vers.c \
	-fmodules -gmodules \
	-mincremental-linker-compatible \
	-O0 -flto\=thin -fno-common -isysroot $(SDKROOT) $(CCFLAGS_DARWIN) \
	-F/$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot $(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot usr/lib \
	-iframeworkwithsysroot usr/lib/System \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-iframeworkwithsysroot /$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-x objective-c \
	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCMClean_vers.d \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCMClean/main.o: XCMBuild/XCMClean/main.m XCMBuild/XCMClean/XCMClean.h $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCMClean_vers.o |$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCMClean
	$(QUIET)$(ECHO) "Compile XCMClean: $@ (arm64)" ;
	$(QUIET)$(CLANG) -x objective-c -target arm64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit\=0 \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
	-fbuild-session-file\=$(BUILD_ROOT)/XCMClean_vers.c \
	-fmodules -gmodules \
	-mincremental-linker-compatible \
	-O0 -flto\=thin -fno-common -isysroot $(SDKROOT) $(CCFLAGS_DARWIN) \
	-I$(PROJECT_ROOT)/XCMBuild/XCMClean -I$(PROJECT_ROOT)/XCMBuild \
	-I$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCMClean \
	-F/$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot $(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot usr/lib \
	-iframeworkwithsysroot usr/lib/System \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCMClean.d \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCMClean_vers.o:: $(BUILD_ROOT)/XCMClean_vers.c $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64 |build
	$(QUIET)$(ECHO) "Compile Version Header: $@ (arm64)" ;
	$(QUIET)$(CLANG) -target arm64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit\=0 \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
	-fbuild-session-file\=$(BUILD_ROOT)/XCMClean_vers.c \
	-fmodules -gmodules \
	-mincremental-linker-compatible \
	-O0 -flto\=thin -fno-common -isysroot $(SDKROOT) $(CCFLAGS_DARWIN) \
	-F/$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot /$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot usr/lib \
	-iframeworkwithsysroot usr/lib/System \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-iframeworkwithsysroot /$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-x objective-c \
	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCMClean_vers.d \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;


$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/xcrunshell/main.o: XCMBuild/xcrunshell/main.m XCMBuild/xcrunshell/xcrunshell.h $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/xcrunshell_vers.o |$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/xcrunshell
	$(QUIET)$(ECHO) "Compile Run-Tool: $@ (x86_64)" ;
	$(QUIET)$(CLANG) -x objective-c -target x86_64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit\=0 \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
	-fbuild-session-file\=$(BUILD_ROOT)/xcrunshell_vers.c \
	-fmodules -gmodules -greproducible \
	-fmodule-name\=XCMBuild.XCRunner \
	-mincremental-linker-compatible \
	-Xpreprocessor -DDEBUG\=1 \
	-O0 -flto\=thin -fno-common -isysroot $(SDKROOT) $(CCFLAGS_DARWIN) \
	-I$(PROJECT_ROOT)/XCMBuild/xcrunshell -I$(PROJECT_ROOT)/XCMBuild \
	-I$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/xcrunshell \
	-F/$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot $(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot usr/lib \
	-iframeworkwithsysroot usr/lib/System \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/xcrunshell.d \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/xcrunshell_vers.o:: $(BUILD_ROOT)/xcrunshell_vers.c $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64 |build
	$(QUIET)$(ECHO) "Compile Version Header: $@ (x86_64)" ;
	$(QUIET)$(CLANG) -target x86_64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit\=0 \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
	-fbuild-session-file\=$(BUILD_ROOT)/xcrunshell_vers.c \
	-fmodules -gmodules	-greproducible -fmodule-name\=XCMBuild.XCMRunner \
	-mincremental-linker-compatible \
	-Xpreprocessor -DDEBUG\=1 \
	-O0 -flto\=thin -fno-common -isysroot $(SDKROOT) $(CCFLAGS_DARWIN) \
	-F/$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot $(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot usr/lib \
	-iframeworkwithsysroot usr/lib/System \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-iframeworkwithsysroot /$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-x objective-c \
	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/xcrunshell_vers.d \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/xcrunshell/main.o: XCMBuild/xcrunshell/main.m XCMBuild/xcrunshell/xcrunshell.h $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/xcrunshell_vers.o |$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/xcrunshell
	$(QUIET)$(ECHO) "Compile Run-Tool: $@ (arm64)" ;
	$(QUIET)$(CLANG) -x objective-c -target arm64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit\=0 \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
	-fbuild-session-file\=$(BUILD_ROOT)/xcrunshell_vers.c \
	-fmodules -gmodules -greproducible \
	-fmodule-name\=XCMBuild.XCRunner \
	-mincremental-linker-compatible \
	-Xpreprocessor -DDEBUG\=1 \
	-O0 -flto\=thin -fno-common -isysroot $(SDKROOT) $(CCFLAGS_DARWIN) \
	-I$(PROJECT_ROOT)/XCMBuild/xcrunshell -I$(PROJECT_ROOT)/XCMBuild \
	-I$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/xcrunshell \
	-F/$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot $(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot usr/lib \
	-iframeworkwithsysroot usr/lib/System \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/xcrunshell.d \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/xcrunshell_vers.o:: $(BUILD_ROOT)/xcrunshell_vers.c $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64 |build
	$(QUIET)$(ECHO) "Compile Version Header: $@ (arm64)" ;
	$(QUIET)$(CLANG) -target arm64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit\=0 \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
	-fbuild-session-file\=$(BUILD_ROOT)/xcrunshell_vers.c \
	-fmodules -gmodules	-greproducible -fmodule-name\=XCMBuild.XCMRunner \
	-mincremental-linker-compatible \
	-Xpreprocessor -DDEBUG\=1 \
	-O0 -flto\=thin -fno-common -isysroot $(SDKROOT) $(CCFLAGS_DARWIN) \
	-F/$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot $(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot usr/lib \
	-iframeworkwithsysroot usr/lib/System \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-iframeworkwithsysroot /$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-x objective-c \
	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/xcrunshell_vers.d \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;


$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCMTest/main.o: XCMBuild/XCMTest/main.m XCMBuild/XCMTest/XCMTest.h $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCMTest_vers.o |$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCMTest
	$(QUIET)$(ECHO) "Compile XCMTest: $@ (x86_64)" ;
	$(QUIET)$(CLANG) -x objective-c -target x86_64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit\=0 \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
	-fbuild-session-file\=$(BUILD_ROOT)/XCMTest_vers.c \
	-fmodules -gmodules -greproducible \
	-fmodule-name\=XCMBuild.XCMTest \
	-mincremental-linker-compatible \
	-Xpreprocessor -DDEBUG\=1 \
	-O0 -flto\=thin -fno-common -isysroot $(SDKROOT) $(CCFLAGS_DARWIN) \
	-I$(PROJECT_ROOT)/XCMBuild/XCMTest -I$(PROJECT_ROOT)/XCMBuild \
	-I$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCMTest \
	-F/$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot $(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot usr/lib \
	-iframeworkwithsysroot usr/lib/System \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCMTest.d \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCMTest_vers.o:: $(BUILD_ROOT)/XCMTest_vers.c $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64 |build
	$(QUIET)$(ECHO) "Compile Version Header: $@ (x86_64)" ;
	$(QUIET)$(CLANG) -target x86_64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit\=0 \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
	-fbuild-session-file\=$(BUILD_ROOT)/XCMTest_vers.c \
	-fmodules -gmodules	-greproducible -fmodule-name\=XCMBuild.XCMTest \
	-mincremental-linker-compatible \
	-Xpreprocessor -DDEBUG\=1 \
	-O0 -flto\=thin -fno-common -isysroot $(SDKROOT) $(CCFLAGS_DARWIN) \
	-F/$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot $(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot usr/lib \
	-iframeworkwithsysroot usr/lib/System \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-iframeworkwithsysroot /$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-x objective-c \
	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCMTest_vers.d \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCMTest/main.o: XCMBuild/XCMTest/main.m XCMBuild/XCMTest/XCMTest.h $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCMTest_vers.o |$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCMTest
	$(QUIET)$(ECHO) "Compile XCMTest: $@ (arm64)" ;
	$(QUIET)$(CLANG) -x objective-c -target arm64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit\=0 \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
	-fbuild-session-file\=$(BUILD_ROOT)/XCMTest_vers.c \
	-fmodules -gmodules -greproducible \
	-fmodule-name\=XCMBuild.XCMTest \
	-mincremental-linker-compatible \
	-Xpreprocessor -DDEBUG\=1 \
	-O0 -flto\=thin -fno-common -isysroot $(SDKROOT) $(CCFLAGS_DARWIN) \
	-I$(PROJECT_ROOT)/XCMBuild/XCMTest -I$(PROJECT_ROOT)/XCMBuild \
	-I$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCMTest \
	-F/$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot $(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot usr/lib \
	-iframeworkwithsysroot usr/lib/System \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCMTest.d \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCMTest_vers.o:: $(BUILD_ROOT)/XCMTest_vers.c $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64 |build
	$(QUIET)$(ECHO) "Compile Version Header: $@ (arm64)" ;
	$(QUIET)$(CLANG) -target arm64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit\=0 \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
	-fbuild-session-file\=$(BUILD_ROOT)/XCMTest_vers.c \
	-fmodules -gmodules	-greproducible -fmodule-name\=XCMBuild.XCMTest \
	-mincremental-linker-compatible \
	-Xpreprocessor -DDEBUG\=1 \
	-O0 -flto\=thin -fno-common -isysroot $(SDKROOT) $(CCFLAGS_DARWIN) \
	-F/$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot $(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot usr/lib \
	-iframeworkwithsysroot usr/lib/System \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-iframeworkwithsysroot /$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-x objective-c \
	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCMTest_vers.d \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;


$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCMClean/main.o: XCMBuild/XCMClean/main.m XCMBuild/XCMClean/XCMClean.h $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCMClean_vers.o |$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCMClean
	$(QUIET)$(ECHO) "Compile XCMClean: $@ (x86_64)" ;
	$(QUIET)$(CLANG) -x objective-c -target x86_64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit\=0 \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
	-fbuild-session-file\=$(BUILD_ROOT)/XCMClean_vers.c \
	-fmodules -gmodules -greproducible \
	-mincremental-linker-compatible \
	-Xpreprocessor -DDEBUG\=1 \
	-O0 -flto\=thin -fno-common -isysroot $(SDKROOT) $(CCFLAGS_DARWIN) \
	-I$(PROJECT_ROOT)/XCMBuild/XCMClean -I$(PROJECT_ROOT)/XCMBuild \
	-I$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCMClean \
	-F/$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot $(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot usr/lib \
	-iframeworkwithsysroot usr/lib/System \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCMClean.d \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCMClean_vers.o:: $(BUILD_ROOT)/XCMClean_vers.c $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64 |build
	$(QUIET)$(ECHO) "Compile Version Header: $@ (x86_64)" ;
	$(QUIET)$(CLANG) -target x86_64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit\=0 \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
	-fbuild-session-file\=$(BUILD_ROOT)/XCMClean_vers.c \
	-fmodules -gmodules	-greproducible \
	-mincremental-linker-compatible \
	-Xpreprocessor -DDEBUG\=1 \
	-O0 -flto\=thin -fno-common -isysroot $(SDKROOT) $(CCFLAGS_DARWIN) \
	-F/$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot $(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot usr/lib \
	-iframeworkwithsysroot usr/lib/System \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-iframeworkwithsysroot /$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-x objective-c \
	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCMClean_vers.d \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCMClean/main.o: XCMBuild/XCMClean/main.m XCMBuild/XCMClean/XCMClean.h $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCMClean_vers.o |$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCMClean
	$(QUIET)$(ECHO) "Compile XCMClean: $@ (arm64)" ;
	$(QUIET)$(CLANG) -x objective-c -target arm64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit\=0 \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
	-fbuild-session-file\=$(BUILD_ROOT)/XCMClean_vers.c \
	-fmodules -gmodules -greproducible \
	-mincremental-linker-compatible \
	-Xpreprocessor -DDEBUG\=1 \
	-O0 -flto\=thin -fno-common -isysroot $(SDKROOT) $(CCFLAGS_DARWIN) \
	-I$(PROJECT_ROOT)/XCMBuild/XCMClean -I$(PROJECT_ROOT)/XCMBuild \
	-I$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCMClean \
	-F/$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot $(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot usr/lib \
	-iframeworkwithsysroot usr/lib/System \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCMClean.d \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCMClean_vers.o:: $(BUILD_ROOT)/XCMClean_vers.c $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64 |build
	$(QUIET)$(ECHO) "Compile Version Header: $@ (arm64)" ;
	$(QUIET)$(CLANG) -target arm64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit\=0 \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
	-fbuild-session-file\=$(BUILD_ROOT)/XCMClean_vers.c \
	-fmodules -gmodules	-greproducible -fmodule-name\=XCMBuild.XCMClean \
	-mincremental-linker-compatible \
	-Xpreprocessor -DDEBUG\=1 \
	-O0 -flto\=thin -fno-common -isysroot $(SDKROOT) $(CCFLAGS_DARWIN) \
	-F/$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot $(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot usr/lib \
	-iframeworkwithsysroot usr/lib/System \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-iframeworkwithsysroot /$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-x objective-c \
	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCMClean_vers.d \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/%_vers.o:: $(BUILD_ROOT)/%_vers.c $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64 |build
	$(QUIET)$(ECHO) "Compile Version Header: $@ (x86_64)" ;
	$(QUIET)$(CLANG) -x objective-c -target x86_64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) $(CCFLAGS_DARWIN) \
	-fbuild-session-file\=$< \
	-fmodules -fmodule-name\=XCMBuild.$% $(CLANG_OBJC_FLAGS) \
	-fno-autolink \
	-F/Library/Frameworks -Fdist/Library/Frameworks -I$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64 \
	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/$%_vers.d \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/%_vers.o:: $(BUILD_ROOT)/%_vers.c $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64 |build
	$(QUIET)$(ECHO) "Compile Version Header: $@ (arm64)" ;
	$(QUIET)$(CLANG) -x objective-c -target arm64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) $(CCFLAGS_DARWIN) \
	-fbuild-session-file\=$< \
	-fmodules -fmodule-name\=XCMBuild.$% $(CLANG_OBJC_FLAGS) \
	-fno-autolink \
	-F/Library/Frameworks -Fdist/Library/Frameworks -I$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64 \
	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/$%_vers.d \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/%_vers.o:: $(BUILD_ROOT)/%_vers.c $(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64 |build
	$(QUIET)$(ECHO) "Compile Version Header: $@ (arch64)" ;
	$(QUIET)$(CLANG) -x objective-c -target aarch64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) $(CCFLAGS_DARWIN) \
	-fbuild-session-file\=$< \
	-fmodules -fmodule-name\=XCMBuild.$% $(CLANG_OBJC_FLAGS) \
	-fno-autolink \
	-F/Library/Frameworks -Fdist/Library/Frameworks -I$(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64 \
	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/$%_vers.d \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/%_vers.o:: $(BUILD_ROOT)/%_vers.c $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64 |build
	$(QUIET)$(ECHO) "Compile Version Header: $@ (x86_64 debug)" ;
	$(QUIET)$(CLANG) -x objective-c -target x86_64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) $(CCFLAGS_DARWIN) \
	-fbuild-session-file\=$< \
	-fmodules -g -fmodule-name\=XCMBuild.$% $(CLANG_OBJC_FLAGS) \
	-fno-autolink -greproducible \
	-F/Library/Frameworks -Fdist/Library/Frameworks -I$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64 \
	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/$%_vers.d \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/%_vers.o:: $(BUILD_ROOT)/%_vers.c $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64 |build
	$(QUIET)$(ECHO) "Compile Version Header: $@ (arm64 debug)" ;
	$(QUIET)$(CLANG) -x objective-c -target arm64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) $(CCFLAGS_DARWIN) \
	-fbuild-session-file\=$< \
	-fmodules -g -fmodule-name\=XCMBuild.$% $(CLANG_OBJC_FLAGS) \
	-fno-autolink -greproducible \
	-F/Library/Frameworks -Fdist/Library/Frameworks -I$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64 \
	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/$%_vers.d \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/%_vers.o:: $(BUILD_ROOT)/%_vers.c $(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64 |build
	$(QUIET)$(ECHO) "Compile Version Header: $@ (arch64 debug)" ;
	$(QUIET)$(CLANG) -x objective-c -target aarch64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) $(CCFLAGS_DARWIN) \
	-fbuild-session-file\=$< \
	-fmodules -g -fmodule-name\=XCMBuild.$% $(CLANG_OBJC_FLAGS) \
	-fno-autolink -greproducible \
	-F/Library/Frameworks -Fdist/Library/Frameworks -I$(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64 \
	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/$%_vers.d \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(PROJECT_TEMP_ROOT)/EagerLinkingTBDs/$(CONFIGURATION):
	$(QUIET)$(ECHO) "Create EagerLinking Directory: $@" ;
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(RESET_TIME) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "EagerLinking Directory Ready ( $(CONFIGURATION) )" ;


$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/%.o: XCMBuild/%.m XCMBuild/%.h |$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64
	$(QUIET)$(ECHO) "Compile: $@ (x86_64)" ;
	$(QUIET)$(CLANG) -x objective-c -target x86_64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) $(CCFLAGS_DARWIN) \
	-fmodules -fmodule-name\=XCMBuild $(CLANG_OBJC_FLAGS) \
	-fno-autolink \
	-F/Library/Frameworks -Fdist/Library/Frameworks -I$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64 \
	-I$(BUILD_ROOT)/$(CONFIGURATION) -I$(PROJECT_ROOT) -I$(PROJECT_ROOT)/XCMBuild \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(QUITE)$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/%.o: XCMBuild/%.m XCMBuild/%.h |$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64
	$(QUIET)$(ECHO) "Compile: $@ (arm64)" ;
	$(QUIET)$(CLANG) -x objective-c -target arm64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CCFLAGS_DARWIN) \
	-fmodules -fmodule-name\=XCMBuild \
	$(CLANG_FLAGS_ALL) $(CLANG_OBJC_FLAGS) \
	-fno-autolink \
	-F/Library/Frameworks -Fdist/Library/Frameworks -I$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64 \
	-I$(BUILD_ROOT)/$(CONFIGURATION) -I$(PROJECT_ROOT) -I$(PROJECT_ROOT)/XCMBuild \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(QUITE)$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/%.o: XCMBuild/%.m XCMBuild/%.h |$(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64
	$(QUIET)$(ECHO) "Compile: $@ (arch64)" ;
	$(QUIET)$(CLANG) -x objective-c -target aarch64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CCFLAGS_DARWIN) \
	-fmodules -fmodule-name\=XCMBuild \
	$(CLANG_FLAGS_ALL) $(CLANG_OBJC_FLAGS) \
	-fno-autolink \
	-F/Library/Frameworks -Fdist/Library/Frameworks -I$(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64 \
	-I$(BUILD_ROOT)/$(CONFIGURATION) -I$(PROJECT_ROOT) -I$(PROJECT_ROOT)/XCMBuild \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(QUITE)$(DO_FAIL) ;


$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/%.o: XCMBuild/%.m XCMBuild/%.h |$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64
	$(QUIET)$(ECHO) "Compile: $@ (x86_64)" ;
	$(QUIET)$(CLANG) -x objective-c -target x86_64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) $(CCFLAGS_DARWIN) \
	-fmodules -gmodules -fmodule-name\=XCMBuild $(CLANG_OBJC_FLAGS) \
	-fno-autolink \
	-F/Library/Frameworks -Fdist/Library/Frameworks -I$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64 \
	-I$(BUILD_ROOT)/$(CONFIGURATION) -I$(PROJECT_ROOT) -I$(PROJECT_ROOT)/XCMBuild \
	-greproducible \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(QUITE)$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/%.o: XCMBuild/%.m XCMBuild/%.h |$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64
	$(QUIET)$(ECHO) "Compile: $@ (arm64)" ;
	$(QUIET)$(CLANG) -x objective-c -target arm64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) $(CCFLAGS_DARWIN) \
	-fmodules -gmodules -fmodule-name\=XCMBuild $(CLANG_OBJC_FLAGS) \
	-fno-autolink \
	-F/Library/Frameworks -Fdist/Library/Frameworks -I$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64 \
	-I$(BUILD_ROOT)/$(CONFIGURATION) -I$(PROJECT_ROOT) -I$(PROJECT_ROOT)/XCMBuild \
	-greproducible \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(QUITE)$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/%.o: XCMBuild/%.m XCMBuild/%.h |$(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64
	$(QUIET)$(ECHO) "Compile: $@ (arch64)" ;
	$(QUIET)$(CLANG) -x objective-c -target aarch64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) $(CCFLAGS_DARWIN) \
	-fmodules -gmodules -fmodule-name\=XCMBuild $(CLANG_OBJC_FLAGS) \
	-fno-autolink \
	-F/Library/Frameworks -Fdist/Library/Frameworks -I$(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64 \
	-I$(BUILD_ROOT)/$(CONFIGURATION) -I$(PROJECT_ROOT) -I$(PROJECT_ROOT)/XCMBuild \
	-greproducible \
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(QUITE)$(DO_FAIL) ;

XCMBuild/%/%.m:: XCMBuild/%/ |init-start
	$(QUIET)$(TEST) -d $% || DO_FAIL="exit 2" ;
	$(QUIET)$(ECHO) "Checking ... $<" ;
	$(QUIET)$(TEST) -f $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "$@: Found." ;


include shared/includes/tools.make
include shared/includes/framework.make
include shared/includes/XCMBuild.make
include shared/includes/headers.make
include shared/includes/resources.make
include shared/includes/XCRunShell.make
include shared/includes/XCMTest.make
include shared/includes/XCMClean.make


$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/Binary/%: $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/%.o $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/%.LinkFileList shared/%-Info.plist |XCMBuild-dynamic-library
	$(QUIET)$(ECHO) "Combining objects into command line tool ($@)" || DO_FAIL="exit 2" ;
	$(QUIET)$(CLANG) -Xlinker -reproducible -target x86_64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	-O0 -L$(PROJECT_TEMP_ROOT)/EagerLinkingTBDs/$(CONFIGURATION) -L$(SYMROOT) \
	-F$(SYMROOT) -Fdist/Library/Frameworks \
	-Fbuild/$(CONFIGURATION) $(CCFLAGS_DARWIN) \
	-fmodules -gmodules -fmodule-name\=XCMBuild.XCRunner \
	-filelist $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/$%.LinkFileList -Xlinker -no_exported_symbols -Xlinker -rpath \
	-Xlinker @executable_path/../Frameworks -Xlinker -rpath -Xlinker @executable_path/../../../Current \
	-Xlinker -rpath -Xlinker @loader_path/Frameworks -Xlinker -rpath -Xlinker @executable_path/../../Library/Frameworks/XCMBuild.framework \
	-Xlinker -rpath -Xlinker @executable_path/../lib -Xlinker -rpath -Xlinker @loader_path/../Frameworks \
	-Xlinker -rpath -Xlinker @loader_path/../lib -dead_strip \
	-Xlinker -no_deduplicate \
	$(CLANG_FLAGS_ALL) $(CLANG_OBJC_FLAGS) -Xlinker -final_output \
	-Xlinker /Library/Frameworks/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/usr/bin/$% -fobjc-link-runtime \
	-ObjC -weak-lobjc -weak_framework CoreFoundation,framework -weak_framework Foundation,framework -framework XCMBuild,framework \
	-weak-lc -Xlinker -no_adhoc_codesign \
	-sectcreate __TEXT __info_plist $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/$%-Info.plist \
	-o $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;


unbuild/%::
	$(QUIET)$(ECHO) "Removing $% from buildroot ..." ;
	$(QUIET)$(RMDIR) $(BUILD_ROOT)/$% 2>/dev/null || true ;
	$(DO_FAIL) ;

unbin/%: $(TARGET_TEMP_DIR)/build/bin/%
	$(QUIET)$(ECHO) "Removing $< from build-cache ..." ;
	$(QUIET)$(RM) $(WITH_FORCE) $< 2>/dev/null || true ;
	$(QUITE)$(DO_FAIL) ;

uninstall-tool-dir:: unbin/xcode_clonefile.bash unbin/clonefile unbin/prunefile unbin/fxip unbin/tool_shlock_helper.bash
	$(QUIET)$(WAIT) ;
	$(QUIET)$(RMDIR) $(TARGET_TEMP_DIR)/build/bin/ 2>/dev/null || true ;
	$(QUIET)$(ECHO) "$@: Done." ;

uninstall-dot-%: ~/.%
	$(QUIET)$(RM) $(WITH_FORCE) $< 2>/dev/null || true
	$(QUIET)$(RM) $(WITH_FORCE) $<~ 2>/dev/null || true
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$<: Removed. ( $@ )"

uninstall-stage-dir::
	$(QUIET)$(RMDIR) $(UNINSTALLED_PRODUCTS_DIR) 2>/dev/null || true ;
	$(QUIET)$(ECHO) "$(UNINSTALLED_PRODUCTS_DIR): Removed. ( $@ )" ;

uninstall-temp-dir:: uninstall-stage-dir |cleanup_tmp_obj cleanup
	$(QUIET)$(RMDIR) $(TARGET_TEMP_DIR) 2>/dev/null || true ;
	$(QUIET)$(ECHO) "$(TARGET_TEMP_DIR): Removed. ( $@ )" ;

uninstall: unbuild/$(CONFIGURATION) uninstall-temp-dir
	$(QUIET)$(RM) $(WITH_FORCE) $(OBJECT_FILE_DIR) 2>/dev/null || true ;
	$(QUIET)$(RMDIR) $(abspath $(PROJECT_TEMP_ROOT))/Cache 2>/dev/null || true ;
	$(QUIET)$(WAIT) ;
	$(QUIET)$(ECHO) "$@: Done." ;

purge: clean uninstall-resources uninstall-tool-dir uninstall
	$(QUIET)$(RMDIR) $(BUILD_ROOT) 2>/dev/null || true ;
	$(QUIET)$(RMDIR) $(DSTROOT) 2>/dev/null || true
	$(QUIET)$(ECHO) "$@: Done. (Please restart)"

test:: init cleanup
	$(QUIET)$(ECHO) "$@: START." ;
	$(QUIET)$(WAIT) ;
	$(QUIET)$(GIT) ls-files ./tests/test_*sh -z 2>/dev/null | xargs -0 -L1 -I{} $(SHELL) -c "({} && echo -e '\t{}: Succeded') || (echo -e '\t{}: FAILURE' >&2 && false ) " || DO_FAIL="exit 2" ;
	$(QUIET)$(WAIT) ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "$@: END." ;

test-tox: cleanup
	$(QUIET)$(ECHO) "$@: N/A."

test-style: cleanup
	$(QUIET)$(ECHO) "$@: N/A."

cleanup_tmp_obj::
	$(QUIET)$(RM) $(WITH_FORCE) $(TARGET_TEMP_DIR)/build/Object-*-normal/*/Binary/.DS_Store 2>/dev/null || true ;
	$(QUIET)$(RMDIR) $(TARGET_TEMP_DIR)/build/Object-*-normal/*/Binary/XCMBuild.framwork/ 2>/dev/null || true ;
	$(QUIET)$(RM) $(WITH_FORCE) $(TARGET_TEMP_DIR)/build/Object-*-normal/*/*.o 2>/dev/null || true ;
	$(QUIET)$(RM) $(WITH_FORCE) $(TARGET_TEMP_DIR)/build/Object-*-normal/*/xc*/*.o 2>/dev/null || true ;
	$(QUIET)$(RM) $(WITH_FORCE) $(TARGET_TEMP_DIR)/build/Object-*-normal/*/XC*/*.o 2>/dev/null || true ;
	$(QUIET)$(RM) $(WITH_FORCE) $(TARGET_TEMP_DIR)/build/Object-*-normal/*/xc*/.DS_Store 2>/dev/null || true ;
	$(QUIET)$(RM) $(WITH_FORCE) $(TARGET_TEMP_DIR)/build/Object-*-normal/*/XC*/.DS_Store 2>/dev/null || true ;
	$(QUIET)$(RM) $(WITH_FORCE) $(TARGET_TEMP_DIR)/build/Object-*-normal/*/*lto*/*.o 2>/dev/null || true ;
	$(QUIET)$(RM) $(WITH_FORCE) $(TARGET_TEMP_DIR)/build/Object-*-normal/*/.DS_Store 2>/dev/null || true ;
	$(QUIET)$(RM) $(WITH_FORCE) $(TARGET_TEMP_DIR)/build/Object-*-normal/*/*.LinkFileList 2>/dev/null || true ;
	$(QUIET)$(RM) $(WITH_FORCE) $(TARGET_TEMP_DIR)/build/Object-*-debug/*/Binary/.DS_Store 2>/dev/null || true ;
	$(QUIET)$(RM) $(WITH_FORCE) $(TARGET_TEMP_DIR)/build/Object-*-debug/*/*.o 2>/dev/null || true ;
	$(QUIET)$(RM) $(WITH_FORCE) $(TARGET_TEMP_DIR)/build/Object-*-debug/*/xc*/*.o 2>/dev/null || true ;
	$(QUIET)$(RM) $(WITH_FORCE) $(TARGET_TEMP_DIR)/build/Object-*-debug/*/XC*/*.o 2>/dev/null || true ;
	$(QUIET)$(RM) $(WITH_FORCE) $(TARGET_TEMP_DIR)/build/Object-*-debug/*/xc*/.DS_Store 2>/dev/null || true ;
	$(QUIET)$(RM) $(WITH_FORCE) $(TARGET_TEMP_DIR)/build/Object-*-debug/*/XC*/.DS_Store 2>/dev/null || true ;
	$(QUIET)$(RM) $(WITH_FORCE) $(TARGET_TEMP_DIR)/build/Object-*-debug/*/*lto*/*.o 2>/dev/null || true ;
	$(QUIET)$(RM) $(WITH_FORCE) $(TARGET_TEMP_DIR)/build/Object-*-debug/*/.DS_Store 2>/dev/null || true ;
	$(QUIET)$(RM) $(WITH_FORCE) $(TARGET_TEMP_DIR)/build/Object-*-debug/*/*.LinkFileList 2>/dev/null || true ;
	$(QUIET)$(RM) $(WITH_FORCE) $(TARGET_TEMP_DIR)/build/Object-*-profile/*/Binary/.DS_Store 2>/dev/null || true ;
	$(QUIET)$(RM) $(WITH_FORCE) $(TARGET_TEMP_DIR)/build/Object-*-profile/*/*.o 2>/dev/null || true ;
	$(QUIET)$(RM) $(WITH_FORCE) $(TARGET_TEMP_DIR)/build/Object-*-profile/*/xc*/*.o 2>/dev/null || true ;
	$(QUIET)$(RM) $(WITH_FORCE) $(TARGET_TEMP_DIR)/build/Object-*-profile/*/XC*/*.o 2>/dev/null || true ;
	$(QUIET)$(RM) $(WITH_FORCE) $(TARGET_TEMP_DIR)/build/Object-*-profile/*/xc*/.DS_Store 2>/dev/null || true ;
	$(QUIET)$(RM) $(WITH_FORCE) $(TARGET_TEMP_DIR)/build/Object-*-profile/*/XC*/.DS_Store 2>/dev/null || true ;
	$(QUIET)$(RM) $(WITH_FORCE) $(TARGET_TEMP_DIR)/build/Object-*-profile/*/*lto*/*.o 2>/dev/null || true ;
	$(QUIET)$(RM) $(WITH_FORCE) $(TARGET_TEMP_DIR)/build/Object-*-profile/*/.DS_Store 2>/dev/null || true ;
	$(QUIET)$(RM) $(WITH_FORCE) $(TARGET_TEMP_DIR)/build/Object-*-profile/*/*.LinkFileList 2>/dev/null || true ;
	$(QUIET)$(RM) $(WITH_FORCE) $(TARGET_TEMP_DIR)/LTOCache/llvmcache* 2>/dev/null || true ;
	$(QUIET)$(ECHO) "Purged object files." ;

cleanup_tmp_obj_dir:: cleanup_tmp_obj
	$(QUIET)$(RMDIR) $(TARGET_TEMP_DIR)/build/Object-*-normal/ 2>/dev/null || true ;
	$(QUIET)$(RMDIR) $(TARGET_TEMP_DIR)/build/Object-*-debug/ 2>/dev/null || true ;
	$(QUIET)$(RMDIR) $(TARGET_TEMP_DIR)/build/Object-*-profile/ 2>/dev/null || true ;
	$(QUIET)$(RMDIR) $(TARGET_TEMP_DIR)/build/ 2>/dev/null || true ;
	$(QUIET)$(RMDIR) $(TARGET_TEMP_DIR)/LTOCache/ 2>/dev/null || true ;
	$(QUIET)$(ECHO) "Purged object caches." ;

cleanup_DS_Store::
	$(QUIET)$(RM) $(WITH_FORCE) ./.DS_Store 2>/dev/null || true
	$(QUIET)$(RM) $(WITH_FORCE) ./*/.DS_Store 2>/dev/null || true
	$(QUIET)$(RM) $(WITH_FORCE) ./*/*/.DS_Store 2>/dev/null || true
	$(QUIET)$(RM) $(WITH_FORCE) ./**/*.DS_Store 2>/dev/null || true
	$(QUIET)$(RM) $(WITH_FORCE) $(SYMROOT)/*/*/.DS_Store 2>/dev/null || true
	$(QUIET)$(RM) $(WITH_FORCE) $(SYMROOT)/**/*.DS_Store 2>/dev/null || true
	$(QUIET)$(RM) $(WITH_FORCE) $(DSTROOT)/*/*/.DS_Store 2>/dev/null || true
	$(QUIET)$(RM) $(WITH_FORCE) $(DSTROOT)/**/*.DS_Store 2>/dev/null || true
	$(QUIET)$(ECHO) "Purged directory service storage." ;

cleanup_temps::
	$(QUIET)$(RM) $(WITH_FORCE) ./*~ 2>/dev/null || true
	$(QUIET)$(RM) $(WITH_FORCE) ./.*~ 2>/dev/null || true
	$(QUIET)$(RM) $(WITH_FORCE) ./.git/*~ 2>/dev/null || true
	$(QUIET)$(RM) $(WITH_FORCE) tests/*~ 2>/dev/null || true
	$(QUIET)$(RM) $(WITH_FORCE) XCMBuild/*~ 2>/dev/null || true
	$(QUIET)$(RM) $(WITH_FORCE) XCMBuild/**/*~ 2>/dev/null || true
	$(QUIET)$(RM) $(WITH_FORCE) bin/*~ 2>/dev/null || true
	$(QUIET)$(RM) $(WITH_FORCE) shared/*~ 2>/dev/null || true
	$(QUIET)$(RM) $(WITH_FORCE) shared/security/*~ 2>/dev/null || true
	$(QUIET)$(RM) $(WITH_FORCE) shared/Clang/*~ 2>/dev/null || true
	$(QUIET)$(RM) $(WITH_FORCE) ./*/*~ 2>/dev/null || true
	$(QUIET)$(RM) $(WITH_FORCE) ./**/*~ 2>/dev/null || true
	$(QUIET)$(RM) $(WITH_FORCE) ./*/*/*/*~ 2>/dev/null || true
	$(QUIET)$(RM) $(WITH_FORCE) ./**/.*~ 2>/dev/null || true
	$(QUIET)$(ECHO) "Purged cache files." ;

cleanup:: |cleanup_DS_Store cleanup_temps
	$(QUIET)$(RMDIR) ./.tox/ 2>/dev/null || true

clean:: cleanup |cleanup_tmp_obj
	$(QUIET)$(WAIT) ;
	$(QUIET)$(ECHO) "$@: Done." ;

must_be_root:
	$(QUIET)runner=`whoami` ; \
	if test $$runner != "root" ; then $(ECHO) "You are not root." ; DO_FAIL="exit 126" ; fi ;

%:
	$(QUIET)$(ECHO) "No Rule Found For $$@" ;
	$(DO_FAIL) ;

endif
