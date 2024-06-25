#!/usr/bin/env make -f

# reactive-firewall/XCMBuild Repo Makefile
# ..................................
# Copyright (c) 2011-2024, Mr. Walls
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

ifeq "$(ALFW)" ""
	ALFW=/usr/libexec/ApplicationFirewall/socketfilterfw
endif

ifeq "$(CHGRP)" ""
	CHGRP=$(COMMAND) chgrp
endif

ifeq "$(CHMOD)" ""
	CHMOD=$(COMMAND) chmod
endif

ifeq "$(CHOWN)" ""
	CHOWN=$(COMMAND) chown
endif

ifeq "$(CLANG)" ""
	CLANG=$(COMMAND) clang
endif

ifeq "$(CP)" ""
	ifeq "$(CP)" ""
		CP!=`$(COMMAND) clonefile`
	endif
	ifeq "$(CP)" ""
		CP!=`$(COMMAND) bin/clonefile`
	endif
	ifeq "$(CP)" ""
		CP=$(COMMAND) cp
	endif
	ifeq "$(WITH_RECURSION)" ""
		WITH_RECURSION=-R
	endif
	ifeq "$(WITH_CARE)" ""
		WITH_CARE=-n
	endif
	ifeq "$(WITH_FORCE)" ""
		WITH_FORCE=-f
	endif
	ifeq "$(AND_RESPECT)" ""
		AND_RESPECT=-P
	endif
	ifeq "$(CPDIR)" ""
		CPDIR=$(CP) $(WITH_FORCE) $(WITH_RECURSION)
	endif
endif

ifeq "$(FIX_INFO_PLIST)" ""
	FIX_INFO_PLIST=$(COMMAND) bin/fxip
endif

ifeq "$(GIT)" ""
	GIT=$(COMMAND) git
endif

ifeq "$(INSTALL)" ""
	INSTALL=$(COMMAND) install -M
	ifeq "$(USER)" ""
		USER!=`id -u`
	endif
	ifeq "$(GROUP)" ""
		GROUP!=`id -g`
	endif
	ifeq "$(INST_OWN)" ""
		INST_OWN=-g $(GROUP) -o 0
	endif
	ifeq "$(INST_USER_OWN)" ""
		INST_USER_OWN=-g $(GROUP) -o $(USER)
	endif
	ifeq "$(INST_TOOL_OWN)" ""
		INST_USER_OWN=-o 0 -g 80
	endif
	ifeq "$(INST_OPTS)" ""
		INST_OPTS=-m 0751
	endif
	ifeq "$(INST_TOOL_OPTS)" ""
		INST_TOOL_OPTS=-m 0755
	endif
	ifeq "$(INST_FILE_OPTS)" ""
		INST_FILE_OPTS=-m 0640
	endif
	ifeq "$(INST_CONFIG_OPTS)" ""
		INST_CONFIG_OPTS=-m 0644
	endif
	ifeq "$(INST_DIR_OPTS)" ""
		INST_DIR_OPTS=-d
	endif
endif

ifeq "$(JARZIP)" ""
	JARZIP=$(COMMAND) jar
endif

ifeq "$(LANG)" ""
	LANG="en_US"

	ifeq "$(LC_CTYPE)" ""
		LC_CTYPE="$(LANG).UTF-8"
	endif
endif

ifeq "$(LD)" ""
	LD=$(COMMAND) ld
endif

ifeq "$(LINK)" ""
	LINK=$(COMMAND) ln -sf
endif

ifeq "$(LIPO)" ""
	LIPO=$(COMMAND) lipo
endif

ifeq "$(MAKEFLAGS)" ""
	MAKEFLAGS=--no-print-directory
else
	ifeq "$(MAKEFLAGS)" "--no-print-directory*"
		MAKEFLAGS=$(MAKEFLAGS) -s
	endif
endif

ifeq "$(MAKEWHATIS)" ""
	MAKEWHATIS=$(COMMAND) /usr/libexec/makewhatis.local
endif

ifeq "$(MKDIR)" ""
	MKDIR=$(COMMAND) mkdir -p $(INST_OPTS)
endif

ifeq "$(MV)" ""
	MV=$(COMMAND) mv
	ifeq "$(WITH_CARE)" ""
		WITH_CARE=-n
	endif
	ifeq "$(WITH_FORCE)" ""
		WITH_FORCE=-f
	endif
endif

ifeq "$(PRODUCT_ORG_IDENTIFIER)" ""
	PRODUCT_ORG_IDENTIFIER="org.adhoc.dt."
endif

ifeq "$(PRINT)" ""
	PRINT=printf
endif

ifeq "$(PATCH)" ""
	PATCH=$(COMMAND) patch -f -i
endif

ifeq "$(PFCTL)" ""
	PFCTL=$(COMMAND) pfctl
endif

ifeq "$(RM)" ""
	RM=$(COMMAND) rm
	ifeq "$(WITH_CARE)" ""
		WITH_CARE=-n
	endif
	ifeq "$(WITH_FORCE)" ""
		WITH_FORCE=-f
	endif
	ifeq "$(WITH_RECURSION)" ""
		WITH_RECURSION=-R
	endif
endif

ifeq "$(RMDIR)" ""
	RMDIR=$(RM) $(WITH_FORCE) $(WITH_RECURSION)d
endif

ifdef COMMAND
	SHELL:=$(COMMAND) bash
endif

ifeq "$(SED)" ""
	SED=$(COMMAND) sed
endif

ifeq "$(SETICON)" ""
	SETICON=$(COMMAND) bin/setIcon
endif

ifeq "$(SYNC)" ""
	SYNC=$(COMMAND) sync
endif

ifeq "$(TEST)" ""
	TEST=$(COMMAND) test
endif

ifeq "$(TOUCH)" ""
	TOUCH=$(COMMAND) touch -am
endif

ifeq "$(UNTAR)" ""
	UNTAR=$(COMMAND) tar --extract
	UNTAR_OPTION = --file
endif

ifeq "$(UNZIP)" ""
	UNZIP=$(COMMAND) unzip
	UNZIP_OPTION = -q -u -o
endif

ifeq "$(WAIT)" ""
	WAIT=wait
endif

ifeq "$(XCMB_GEN_VER_SRC_BUILD_TOOL)" ""
	XCMB_GEN_VER_SRC_BUILD_TOOL=$(COMMAND) bin/genversc.bash
endif

ifeq "$(XCMB_DOTD_BUILD_TOOL)" ""
	XCMB_DOTD_BUILD_TOOL=$(COMMAND) bin/header2DotD
endif

ifeq "$(STEMNAME)" ""
	STEMNAME=$(COMMAND) bin/stemname
endif

ifeq "$(STEMNAME)" ""
	STEMNAME=basename
endif

ifeq "$(XCRUN)" ""
	XCRUN=$(COMMAND) xcrun
endif

ifeq "$(XCMB_RUN_TOOL)" ""
	XCMB_RUN_TOOL_CMD!=`$(COMMAND) xcrun || $(COMMAND) xcrunshell || $(COMMAND) bin/posix_run_tool || $(COMMAND) $(SHELL)`
	ifeq "$(XCMB_RUN_TOOL_CMD)" "*xcrun"
		XCMB_RUN_TOOL_ARGS=--sdk $(SDK_NAME) --run
	else
		ifeq "$(XCMB_RUN_TOOL_CMD)" "$(SHELL)"
			XCMB_RUN_TOOL_ARGS=-c
		endif
	endif
	XCMB_RUN_TOOL=$(XCMB_RUN_TOOL_CMD) $(XCMB_RUN_TOOL_ARGS)
endif

#ifeq "$(XCMB_RUN_TOOL)" ""
#	XCMB_RUN_TOOL=$(COMMAND) bin/header2DotD
#endif

ifeq "$(LOG)" ""
	LOG=no
endif

#reset time to October 13 2023 at 12:42:13 AM
ifeq "$(RESET_TIME)" ""
	RESET_TIME=$(COMMAND) touch -c -f -t 202310130042.13
endif

.PHONY: all test clean
