#!/usr/bin/env make -f

# reactive-firewall/XCMBuild Repo Makefile
# ..................................
# Copyright (c) 2018-2023, Mr. Walls
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


# > Tip before calling this file or its rules be sure to set the working directory correctly.

ifndef BUILD_ROOT

.PHONY: all init test clean XCMBuild-public-headers XCMBuild-private-headers XCMBuild-all-headers

else

$(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/$(FRAMEWORK_VERSION)/Headers: $(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/$(FRAMEWORK_VERSION)/
	$(QUIET)$(MKDIR) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHMOD) $(INST_OPTS) $@ 2>/dev/null || DO_FAIL="exit 2" ;

$(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/$(FRAMEWORK_VERSION)/PrivateHeaders: $(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/$(FRAMEWORK_VERSION)/ |$(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/$(FRAMEWORK_VERSION)/Headers
	$(QUIET)$(MKDIR) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHMOD) $(INST_OPTS) $@ 2>/dev/null || DO_FAIL="exit 2" ;

$(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Headers/%.h: XCMBuild/xcrunshell/%.h |$(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Headers
	$(QUIET)$(TEST) -f "$<" || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(CP) "$<" "$@" || DO_FAIL="exit 2" ; ## BUG IS HERE
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "$< Injected." ;

$(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Headers/%.h: XCMBuild/XCMTest/%.h |$(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Headers
	$(QUIET)$(TEST) -f "$<" || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(CP) "$<" "$@" || DO_FAIL="exit 2" ; ## BUG IS HERE
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "$< Injected." ;

$(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/PrivateHeaders/%.h: XCMBuild/xcrunshell/%.h |$(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/PrivateHeaders $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Headers $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/PrivateHeaders
	$(QUIET)$(TEST) -f "$<" || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(CP) "$<" "$@" || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "$< Injected." ;

$(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/PrivateHeaders/%.h: XCMBuild/XCMTest/%.h |$(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/PrivateHeaders $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Headers $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/PrivateHeaders
	$(QUIET)$(TEST) -f "$<" || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(CP) "$<" "$@" || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "$< Injected." ;

$(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Headers/%.h: XCMBuild/%.h $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Headers
	$(QUIET)$(TEST) -f "$<" || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(CP) "$<" "$@" 2>/dev/null || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "$< Embeded." ;

XCMBuild-all-headers:: $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Headers $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Headers XCMBuild-public-headers XCMBuild-private-headers
	$(DO_FAIL) ;

XCMBuild-public-headers:: XCMBuild-XCMShell-headers XCMBuild-System-headers |$(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Headers
	$(DO_FAIL) ;

XCMBuild-private-headers:: $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/PrivateHeaders XCMBuild-public-headers XCMBuild-XCMTest-headers XCMBuild-xcrunshell-headers
	$(DO_FAIL) ;

XCMBuild-System-headers: $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Headers/XCMBuild.h $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Headers/Compat.h $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Headers/XCMBuildSystem.h |$(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Headers
	$(DO_FAIL) ;

# this should be based on the modulemap file instead
XCMBuild-XCMShell-headers: $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Headers/XCMShellDelegate.h $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Headers/XCMShell.h $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Headers/XCMProcesses.h |XCMBuild-System-headers
	$(DO_FAIL) ;

XCMBuild-XCMTest-headers: $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Headers/XCMTest.h |XCMBuild-System-headers
	$(DO_FAIL) ;

XCMBuild-xcrunshell-headers: $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/PrivateHeaders/xcrunshell.h |$(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/PrivateHeaders XCMBuild-XCMShell-headers
	$(DO_FAIL) ;

XCMBuild/XCMTest/: |init-start
	$(QUIET)$(TEST) -d $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "$@: Available." ;

XCMBuild/xcrunshell/: |init-start
	$(QUIET)$(TEST) -d $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "$@: Available." ;

XCMBuild/%/%.h: XCMBuild/%/ |init-start
	$(QUIET)$(TEST) -d $< || DO_FAIL="exit 2" ;
	$(QUIET)$(ECHO) "Checking ... $<" ;
	$(QUIET)$(TEST) -f $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "$@: Found." ;

XCMBuild/%.h: |init-start
	$(QUIET)$(TEST) -f "$@" || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "$@: Found." ;

endif