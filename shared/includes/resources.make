#!/usr/bin/env make -f

# reactive-firewall/XCMBuild Repo Makefile
# ..................................
# Copyright (c) 2018-2024, Mr. Walls
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

.PHONY: all init test clean uninstall-resources

else

$(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Resources/: Resources/ |$(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/
	$(QUIET)$(WAIT) ;
	$(QUIET)$(MKDIR) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(WAIT) ;
	$(DO_FAIL) ;

$(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Resources/%.lproj: Resources/%.lproj $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Resources/
	$(QUIET)$(MKDIR) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(WAIT) ;
	$(QUIET)$(ECHO) "$@: Localized." ;

$(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Resources/Info.plist: $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/Binary/Preprocessed-Info.plist
	$(QUIET)$(CP) "$<" "$@" 2>/dev/null || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "$@: Embeded." ;

$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/Binary/Preprocessed-Info.plist: Resources/XCMBuild-Info.plist $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/Binary/
	$(QUIET)$(CLANG) -E -P -x c -Wno-trigraphs Resources/XCMBuild-Info.plist -F$(BUILD_ROOT)/$(CONFIGURATION) \
	-target x86_64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	-isysroot $(SDKROOT) \
	$(PLIST_ENV_DEF) \
	-DPRODUCT_IDENTIFIER\=org.pak.dt.XCMBuild \
	-o $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/Binary/Preprocessed-Info.plist.xml || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(FIX_INFO_PLIST) "$@.xml" >"$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(SYNC) ;
	$(QUIET)$(WAIT) ;
	$(QUIET)$(RM) $(WITH_FORCE) "$@.xml" 2>/dev/null || true ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "$@: Embeded." ;

$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/Binary/Preprocessed-Info.plist: Resources/XCMBuild-Info.plist
	$(QUIET)$(CLANG) -E -P -x c -Wno-trigraphs Resources/XCMBuild-Info.plist -F$(BUILD_ROOT)/$(CONFIGURATION) \
	-target arm64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	-isysroot $(SDKROOT) \
	$(PLIST_ENV_DEF) \
	-DPRODUCT_IDENTIFIER\=org.pak.dt.XCMBuild \
	-o $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/Binary/Preprocessed-Info.plist.xml || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(FIX_INFO_PLIST) "$@.xml" >"$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(SYNC) ;
	$(QUIET)$(WAIT) ;
	$(QUIET)$(RM) $(WITH_FORCE) "$@.xml" 2>/dev/null || true ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/Binary/Preprocessed-Info.plist: Resources/XCMBuild-Info.plist
	$(QUIET)$(CLANG) -E -P -x c -Wno-trigraphs Resources/XCMBuild-Info.plist -F$(BUILD_ROOT)/$(CONFIGURATION) \
	-target aarch64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	-isysroot $(SDKROOT) \
	$(PLIST_ENV_DEF) \
	-DPRODUCT_IDENTIFIER\=org.pak.dt.XCMBuild \
	-o $(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/Binary/Preprocessed-Info.plist.xml || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(FIX_INFO_PLIST) "$@.xml" >"$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(SYNC) ;
	$(QUIET)$(WAIT) ;
	$(QUIET)$(RM) $(WITH_FORCE) "$@.xml" 2>/dev/null || true ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/Binary/Preprocessed-Info.plist: Resources/XCMBuild-Info.plist
	$(QUIET)$(CLANG) -E -P -x c -Wno-trigraphs Resources/XCMBuild-Info.plist -F$(BUILD_ROOT)/$(CONFIGURATION) \
	-target x86_64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	-isysroot $(SDKROOT) \
	$(PLIST_ENV_DEF) \
	-DPRODUCT_IDENTIFIER\=org.adhoc.dt.XCMBuild \
	-o $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/Binary/Preprocessed-Info.plist.xml ;
	$(QUIET)$(FIX_INFO_PLIST) "$@.xml" >"$@" ;
	$(QUIET)$(SYNC) ;
	$(QUIET)$(WAIT) ;
	$(QUIET)$(RM) $(WITH_FORCE) "$@.xml" 2>/dev/null || true ;

$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/Binary/Preprocessed-Info.plist: Resources/XCMBuild-Info.plist
	$(QUIET)$(CLANG) -E -P -x c -Wno-trigraphs Resources/XCMBuild-Info.plist -F$(BUILD_ROOT)/$(CONFIGURATION) \
	-target arm64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	-isysroot $(SDKROOT) \
	$(PLIST_ENV_DEF) \
	-DPRODUCT_IDENTIFIER\=org.adhoc.dt.XCMBuild \
	-o $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/Binary/Preprocessed-Info.plist.xml ;
	$(QUIET)$(FIX_INFO_PLIST) "$@.xml" >"$@" ;
	$(QUIET)$(SYNC) ;
	$(QUIET)$(WAIT) ;
	$(QUIET)$(RM) $(WITH_FORCE) "$@.xml" 2>/dev/null || true ;

$(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/Binary/Preprocessed-Info.plist: Resources/XCMBuild-Info.plist
	$(QUIET)$(CLANG) -E -P -x c -Wno-trigraphs Resources/XCMBuild-Info.plist -F$(BUILD_ROOT)/$(CONFIGURATION) \
	-target aarch64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	-isysroot $(SDKROOT) \
	$(PLIST_ENV_DEF) \
	-DPRODUCT_IDENTIFIER\=org.adhoc.dt.XCMBuild \
	-o $(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/Binary/Preprocessed-Info.plist.xml ;
	$(QUIET)$(FIX_INFO_PLIST) "$@.xml" >"$@" ;
	$(QUIET)$(SYNC) ;
	$(QUIET)$(WAIT) ;
	$(QUIET)$(RM) $(WITH_FORCE) "$@.xml" 2>/dev/null || true ;


#$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/Binary/Preprocessed-Info.plist $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/Binary/Preprocessed-Info.plist $(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/Binary/Preprocessed-Info.plist: Resources/XCMBuild-Info.plist $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/Binary/Preprocessed-Info.plist: Resources/XCMBuild-Info.plist $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/Binary/Preprocessed-Info.plist $(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/Binary/Preprocessed-Info.plist

$(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Resources/%: Resources/% $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Resources/
	$(QUIET)$(CP) $< $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "$<: Embeded." ;

$(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Resources/%: REZ-Base-% REZ-English-%
	$(DO_FAIL) ;

REZ-Base-%: $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Resources/Base.lproj/%
	$(DO_FAIL) ;

REZ-English-%: $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Resources/en.lproj/%
	$(DO_FAIL) ;

$(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Resources/Base.lproj/%: Resources/Base.lproj/% $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Resources/Base.lproj
	$(QUIET)$(CP) $< $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "$<: Embeded." ;

$(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Resources/en.lproj/%: Resources/en.lproj/% $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Resources/en.lproj
	$(QUIET)$(CP) $< $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "$<: Localized (for English)." ;

uninstall-resources:
	$(QUIET)$(RMDIR) $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Resources/ 2>/dev/null || true ;
	$(QUIET)$(WAIT) ;
	$(QUIET)$(ECHO) "$@: Removed Resources." ;

endif
