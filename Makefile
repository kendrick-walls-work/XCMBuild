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

ifeq "$(LC_CTYPE)" ""
	LC_CTYPE="en_US.UTF-8"
endif

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

ifeq "$(COMMAND)" ""
	COMMAND_CMD=`command -v xcrun || command which which || command -v which || command -v command`
	ifeq "$(COMMAND_CMD)" "*xcrun"
		COMMAND_ARGS=--find
	endif
	ifeq "$(COMMAND_CMD)" "*command"
		COMMAND_ARGS=-pv
	endif
	COMMAND=$(COMMAND_CMD) $(COMMAND_ARGS)
endif

ifeq "$(MAKE)" ""
	#  just no cmake please
	MAKE=$($(COMMAND) make || $(COMMAND) gnumake) -s -j1
endif

ifndef ECHO
LOG=no
T := $(shell $(MAKE) $(MAKECMDGOALS) --no-print-directory \
      -nrRf $(firstword $(MAKEFILE_LIST)) \
      ECHO="COUNTTHIS" | grep -cF "COUNTTHIS" 2>/dev/null)
N := x
C = $(words $N)$(eval N := x $N)
ECHO = echo -ne "\r [`expr $C '*' 100 / $T`%]"
endif

# end of CC-SA-v3 inpired content 21-61

ifdef "$(ACTION)"
	SET_FILE_ATTR=$(COMMAND) xattr
endif

ifdef "$(SET_FILE_ATTR)"
	CREATEDBYBUILDSYSTEM=-w com.apple.xcode.CreatedByBuildSystem true
	BSMARK=$(SET_FILE_ATTR) $(CREATEDBYBUILDSYSTEM)
else
	BSMARK=$(COMMAND) touch -a
endif

ifeq "$(ALFW)" ""
	ALFW=/usr/libexec/ApplicationFirewall/socketfilterfw
endif

ifeq "$(PFCTL)" ""
	PFCTL=$(COMMAND) pfctl
endif

ifeq "$(LINK)" ""
	LINK=$(COMMAND) ln -sf
endif

ifeq "$(GIT)" ""
	GIT=$(COMMAND) git
endif

ifeq "$(WAIT)" ""
	WAIT=wait
endif

ifeq "$(RM)" ""
	RM=$(COMMAND) rm -f
endif

ifeq "$(CHMOD)" ""
	CHMOD=$(COMMAND) chmod -v
endif

ifeq "$(CHOWN)" ""
	CHOWN=$(COMMAND) chown -v
endif

ifeq "$(CP)" ""
	CP=$(COMMAND) cp -n
endif

ifeq "$(MKDIR)" ""
	MKDIR=$(COMMAND) mkdir -m 0755
endif

ifeq "$(RMDIR)" ""
	RMDIR=$(RM)Rd
endif

ifeq "$(INSTALL)" ""
	INSTALL=$(COMMAND) install -M
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
	ifndef DO_FAIL
		DO_FAIL=$(COMMAND) :
	endif
else
	ifeq "$(DO_FAIL)" ""
		# any other log mode MAY CAUSE ISSUES with progress logic b/c extra echo in loop
		DO_FAIL=$(ECHO) "ok"
	endif
endif


.SUFFIXES: .zip .php .css .html .bash .sh .py .pyc .txt .js .plist .dmg

PHONY: must_be_root cleanup uninstall test all

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
	$(QUIET)$(ECHO) "$@: START." ;
	$(QUIET)$(WAIT) ;
	$(QUIET)$(GIT) ls-files ./tests/test_*sh -z 2>/dev/null | xargs -0 -L1 -I{} $(SHELL) -c "({} && echo '{}: Succeded') || echo '{}: FAILURE' >&2 ; " ;
	$(QUIET)$(WAIT) ;
	$(QUIET)$(ECHO) "$@: END." ;

test-tox: cleanup
	$(QUIET)$(ECHO) "$@: N/A."

test-style: cleanup
	$(QUIET)$(ECHO) "$@: N/A."

cleanup:
	$(QUIET)$(RM) tests/*~ 2>/dev/null || true
	$(QUIET)$(RM) ./.git/*~ 2>/dev/null || true
	$(QUIET)$(RM) ./.DS_Store 2>/dev/null || true
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
	$(QUIET)$(WAIT) ;
	$(QUIET)$(ECHO) "$@: Done." ;

must_be_root:
	$(QUIET)runner=`whoami` ; \
	if test $$runner != "root" ; then $(ECHO) "You are not root." ; exit 126 ; fi

%:
	$(QUIET)$(ECHO) "No Rule Found For $@" ;
	$(QUIET)$(WAIT) ;

endif
