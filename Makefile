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
# namely regarding lines 21 through 61 of this Makefile
# see https://stackoverflow.com/help/licensing for details
#
# This Modified Code is under dual-licenses APACHE-2 and CC BY-SA 3.0
# with regard to the code from https://stackoverflow.com/a/35320895
#
# CC BY-SA3.0 Attribution:
# THANKS to the user https://stackoverflow.com/users/999943/phyatt
# For the solid answer to https://stackoverflow.com/a/35320895

ifneq ($(words $(MAKECMDGOALS)),1) # if no argument was given to make...
.DEFAULT_GOAL = all # set the default goal to all

ifeq "$(ECHO)" ""
	ECHO=command -p echo
endif

%:		# define a last resort default rule
	@$(MAKE) $@ --no-print-directory -rRf $(firstword $(MAKEFILE_LIST)) # recursive make call,

else


ifeq "$(SHELL)" ""
	SHELL=command -pv bash
endif

ifeq "$(MAKE)" ""
	MAKE=command -pv make
endif

ifndef ECHO
T := $(shell $(MAKE) $(MAKECMDGOALS) --no-print-directory \
      -nrRf $(firstword $(MAKEFILE_LIST)) \
      ECHO="COUNTTHIS" | grep -c "COUNTTHIS" 2>/dev/null)
N := x
C = $(words $N)$(eval N := x $N)
ECHO = echo -ne "\r [`expr $C '*' 100 / $T`%]"
endif

# end of CC-SA-v3 inpired content 21-61


ifeq "$(ALFW)" ""
	ALFW=/usr/libexec/ApplicationFirewall/socketfilterfw
endif

ifeq "$(PFCTL)" ""
	PFCTL=command -pv pfctl
endif

ifeq "$(LINK)" ""
	LINK=command -pv ln -sf
endif

ifeq "$(WAIT)" ""
	WAIT=wait
endif

ifeq "$(RM)" ""
	RM=command -pv rm -f
endif

ifeq "$(CHMOD)" ""
	CHMOD=xcrun chmod -v
endif

ifeq "$(CHOWN)" ""
	CHOWN=xcrun chown -v
endif

ifeq "$(CP)" ""
	CP=command -pv cp -n
endif

ifeq "$(MKDIR)" ""
	MKDIR=xcrun mkdir -m 0755
endif

ifeq "$(RMDIR)" ""
	RMDIR=$(RM)dR
endif

ifeq "$(INSTALL)" ""
	INSTALL=xcrun install -M
	ifeq "$(INST_OWN)" ""
		USER=`id -u`
	endif
	ifeq "$(INST_OWN)" ""
		INST_OWN=-g `id -g` -o 0
	endif
	ifeq "$(INST_USER_OWN)" ""
		INST_USER_OWN=-g `id -g` -o $(USER)
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

ifeq "$(LOG)" ""
	LOG=no
endif

ifeq "$(LOG)" "no"
	QUIET=@
endif

.SUFFIXES: .zip .php .css .html .bash .sh .py .pyc .txt .js .plist .dmg

PHONY: must_be_root cleanup uninstall all

all: install test
	$(QUIET)$(WAIT)

build: init
	$(QUIET)$(ECHO) "No tool to build. Try adding some"

init:
	$(QUIET)$(ECHO) "$@: Done."

install: build
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: Done."

init-env: must_be_root XCMBuild_environment
	$(QUIET)$(WAIT)
	$(QUIET)source XCMBuild_environment ;
	$(QUIET)$(ECHO) "$@: Done."

~/.config/: ./payload/config/
	$(QUIET)$(MKDIR) $@ 2>/dev/null || true
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || true
	$(QUIET)$(CHMOD) $(INST_OPTS) $@ 2>/dev/null || true
	$(QUIET)$(WAIT)

~/.config/git/%: ./payload/config/git/% ~/.config/git/
	$(QUIET)$(WAIT)
	$(QUIET)$(INSTALL) $< $@ 2>/dev/null || true
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || true
	$(QUIET)$(CHMOD) $(INST_CONFIG_OPTS) $@ 2>/dev/null || true
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: installed"

~/.%rc: ./dot_%rc
	$(QUIET)$(WAIT)
	$(QUIET)$(INSTALL) $< $@ 2>/dev/null || true
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || true
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) $@ 2>/dev/null || true
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: installed."

~/.%: ./dot_%
	$(QUIET)$(WAIT)
	$(QUIET)$(INSTALL) $< $@ 2>/dev/null || true
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || true
	$(QUIET)$(CHMOD) $(INST_FILE_OPTS) $@ 2>/dev/null || true
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: installed."

uninstall-dot-%: ~/.%
	$(QUIET)$(RM) $< 2>/dev/null || true
	$(QUIET)$(RM) $<~ 2>/dev/null || true
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$<: Removed. ( $@ )"

uninstall:
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: Done."

purge: clean uninstall
	$(QUIET)$(ECHO) "$@: Done. (Please restart)"

test: cleanup
	$(QUIET)$(ECHO) "$@: START."
	$(QUIET)ls -1 ./tests/test_*sh 2>/dev/null | xargs -L1 -I{} $(SHELL) -c "{} && echo '{}: OK' || echo '{}: FAILED' >&2 ; " ;
	$(QUIET)$(WAIT) ;
	$(QUIET)$(ECHO) "$@: END."

test-tox: cleanup
	$(QUIET)$(ECHO) "$@: N/A."

test-style: cleanup
	$(QUIET)$(ECHO) "$@: N/A."

cleanup:
	$(QUIET)$(RM) tests/*~ 2>/dev/null || true
	$(QUIET)$(RM) ./.git/*~ 2>/dev/null || true
	$(QUIET)$(RM) ./*/.DS_Store 2>/dev/null || true
	$(QUIET)$(RM) ./*/*/.DS_Store 2>/dev/null || true
	$(QUIET)$(RM) ./**/*.DS_Store 2>/dev/null || true
	$(QUIET)$(RM) ./payload/*~ 2>/dev/null || true
	$(QUIET)$(RM) ./payload/**/*~ 2>/dev/null || true
	$(QUIET)$(RM) ./payload/bin/*~ 2>/dev/null || true
	$(QUIET)$(RM) ./payload/config/*~ 2>/dev/null || true
	$(QUIET)$(RM) ./payload/etc/*~ 2>/dev/null || true
	$(QUIET)$(RM) ./*/*~ 2>/dev/null || true
	$(QUIET)$(RM) ./**/*~ 2>/dev/null || true
	$(QUIET)$(RM) ./*/*/*/*~ 2>/dev/null || true
	$(QUIET)$(RM) ./*~ 2>/dev/null || true
	$(QUIET)$(RM) ./.*~ 2>/dev/null || true
	$(QUIET)$(RM) ./**/.*~ 2>/dev/null || true
	$(QUIET)$(RMDIR) ./.tox/ 2>/dev/null || true

clean: cleanup
	$(QUIET)$(ECHO) "$@: Done."

must_be_root:
	$(QUIET)runner=`whoami` ; \
	if test $$runner != "root" ; then $(ECHO) "You are not root." ; exit 126 ; fi

%:
	$(QUIET)$(ECHO) "No Rule Found For $@" ;
	$(QUIET)$(WAIT) ;

endif
