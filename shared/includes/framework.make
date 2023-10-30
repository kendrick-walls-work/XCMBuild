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

.PHONY: all init test clean checkin

else

$(BUILD_ROOT)/$(CONFIGURATION)/%.framework/: checkin $(BUILD_ROOT)/$(CONFIGURATION)/
	$(QUIET)$(ECHO) "Create Target: $@" ;
	$(QUIET)$(MKDIR) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $(TARGET_TEMP_DIR) || DO_FAIL="exit 2" ;

$(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/: checkin |$(BUILD_ROOT)/$(CONFIGURATION)/%.framework/
	$(QUIET)$(MKDIR) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $(TARGET_TEMP_DIR) || DO_FAIL="exit 2" ;

$(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/$(FRAMEWORK_VERSION)/: checkin |$(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/
	$(QUIET)$(MKDIR) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) $@ 2>/dev/null || DO_FAIL="exit 2" ;

$(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/$(FRAMEWORK_VERSION)/XPCServices: checkin |$(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/$(FRAMEWORK_VERSION)/
	$(QUIET)$(ECHO) "Creating $@" ;
	$(QUIET)$(MKDIR) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) $@ 2>/dev/null || DO_FAIL="exit 2" ;

$(BUILD_ROOT)/$(CONFIGURATION)/%/Versions/Current: $(BUILD_ROOT)/$(CONFIGURATION)/%/Versions $(BUILD_ROOT)/$(CONFIGURATION)/%/Versions/$(FRAMEWORK_VERSION)/
	$(QUIET)$(ECHO) "Linking $@ ( Current for $(FRAMEWORK_VERSION) )" ;
	$(QUIET)$(LINK) $(FRAMEWORK_VERSION) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/Current/%: $(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/Current
	$(DO_FAIL) ;

$(BUILD_ROOT)/$(CONFIGURATION)/%/Versions/Current/Resources $(BUILD_ROOT)/$(CONFIGURATION)/%/Versions/Current/Modules $(BUILD_ROOT)/$(CONFIGURATION)/%/Versions/Current/Headers $(BUILD_ROOT)/$(CONFIGURATION)/%/Versions/Current/PrivateHeaders: $(BUILD_ROOT)/$(CONFIGURATION)/%/Versions/ $(BUILD_ROOT)/$(CONFIGURATION)/%/ $(BUILD_ROOT)/$(CONFIGURATION)/%/Versions/$(FRAMEWORK_VERSION)/ $(BUILD_ROOT)/$(CONFIGURATION)/%/Versions/Current
	$(DO_FAIL) ;

$(BUILD_ROOT)/$(CONFIGURATION)/%/Headers: $(BUILD_ROOT)/$(CONFIGURATION)/%/ $(BUILD_ROOT)/$(CONFIGURATION)/%/Versions/ $(BUILD_ROOT)/$(CONFIGURATION)/%/Versions/Current $(BUILD_ROOT)/$(CONFIGURATION)/%/Versions/Current/Headers
	$(QUIET)$(ECHO) "Linking $@" ;
	$(QUIET)$(LINK) Versions/Current/Headers $@ 2>/dev/null || DO_FAIL="exit 2" ;

$(BUILD_ROOT)/$(CONFIGURATION)/%/PrivateHeaders: $(BUILD_ROOT)/$(CONFIGURATION)/%/ $(BUILD_ROOT)/$(CONFIGURATION)/%/Versions/ $(BUILD_ROOT)/$(CONFIGURATION)/%/Headers $(BUILD_ROOT)/$(CONFIGURATION)/%/Versions/Current $(BUILD_ROOT)/$(CONFIGURATION)/%/Versions/Current/PrivateHeaders
	$(QUIET)$(ECHO) "Linking $@" ;
	$(QUIET)$(LINK) Versions/Current/PrivateHeaders $@ 2>/dev/null || DO_FAIL="exit 2" ;

$(BUILD_ROOT)/$(CONFIGURATION)/%/Modules: $(BUILD_ROOT)/$(CONFIGURATION)/%/ $(BUILD_ROOT)/$(CONFIGURATION)/%/Versions/ $(BUILD_ROOT)/$(CONFIGURATION)/%/Headers $(BUILD_ROOT)/$(CONFIGURATION)/%/Versions/Current $(BUILD_ROOT)/$(CONFIGURATION)/%/Versions/Current/Modules
	$(QUIET)$(ECHO) "Linking $@" ;
	$(QUIET)$(LINK) Versions/Current/Modules $@ 2>/dev/null || DO_FAIL="exit 2" ;

$(BUILD_ROOT)/$(CONFIGURATION)/%/XPCServices: $(BUILD_ROOT)/$(CONFIGURATION)/%/ $(BUILD_ROOT)/$(CONFIGURATION)/%/Versions/ $(BUILD_ROOT)/$(CONFIGURATION)/%/Versions/Current $(BUILD_ROOT)/$(CONFIGURATION)/%/Versions/Current/XPCServices
	$(QUIET)$(ECHO) "Linking $@" ;
	$(QUIET)$(LINK) Versions/Current/XPCServices $@ 2>/dev/null || DO_FAIL="exit 2" ;

$(BUILD_ROOT)/$(CONFIGURATION)/%/Resources: $(BUILD_ROOT)/$(CONFIGURATION)/%/ $(BUILD_ROOT)/$(CONFIGURATION)/%/Versions/ $(BUILD_ROOT)/$(CONFIGURATION)/%/Versions/Current $(BUILD_ROOT)/$(CONFIGURATION)/%/Versions/Current/Resources
	$(QUIET)$(ECHO) "Linking $@" ;
	$(QUIET)$(LINK) Versions/Current/Resources $@ 2>/dev/null || DO_FAIL="exit 2" ;

$(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/Current/%: $(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/$(FRAMEWORK_VERSION)/ $(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/$(FRAMEWORK_VERSION)/% $(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/Current
	$(DO_FAIL) ;

$(BUILD_ROOT)/$(CONFIGURATION)/%.framework/%: $(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/Current/% checkin $(BUILD_ROOT)/$(CONFIGURATION)/%.framework/ $(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/ $(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/$(FRAMEWORK_VERSION)/ $(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/Current
	$(QUIET)$(ECHO) "Linking $@" ;
	$(QUIET)$(LINK) Versions/Current/$(basename -s .framework $@) $@ 2>/dev/null || DO_FAIL="exit 2" ;

$(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/$(FRAMEWORK_VERSION)/Modules/module.modulemap: shared/Clang/module.modulemap $(BUILD_ROOT)/$(CONFIGURATION)/%.framework/ $(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/$(FRAMEWORK_VERSION)/Modules $(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Modules
	$(QUIET)$(INSTALL) $< $@ 2>/dev/null || true ;
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHMOD) $(INST_FILE_OPTS) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $(TARGET_TEMP_DIR) || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Mapped Framework Module ( $@ )" ;

$(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/$(FRAMEWORK_VERSION)/Modules/module.private.modulemap: shared/Clang/module.private.modulemap $(BUILD_ROOT)/$(CONFIGURATION)/%.framework/ $(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/$(FRAMEWORK_VERSION)/Modules $(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Modules $(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/$(FRAMEWORK_VERSION)/Modules/module.modulemap
	$(QUIET)$(INSTALL) $< $@ 2>/dev/null || true ;
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHMOD) $(INST_FILE_OPTS) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $(TARGET_TEMP_DIR) || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Mapped Framework Private Module ( $@ )" ;

$(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/$(FRAMEWORK_VERSION)/Modules: $(BUILD_ROOT)/$(CONFIGURATION)/%.framework/ $(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/ $(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/$(FRAMEWORK_VERSION)/
	$(QUIET)$(MKDIR) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $(TARGET_TEMP_DIR) || DO_FAIL="exit 2" ;

$(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/$(FRAMEWORK_VERSION)/usr/: checkin |$(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/$(FRAMEWORK_VERSION)/
	$(QUIET)$(MKDIR) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHMOD) $(INST_OPTS) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $(TARGET_TEMP_DIR) || DO_FAIL="exit 2" ;

$(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/$(FRAMEWORK_VERSION)/usr/bin: checkin |$(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/$(FRAMEWORK_VERSION)/usr/
	$(QUIET)$(WAIT) ;
	$(QUIET)$(MKDIR) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $(TARGET_TEMP_DIR) || DO_FAIL="exit 2" ;
	$(QUIET)$(WAIT) ;
	$(QUIET)$(ECHO) "$@: installed." ;

$(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/$(FRAMEWORK_VERSION)/usr/sbin: checkin |$(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/$(FRAMEWORK_VERSION)/usr/
	$(QUIET)$(WAIT) ;
	$(QUIET)$(MKDIR) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(WAIT) ;
	$(QUIET)$(ECHO) "$@: installed." ;

$(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/$(FRAMEWORK_VERSION)/%: $(UNINSTALLED_PRODUCTS_DIR)/%.dylib $(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/$(FRAMEWORK_VERSION)/ |XCMBuild-dynamic-library
	$(QUIET)$(CP) "$<" "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "$@: Done." ;

## %.framework/Versions/$(FRAMEWORK_VERSION)/%_debug: $(OBJECT_FILE_DIR)/build/Object-x86_64-debug/x86_64/Binary/%_debug $(OBJECT_FILE_DIR)/build/Object-arm64-debug/arm64/Binary/%_debug %.framework/Versions/$(FRAMEWORK_VERSION)/

uninstall-framework-%:: |$(BUILD_ROOT)/$(CONFIGURATION)/%.framework
	$(QUIET)$(RMDIR) $(BUILD_ROOT)/$(CONFIGURATION)/$%.framework 2>/dev/null || true ;
	$(QUIET)$(WAIT) ;
	$(QUIET)$(ECHO) "$%.framework: Removed. ( $@ )" ;

endif
