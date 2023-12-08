#!/usr/bin/env make -f

# reactive-firewall/XCMBuild project Makefile
# ..................................
# Copyright (c) 2023, Mr. Walls
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

.PHONY: all init test clean

else

$(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/Current/usr/bin/xcrunshell: $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/Current
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/xcrunshell-Info.plist: shared/xcrunshell-Info.plist $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64
	$(QUIET)$(CLANG) -E -P -x c -Wno-trigraphs Resources/XCMBuild-Info.plist -F$(BUILD_ROOT)/$(CONFIGURATION) \
	-target x86_64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	-isysroot $(SDKROOT) \
	$(PLIST_ENV_DEF) \
	-DPRODUCT_IDENTIFIER\=org.pak.dt.XCMBuild.XCRunner \
	-o $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/xcrunshell-Info.plist.xml || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(FIX_INFO_PLIST) "$@.xml" >"$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(SYNC) ;
	$(QUIET)$(WAIT) ;
	$(QUIET)$(RM) $(WITH_FORCE) "$@.xml" 2>/dev/null || true ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "$@: Embeded." ;

$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/xcrunshell-Info.plist: shared/xcrunshell-Info.plist
	$(QUIET)$(CLANG) -E -P -x c -Wno-trigraphs shared/xcrunshell-Info.plist -F$(BUILD_ROOT)/$(CONFIGURATION) \
	-target arm64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	-isysroot $(SDKROOT) \
	$(PLIST_ENV_DEF) \
	-DPRODUCT_IDENTIFIER\=org.pak.dt.XCMBuild.XCRunner \
	-o $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/xcrunshell-Info.plist.xml || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(FIX_INFO_PLIST) "$@.xml" >"$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(SYNC) ;
	$(QUIET)$(WAIT) ;
	$(QUIET)$(RM) $(WITH_FORCE) "$@.xml" 2>/dev/null || true ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/xcrunshell-Info.plist: shared/xcrunshell-Info.plist
	$(QUIET)$(CLANG) -E -P -x c -Wno-trigraphs shared/xcrunshell-Info.plist -F$(BUILD_ROOT)/$(CONFIGURATION) \
	-target aarch64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	-isysroot $(SDKROOT) \
	$(PLIST_ENV_DEF) \
	-DPRODUCT_IDENTIFIER\=org.pak.dt.XCMBuild.XCRunner \
	-o $(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/xcrunshell-Info.plist.xml || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(FIX_INFO_PLIST) "$@.xml" >"$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(SYNC) ;
	$(QUIET)$(WAIT) ;
	$(QUIET)$(RM) $(WITH_FORCE) "$@.xml" 2>/dev/null || true ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/xcrunshell-Info.plist: shared/xcrunshell-Info.plist
	$(QUIET)$(CLANG) -E -P -x c -Wno-trigraphs shared/xcrunshell-Info.plist -F$(BUILD_ROOT)/$(CONFIGURATION) \
	-target x86_64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	-isysroot $(SDKROOT) \
	$(PLIST_ENV_DEF) \
	-DPRODUCT_IDENTIFIER\=org.pak.dt.XCMBuild.XCRunner \
	-o $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/xcrunshell-Info.plist.xml ;
	$(DO_FAIL) ;
	$(QUIET)$(FIX_INFO_PLIST) "$@.xml" >"$@" ;
	$(QUIET)$(SYNC) ;
	$(QUIET)$(WAIT) ;
	$(QUIET)$(RM) $(WITH_FORCE) "$@.xml" 2>/dev/null || true ;

$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/Binary/xcrunshell-Info.plist: shared/xcrunshell-Info.plist
	$(QUIET)$(CLANG) -E -P -x c -Wno-trigraphs shared/xcrunshell-Info.plist -F$(BUILD_ROOT)/$(CONFIGURATION) \
	-target arm64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	-isysroot $(SDKROOT) \
	$(PLIST_ENV_DEF) \
	-DPRODUCT_IDENTIFIER\=org.pak.dt.XCMBuild.XCRunner \
	-o $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/xcrunshell-Info.plist.xml ;
	$(DO_FAIL) ;
	$(QUIET)$(FIX_INFO_PLIST) "$@.xml" >"$@" ;
	$(QUIET)$(SYNC) ;
	$(QUIET)$(WAIT) ;
	$(QUIET)$(RM) $(WITH_FORCE) "$@.xml" 2>/dev/null || true ;

$(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/xcrunshell-Info.plist: shared/xcrunshell-Info.plist
	$(QUIET)$(CLANG) -E -P -x c -Wno-trigraphs shared/xcrunshell-Info.plist -F$(BUILD_ROOT)/$(CONFIGURATION) \
	-target aarch64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	-isysroot $(SDKROOT) \
	$(PLIST_ENV_DEF) \
	-DPRODUCT_IDENTIFIER\=org.pak.dt.XCMBuild.XCRunner \
	-o $(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/xcrunshell-Info.plist.xml ;
	$(DO_FAIL) ;
	$(QUIET)$(FIX_INFO_PLIST) "$@.xml" >"$@" ;
	$(QUIET)$(SYNC) ;
	$(QUIET)$(WAIT) ;
	$(QUIET)$(RM) $(WITH_FORCE) "$@.xml" 2>/dev/null || true ;

$(UNINSTALLED_PRODUCTS_DIR)/xcrunshell: $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/Binary/xcrunshell $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/Binary/xcrunshell $(UNINSTALLED_PRODUCTS_DIR) $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/Binary $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/Binary $(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/Binary $(PROJECT_TEMP_ROOT)/EagerLinkingTBDs/$(CONFIGURATION) $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/XCMBuild
	$(QUIET)$(LIPO) -create $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/Binary/xcrunshell \
	$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/Binary/xcrunshell -output $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(ECHO) "Combined universal $@." ;

$(UNINSTALLED_PRODUCTS_DIR)/xcrunshell_debug: $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/Binary/xcrunshell $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/Binary/xcrunshell $(UNINSTALLED_PRODUCTS_DIR) $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/Binary $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/Binary $(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/Binary $(PROJECT_TEMP_ROOT)/EagerLinkingTBDs/$(CONFIGURATION) $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/XCMBuild
	$(QUIET)$(LIPO) -create $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/Binary/xcrunshell \
	$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/Binary/xcrunshell -output $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(ECHO) "Combined universal $@. (DEBUG)" ;


$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/%.LinkFileList: $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/%/main.o $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/%_vers.o |$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64
	$(QUIET)$(ECHO) "Generating Linker Map ($@)" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s" '$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/' > "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(STEMNAME) "$@" >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" '_vers.o' >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s" '$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/' >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(STEMNAME) "$@" >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" '/main.o' >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/%.LinkFileList: $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/%/main.o $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/%_vers.o |$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64
	$(QUIET)$(ECHO) "Generating Linker Map ($@)" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s" '$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/' > "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(STEMNAME) "$@" >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" '_vers.o' >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s" '$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/' >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(STEMNAME) "$@" >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" '/main.o' >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/%.LinkFileList: $(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/%/main.o $(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/%_vers.o |$(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64
	$(QUIET)$(ECHO) "Generating Linker Map ($@)" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s" '$(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/' > "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(STEMNAME) "$@" >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" '_vers.o' >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s" '$(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/' >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(STEMNAME) "$@" >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" '/main.o' >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

#debug

$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/%.LinkFileList: $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/%/main.o $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/%_vers.o |$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64
	$(QUIET)$(ECHO) "Generating Linker Map ($@)" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s" '$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/' > "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(STEMNAME) "$@" >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" '_vers.o' >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s" '$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/' >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(STEMNAME) "$@" >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" '/main.o' >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/%.LinkFileList: $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/%/main.o $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/%_vers.o |$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64
	$(QUIET)$(ECHO) "Generating Linker Map ($@)" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s" '$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/' > "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(STEMNAME) "$@" >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" '_vers.o' >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s" '$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/' >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(STEMNAME) "$@" >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" '/main.o' >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/%.LinkFileList: $(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/%/main.o $(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/%_vers.o |$(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64
	$(QUIET)$(ECHO) "Generating Linker Map ($@)" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s" '$(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/' > "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(STEMNAME) "$@" >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" '_vers.o' >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s" '$(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/' >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(STEMNAME) "$@" >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" '/main.o' >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/xcrunshell: $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "XCRunner Object Sub-Directory Ready (x86_64)" ;

$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/xcrunshell: $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "XCRunner Object Sub-Directory Ready (arm64)" ;

$(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/xcrunshell: $(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "XCRunner Object Sub-Directory Ready (arch64)" ;

$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/xcrunshell: $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "XCRunner Object Sub-Directory Ready (x86_64 debug)" ;

$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/xcrunshell: $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "XCRunner Object Sub-Directory Ready (arm64 debug)" ;

$(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/xcrunshell: $(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "XCRunner Object Sub-Directory Ready (arch64 debug)" ;

$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/Binary/xcrunshell: $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/Binary $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Modules/module.private.modulemap $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/xcrunshell_vers.o $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/xcrunshell/main.o $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/xcrunshell.LinkFileList $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/xcrunshell-Info.plist |XCMBuild-dynamic-library XCMBuild-xcrunshell-headers
	$(QUIET)$(ECHO) "Combining objects into command line tool ($@)" || DO_FAIL="exit 2" ;
	$(QUIET)$(CLANG) -Xlinker -reproducible -target x86_64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) -Xlinker -execute \
	-isysroot $(SDKROOT) \
	-fbuild-session-file\=$(BUILD_ROOT)/xcrunshell_vers.c \
	-O0 -L$(PROJECT_TEMP_ROOT)/EagerLinkingTBDs/$(CONFIGURATION) -L$(SYMROOT) \
	-F$(SYMROOT) -L$(BUILD_ROOT)/$(CONFIGURATION) \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-F$(PROJECT_TEMP_ROOT)/EagerLinkingTBDs/$(CONFIGURATION) \
	-F$(BUILD_ROOT)/$(CONFIGURATION) \
	-F/$(DYLIB_INSTALL_NAME_BASE) -iframeworkwithsysroot /$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot /System/Library/Frameworks \
	-iframeworkwithsysroot /Library/Frameworks \
	-L/usr/lib -L/usr/lib/System \
	-filelist "$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/xcrunshell.LinkFileList" \
	-Xlinker -no_exported_symbols -Xlinker -rpath -Xlinker /$(DYLIB_INSTALL_NAME_BASE)/\*\* \
	-Xlinker -rpath -Xlinker @executable_path/../Frameworks \
	-Xlinker -rpath -Xlinker @executable_path/../../../Current -Xlinker -rpath \
	-Xlinker @loader_path/Frameworks -Xlinker -rpath \
	-Xlinker @executable_path/../../Library/Frameworks/XCMBuild.framework \
	-Xlinker -rpath -Xlinker @executable_path/../lib -Xlinker -rpath \
	-Xlinker @loader_path/../Frameworks -Xlinker -rpath -Xlinker @loader_path/../lib \
	-Xlinker -order_file -Xlinker $(TARGET_TEMP_DIR)/build/XCMBuild-order-normal.txt \
	-Xlinker --no-demangle -Xlinker -no_deduplicate -dead_strip \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
	-fobjc-link-runtime -flto\=thin -gmodules -Xlinker -export_dynamic \
	-Xlinker -weak_reference_mismatches -Xlinker weak \
	-Xlinker -keep_private_externs \
	-Xlinker -object_path_lto -Xlinker $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/xcrunshell/xcrunshell/lto.o \
	-Xlinker -cache_path_lto -Xlinker $(TARGET_TEMP_DIR)/LTOCache/ \
	-Xlinker -final_output -Xlinker /$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/usr/bin/xcrunshell \
	-ObjC -weak_framework Foundation,framework -framework XCMBuild,framework -weak-lobjc -weak_framework CoreFoundation,framework \
	-weak-lc -weak-lSystem -weak-lsandbox -Xlinker -no_adhoc_codesign \
	-sectcreate __TEXT __info_plist $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/xcrunshell-Info.plist \
	-o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;


$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/Binary/xcrunshell: $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/Binary $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Modules/module.private.modulemap $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/xcrunshell_vers.o $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/xcrunshell/main.o $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/xcrunshell.LinkFileList $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/xcrunshell-Info.plist |XCMBuild-dynamic-library XCMBuild-xcrunshell-headers
	$(QUIET)$(ECHO) "Combining objects into command line tool ($@)" || DO_FAIL="exit 2" ;
	$(QUIET)$(CLANG) -Xlinker -reproducible -target arm64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) -Xlinker -execute \
	-isysroot $(SDKROOT) \
	-fbuild-session-file\=$(BUILD_ROOT)/xcrunshell_vers.c \
	-O0 -L$(PROJECT_TEMP_ROOT)/EagerLinkingTBDs/$(CONFIGURATION) -L$(SYMROOT) \
	-F$(SYMROOT) -L$(BUILD_ROOT)/$(CONFIGURATION) \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-F$(PROJECT_TEMP_ROOT)/EagerLinkingTBDs/$(CONFIGURATION) \
	-F$(BUILD_ROOT)/$(CONFIGURATION) \
	-F/$(DYLIB_INSTALL_NAME_BASE) -iframeworkwithsysroot /$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot /System/Library/Frameworks \
	-iframeworkwithsysroot /Library/Frameworks \
	-L/usr/lib -L/usr/lib/System \
	-filelist "$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/xcrunshell.LinkFileList" \
	-Xlinker -no_exported_symbols -Xlinker -rpath -Xlinker /$(DYLIB_INSTALL_NAME_BASE)/\*\* \
	-Xlinker -rpath -Xlinker @executable_path/../Frameworks \
	-Xlinker -rpath -Xlinker @executable_path/../../../Current -Xlinker -rpath \
	-Xlinker @loader_path/Frameworks -Xlinker -rpath \
	-Xlinker @executable_path/../../Library/Frameworks/XCMBuild.framework \
	-Xlinker -rpath -Xlinker @executable_path/../lib -Xlinker -rpath \
	-Xlinker @loader_path/../Frameworks -Xlinker -rpath -Xlinker @loader_path/../lib \
	-Xlinker -order_file -Xlinker $(TARGET_TEMP_DIR)/build/XCMBuild-order-normal.txt \
	-Xlinker --no-demangle -Xlinker -no_deduplicate -dead_strip \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
	-fobjc-link-runtime -flto\=thin -gmodules -Xlinker -export_dynamic \
	-Xlinker -weak_reference_mismatches -Xlinker weak \
	-Xlinker -keep_private_externs \
	-Xlinker -object_path_lto -Xlinker $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/xcrunshell/xcrunshell/lto.o \
	-Xlinker -cache_path_lto -Xlinker $(TARGET_TEMP_DIR)/LTOCache/ \
	-Xlinker -final_output -Xlinker /$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/usr/bin/xcrunshell \
	-ObjC -weak_framework Foundation,framework -framework XCMBuild,framework -weak-lobjc -weak_framework CoreFoundation,framework \
	-weak-lc -weak-lSystem -weak-lsandbox -Xlinker -no_adhoc_codesign \
	-sectcreate __TEXT __info_plist $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/xcrunshell-Info.plist \
	-o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/Binary/xcrunshell: $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/Binary $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Modules/module.private.modulemap $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/xcrunshell_vers.o $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/xcrunshell/main.o $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/xcrunshell.LinkFileList $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/xcrunshell-Info.plist |XCMBuild-dynamic-library XCMBuild-xcrunshell-headers
	$(QUIET)$(ECHO) "Combining objects into command line Debug tool ($@)" || DO_FAIL="exit 2" ;
	$(QUIET)$(CLANG) -Xlinker -reproducible -target x86_64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) -Xlinker -execute \
	-isysroot $(SDKROOT) \
	-fbuild-session-file\=$(BUILD_ROOT)/xcrunshell_vers.c \
	-O0 -L$(PROJECT_TEMP_ROOT)/EagerLinkingTBDs/$(CONFIGURATION) -L$(SYMROOT) \
	-F$(SYMROOT) -L$(BUILD_ROOT)/$(CONFIGURATION) \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-F$(PROJECT_TEMP_ROOT)/EagerLinkingTBDs/$(CONFIGURATION) \
	-F$(BUILD_ROOT)/$(CONFIGURATION) \
	-F/$(DYLIB_INSTALL_NAME_BASE) -iframeworkwithsysroot /$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot /System/Library/Frameworks \
	-iframeworkwithsysroot /Library/Frameworks \
	-L/usr/lib -L/usr/lib/System \
	-filelist "$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/xcrunshell.LinkFileList" \
	-Xlinker -no_exported_symbols -Xlinker -rpath -Xlinker /$(DYLIB_INSTALL_NAME_BASE)/\*\* \
	-Xlinker -rpath -Xlinker @executable_path/../Frameworks \
	-Xlinker -rpath -Xlinker @executable_path/../../../Current -Xlinker -rpath \
	-Xlinker @loader_path/Frameworks -Xlinker -rpath \
	-Xlinker @executable_path/../../Library/Frameworks/XCMBuild.framework \
	-Xlinker -rpath -Xlinker @executable_path/../lib -Xlinker -rpath \
	-Xlinker @loader_path/../Frameworks -Xlinker -rpath -Xlinker @loader_path/../lib \
	-Xlinker -order_file -Xlinker $(TARGET_TEMP_DIR)/build/XCMBuild-order-debug.txt \
	-Xlinker -no_order_inits -Xlinker -debug_variant \
	-Xlinker --no-demangle -Xlinker -no_deduplicate -dead_strip \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
	-fobjc-link-runtime -flto\=thin -gmodules -greproducible -Xlinker -export_dynamic \
	-Xlinker -weak_reference_mismatches -Xlinker weak \
	-Xlinker -keep_private_externs \
	-Xlinker -object_path_lto -Xlinker $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/xcrunshell/xcrunshell/lto.o \
	-Xlinker -cache_path_lto -Xlinker $(TARGET_TEMP_DIR)/LTOCache/ \
	-Xlinker -final_output -Xlinker /$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/usr/bin/xcrunshell \
	-ObjC -weak_framework Foundation,framework -framework XCMBuild,framework -weak-lobjc -weak_framework CoreFoundation,framework \
	-weak-lc -weak-lSystem -weak-lsandbox -Xlinker -no_adhoc_codesign \
	-sectcreate __TEXT __info_plist $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/xcrunshell-Info.plist \
	-o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;


$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/Binary/xcrunshell: $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/Binary $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Modules/module.private.modulemap $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/xcrunshell_vers.o $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/xcrunshell/main.o $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/xcrunshell.LinkFileList $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/xcrunshell-Info.plist |XCMBuild-dynamic-library XCMBuild-xcrunshell-headers
	$(QUIET)$(ECHO) "Combining objects into command line Debug tool ($@)" || DO_FAIL="exit 2" ;
	$(QUIET)$(CLANG) -Xlinker -reproducible -target arm64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) -Xlinker -execute \
	-isysroot $(SDKROOT) \
	-fbuild-session-file\=$(BUILD_ROOT)/xcrunshell_vers.c \
	-O0 -L$(PROJECT_TEMP_ROOT)/EagerLinkingTBDs/$(CONFIGURATION) -L$(SYMROOT) \
	-F$(SYMROOT) -L$(BUILD_ROOT)/$(CONFIGURATION) \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-F$(PROJECT_TEMP_ROOT)/EagerLinkingTBDs/$(CONFIGURATION) \
	-F$(BUILD_ROOT)/$(CONFIGURATION) \
	-F/$(DYLIB_INSTALL_NAME_BASE) -iframeworkwithsysroot /$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot /System/Library/Frameworks \
	-iframeworkwithsysroot /Library/Frameworks \
	-L/usr/lib -L/usr/lib/System \
	-filelist "$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/xcrunshell.LinkFileList" \
	-Xlinker -no_exported_symbols -Xlinker -rpath -Xlinker $(DYLIB_INSTALL_NAME_BASE)/\*\* \
	-Xlinker -rpath -Xlinker @executable_path/../Frameworks \
	-Xlinker -rpath -Xlinker @executable_path/../../../Current -Xlinker -rpath \
	-Xlinker @loader_path/Frameworks -Xlinker -rpath \
	-Xlinker @executable_path/../../Library/Frameworks/XCMBuild.framework \
	-Xlinker -rpath -Xlinker @executable_path/../lib -Xlinker -rpath \
	-Xlinker @loader_path/../Frameworks -Xlinker -rpath -Xlinker @loader_path/../lib \
	-Xlinker -order_file -Xlinker $(TARGET_TEMP_DIR)/build/XCMBuild-order-debug.txt \
	-Xlinker -no_order_inits -Xlinker -debug_variant \
	-Xlinker --no-demangle -Xlinker -no_deduplicate -dead_strip \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
	-fobjc-link-runtime -flto\=thin -gmodules -greproducible -Xlinker -Xlinker -export_dynamic \
	-Xlinker -weak_reference_mismatches -Xlinker weak \
	-Xlinker -keep_private_externs \
	-Xlinker -object_path_lto -Xlinker $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/xcrunshell/xcrunshell/lto.o \
	-Xlinker -cache_path_lto -Xlinker $(TARGET_TEMP_DIR)/LTOCache/ \
	-Xlinker -final_output -Xlinker /$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/usr/bin/xcrunshell \
	-ObjC -weak_framework Foundation,framework -framework XCMBuild,framework -weak-lobjc -weak_framework CoreFoundation,framework \
	-weak-lc -weak-lSystem -weak-lsandbox -Xlinker -no_adhoc_codesign \
	-sectcreate __TEXT __info_plist $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/xcrunshell-Info.plist \
	-o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/xcrunshell-order-normal.txt:: shared/Clang/XCRS-orderfile |$(TARGET_TEMP_DIR)/build/
	$(QUIET)$(CP) "$<" "$@" 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/xcrunshell-order-debug.txt:: shared/Clang/XCRS-orderfile-dbg |$(TARGET_TEMP_DIR)/build/
	$(QUIET)$(CP) "$<" "$@" 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/usr/bin/xcrunshell: $(UNINSTALLED_PRODUCTS_DIR)/xcrunshell $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/usr/bin $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/usr XCMBuild-xcrunshell-headers
	$(QUIET)$(CP) "$<" "$@" 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(UNMARK) $@ || DO_FAIL="exit 2" ;
	$(QUIET)codesign --force -vvvv --sign ${CODE_SIGN_IDENTITY} --prefix=org.pak.dt. --entitlements shared/security/entitlements/xcrunshell.entitlements --identifier=org.pak.dt.XCMBuild.XCRunner -o hard,linker-signed,runtime --timestamp=none --generate-entitlement-der "$@" ;
	$(QUIET)codesign --force -vvvv --sign ${CODE_SIGN_IDENTITY} --bundle-version $(FRAMEWORK_VERSION) --prefix=org.pak.dt. --identifier=org.pak.dt.XCMBuild --preserve-metadata=identifier,requirements,entitlements,flags -o linker-signed,hard --timestamp=none --generate-entitlement-der $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Built with XCRunSHell-$(FRAMEWORK_VERSION)." ;

$(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/usr/bin/xcrunshell_debug: $(UNINSTALLED_PRODUCTS_DIR)/xcrunshell $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/usr/bin $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/usr XCMBuild-xcrunshell-headers
	$(QUIET)$(CP) "$<" "$@" 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(UNMARK) $@ || DO_FAIL="exit 2" ;
	$(QUIET)codesign --force -vvvv --sign ${CODE_SIGN_IDENTITY} --prefix=group.org.pak.dt. --entitlements shared/security/entitlements/xcrunshell.entitlements --identifier=org.pak.dt.XCMBuild.XCRunner.Debug -o linker-signed --timestamp=none --generate-entitlement-der "$@" ;
	$(QUIET)codesign --force -vvvv --sign ${CODE_SIGN_IDENTITY} --bundle-version $(FRAMEWORK_VERSION) --prefix=org.pak.dt. --identifier=org.pak.dt.XCMBuild --preserve-metadata=identifier,requirements,entitlements,flags -o linker-signed,hard --timestamp=none --generate-entitlement-der $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Built with XCRunSHell-$(FRAMEWORK_VERSION). (DEBUG)" ;

$(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/usr/bin/%: $(UNINSTALLED_PRODUCTS_DIR)/% $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/usr/bin $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/usr
	$(QUIET)$(CP) "$<" "$@" 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(UNMARK) $@ || DO_FAIL="exit 2" ;
	$(QUIET)codesign --force -vvvv --sign ${CODE_SIGN_IDENTITY} --prefix=org.pak.dt. --identifier=org.pak.dt.XCMBuild.$% --preserve-metadata=identifier,requirements,entitlements,flags -o linker-signed,hard,runtime --timestamp=none --generate-entitlement-der "$@" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Built with $@." ;

$(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/usr/bin/%: $(TARGET_TEMP_DIR)/build/bin/% $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/usr/bin $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/usr
	$(QUIET)$(CP) "$<" "$@" 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(UNMARK) "$@" || DO_FAIL="exit 2" ;
	$(QUIET)codesign --force -vvvv --sign ${CODE_SIGN_IDENTITY} --prefix=org.pak.dt. --identifier=org.pak.dt.XCMBuild.shell.$% --preserve-metadata=identifier,requirements,entitlements,flags -o linker-signed,hard,runtime --timestamp=none --generate-entitlement-der "$@" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Copied $< into bundle." ;

with-shell-tools: with-shlibs with-runtool with-prunefile with-clonefile with-setIcon with-snooze
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Embeded shell tools into bundle." ;

with-shlibs: with-bin-tool-serialized with-bin-tool-flatten $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/usr/bin/tool_shlock_helper.bash
	$(DO_FAIL) ;

with-prunefile: with-shlibs with-bin-tool-prunefile
	$(DO_FAIL) ;

with-setIcon: with-shlibs with-bin-tool-setIcon
	$(DO_FAIL) ;

with-snooze: with-shlibs with-bin-tool-snooze
	$(DO_FAIL) ;

with-clonefile: with-shlibs with-bin-tool-for-xcode-clonefile with-bin-tool-clonefile
	$(DO_FAIL) ;

with-runtool: with-shlibs with-bin-tool-for-xcode-run_tool with-bin-tool-for-posix-run_tool
	$(DO_FAIL) ;

with-bin-tool-for-posix-%: $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/usr/bin/posix_%
	$(DO_FAIL) ;

with-bin-tool-for-xcode-%: $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/usr/bin/xcode_%.bash
	$(DO_FAIL) ;

with-bin-tool-%: $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/usr/bin/%
	$(DO_FAIL) ;

xcrunshell-cli:: dist/Library/Frameworks XCMBuild-framework XCMBuild-xcrunshell-headers $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/usr/bin/xcrunshell $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/usr/bin/xcrunshell_debug

endif
