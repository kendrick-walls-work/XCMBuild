`#'!/usr/bin/env make -f

`#' reactive-firewall/XCMBuild project Makefile
`#' ..................................
`#' Copyright (c) 2023-2024, Mr. Walls
`#' ..................................
`#' Licensed under APACHE-2 (the "License");
`#' you may not use this file except in compliance with the License.
`#' You may obtain a copy of the License at
`#' ..........................................
`#' http://www.apache.org/licenses/LICENSE-2.0
`#' ..........................................
`#' Unless required by applicable law or agreed to in writing, software
`#' distributed under the License is distributed on an "AS IS" BASIS,
`#' WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
`#' See the License for the specific language governing permissions and
`#' limitations under the License.


`#' > Tip before calling this file or its rules be sure to set the working directory correctly.

`ifndef' BUILD_ROOT

`.PHONY: all init test clean'

else

`$(BUILD_ROOT)/XCM'STUBNAME()`_vers.c: |build'
`	$(QUIET)$(ECHO) "Generating Version Source: $@ ( XCM'STUBNAME()` )" ;'
`	$(QUIET)$(XCMB_GEN_VER_SRC_BUILD_TOOL) XCM'STUBNAME()` $(CURRENT_PROJECT_VERSION) >"$@" || DO_FAIL="exit 2" ;'
	$(QUIET)$(WAIT) ;
	$(DO_FAIL) ;

`$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCM'STUBNAME()`/main.o: XCMBuild/XCM'STUBNAME()`/main.m XCMBuild/XCM'STUBNAME()`/XCM'STUBNAME()`.h $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCM'STUBNAME()`_vers.o |$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCM'STUBNAME()`'
`	$(QUIET)$(ECHO) "Compile XCM'STUBNAME()`: $@ (x86_64)" ;'
	$(QUIET)$(CLANG) -x objective-c -target x86_64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit\=0 \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
`	-fbuild-session-file\=$(BUILD_ROOT)/XCM'STUBNAME()`_vers.c \'
	-fmodules -gmodules \
	-mincremental-linker-compatible \
	-O0 -flto\=thin -fno-common -isysroot $(SDKROOT) $(CCFLAGS_DARWIN) \
`	-I$(PROJECT_ROOT)/XCMBuild/XCM'STUBNAME()` -I$(PROJECT_ROOT)/XCMBuild \'
`	-I$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCM'STUBNAME()` \'
	-F/$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot $(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot usr/lib \
	-iframeworkwithsysroot usr/lib/System \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
`	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCM'STUBNAME()`.d \'
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

`$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCM'STUBNAME()`_vers.o:: $(BUILD_ROOT)/XCM'STUBNAME()`_vers.c $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64 |build'
	$(QUIET)$(ECHO) "Compile Version Header: $@ (x86_64)" ;
	$(QUIET)$(CLANG) -target x86_64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit\=0 \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
`	-fbuild-session-file\=$(BUILD_ROOT)/XCM'STUBNAME()`_vers.c \'
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
`	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCM'STUBNAME()`_vers.d \'
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

`$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCM'STUBNAME()`/main.o: XCMBuild/XCM'STUBNAME()`/main.m XCMBuild/XCM'STUBNAME()`/XCM'STUBNAME()`.h $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCM'STUBNAME()`_vers.o |$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCM'STUBNAME()`'
`	$(QUIET)$(ECHO) "Compile XCM'STUBNAME()`: $@ (arm64)" ;'
	$(QUIET)$(CLANG) -x objective-c -target arm64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit\=0 \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
`	-fbuild-session-file\=$(BUILD_ROOT)/XCM'STUBNAME()`_vers.c \'
	-fmodules -gmodules \
	-mincremental-linker-compatible \
	-O0 -flto\=thin -fno-common -isysroot $(SDKROOT) $(CCFLAGS_DARWIN) \
`	-I$(PROJECT_ROOT)/XCMBuild/XCM'STUBNAME()` -I$(PROJECT_ROOT)/XCMBuild \'
`	-I$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCM'STUBNAME()` \'
	-F/$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot $(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot usr/lib \
	-iframeworkwithsysroot usr/lib/System \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
`	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCM'STUBNAME()`.d \'
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

`$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCM'STUBNAME()`_vers.o:: $(BUILD_ROOT)/XCM'STUBNAME()`_vers.c $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64 |build'
	$(QUIET)$(ECHO) "Compile Version Header: $@ (arm64)" ;
	$(QUIET)$(CLANG) -target arm64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit\=0 \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
`	-fbuild-session-file\=$(BUILD_ROOT)/XCM'STUBNAME()`_vers.c \'
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
`	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCM'STUBNAME()`_vers.d \'
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

`$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCM'STUBNAME()`/main.o: XCMBuild/XCM'STUBNAME()`/main.m XCMBuild/XCM'STUBNAME()`/XCM'STUBNAME()`.h $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCM'STUBNAME()`_vers.o |$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCM'STUBNAME()`'
`	$(QUIET)$(ECHO) "Compile XCM'STUBNAME()`: $@ (x86_64)" ;'
	$(QUIET)$(CLANG) -x objective-c -target x86_64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit\=0 \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
`	-fbuild-session-file\=$(BUILD_ROOT)/XCM'STUBNAME()`_vers.c \'
	-fmodules -gmodules -greproducible \
	-mincremental-linker-compatible \
	-Xpreprocessor -DDEBUG\=1 \
	-O0 -flto\=thin -fno-common -isysroot $(SDKROOT) $(CCFLAGS_DARWIN) \
`	-I$(PROJECT_ROOT)/XCMBuild/XCM'STUBNAME()` -I$(PROJECT_ROOT)/XCMBuild \'
`	-I$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCM'STUBNAME()` \'
	-F/$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot $(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot usr/lib \
	-iframeworkwithsysroot usr/lib/System \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
`	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCM'STUBNAME()`.d \'
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

`$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCM'STUBNAME()`_vers.o:: $(BUILD_ROOT)/XCM'STUBNAME()`_vers.c $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64 |build'
	$(QUIET)$(ECHO) "Compile Version Header: $@ (x86_64)" ;
	$(QUIET)$(CLANG) -target x86_64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit\=0 \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
`	-fbuild-session-file\=$(BUILD_ROOT)/XCM'STUBNAME()`_vers.c \'
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
`	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCM'STUBNAME()`_vers.d \'
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

`$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCM'STUBNAME()`/main.o: XCMBuild/XCM'STUBNAME()`/main.m XCMBuild/XCM'STUBNAME()`/XCM'STUBNAME()`.h $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCM'STUBNAME()`_vers.o |$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCM'STUBNAME()`'
`	$(QUIET)$(ECHO) "Compile XCM'STUBNAME()`: $@ (arm64)" ;'
	$(QUIET)$(CLANG) -x objective-c -target arm64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit\=0 \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
`	-fbuild-session-file\=$(BUILD_ROOT)/XCM'STUBNAME()`_vers.c \'
	-fmodules -gmodules -greproducible \
	-mincremental-linker-compatible \
	-Xpreprocessor -DDEBUG\=1 \
	-O0 -flto\=thin -fno-common -isysroot $(SDKROOT) $(CCFLAGS_DARWIN) \
`	-I$(PROJECT_ROOT)/XCMBuild/XCM'STUBNAME()` -I$(PROJECT_ROOT)/XCMBuild \'
`	-I$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCM'STUBNAME()` \'
	-F/$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot $(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot usr/lib \
	-iframeworkwithsysroot usr/lib/System \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
`	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCM'STUBNAME()`.d \'
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

`$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCM'STUBNAME()`_vers.o:: $(BUILD_ROOT)/XCM'STUBNAME()`_vers.c $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64 |build'
	$(QUIET)$(ECHO) "Compile Version Header: $@ (arm64)" ;
	$(QUIET)$(CLANG) -target arm64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	$(CLANG_FLAGS_ALL) -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit\=0 \
	$(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-weak \
`	-fbuild-session-file\=$(BUILD_ROOT)/XCM'STUBNAME()`_vers.c \'
`	-fmodules -gmodules	-greproducible -fmodule-name\=XCMBuild.XCM'STUBNAME()` \'
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
`	-MMD -MT dependencies -MF $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCM'STUBNAME()`_vers.d \'
	-c $< -o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

`$(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/Current/usr/bin/XCM'STUBNAME()`: $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/Current'
	$(DO_FAIL) ;

`$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCM'STUBNAME()`-Info.plist: shared/XCM'STUBNAME()`-Info.plist $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64'
	$(QUIET)$(CLANG) -E -P -x c -Wno-trigraphs Resources/XCMBuild-Info.plist -F$(BUILD_ROOT)/$(CONFIGURATION) \
	-target x86_64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	-isysroot $(SDKROOT) \
`	-DPRODUCT_IDENTIFIER\=$(PRODUCT_ORG_IDENTIFIER)XCMBuild.XCM'STUBNAME()` \'
`	-o $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCM'STUBNAME()`-Info.plist.xml || DO_FAIL="exit 2" ;'
	$(DO_FAIL) ;
	$(QUIET)$(FIX_INFO_PLIST) "$@.xml" >"$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(SYNC) ;
	$(QUIET)$(WAIT) ;
	$(QUIET)$(RM) $(WITH_FORCE) "$@.xml" 2>/dev/null || true ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "$@: Embeded." ;

`$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCM'STUBNAME()`-Info.plist: shared/XCM'STUBNAME()`-Info.plist'
`	$(QUIET)$(CLANG) -E -P -x c -Wno-trigraphs shared/XCM'STUBNAME()`-Info.plist -F$(BUILD_ROOT)/$(CONFIGURATION) \'
	-target arm64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	-isysroot $(SDKROOT) \
`	-DPRODUCT_IDENTIFIER\=$(PRODUCT_ORG_IDENTIFIER)XCMBuild.XCM'STUBNAME()` \'
`	-o $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCM'STUBNAME()`-Info.plist.xml || DO_FAIL="exit 2" ;'
	$(DO_FAIL) ;
	$(QUIET)$(FIX_INFO_PLIST) "$@.xml" >"$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(SYNC) ;
	$(QUIET)$(WAIT) ;
	$(QUIET)$(RM) $(WITH_FORCE) "$@.xml" 2>/dev/null || true ;
	$(DO_FAIL) ;

`$(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/XCM'STUBNAME()`-Info.plist: shared/XCM'STUBNAME()`-Info.plist'
`	$(QUIET)$(CLANG) -E -P -x c -Wno-trigraphs shared/XCM'STUBNAME()`-Info.plist -F$(BUILD_ROOT)/$(CONFIGURATION) \'
	-target aarch64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	-isysroot $(SDKROOT) \
`	-DPRODUCT_IDENTIFIER\=$(PRODUCT_ORG_IDENTIFIER)XCMBuild.XCM'STUBNAME()` \'
`	-o $(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/XCM'STUBNAME()`-Info.plist.xml || DO_FAIL="exit 2" ;'
	$(DO_FAIL) ;
	$(QUIET)$(FIX_INFO_PLIST) "$@.xml" >"$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(SYNC) ;
	$(QUIET)$(WAIT) ;
	$(QUIET)$(RM) $(WITH_FORCE) "$@.xml" 2>/dev/null || true ;
	$(DO_FAIL) ;

`$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCM'STUBNAME()`-Info.plist: shared/XCM'STUBNAME()`-Info.plist'
`	$(QUIET)$(CLANG) -E -P -x c -Wno-trigraphs shared/XCM'STUBNAME()`-Info.plist -F$(BUILD_ROOT)/$(CONFIGURATION) \'
	-target x86_64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	-isysroot $(SDKROOT) \
`	-DPRODUCT_IDENTIFIER\=$(PRODUCT_ORG_IDENTIFIER)XCMBuild.XCM'STUBNAME()` \'
`	-o $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCM'STUBNAME()`-Info.plist.xml ;'
	$(DO_FAIL) ;
	$(QUIET)$(FIX_INFO_PLIST) "$@.xml" >"$@" ;
	$(QUIET)$(SYNC) ;
	$(QUIET)$(WAIT) ;
	$(QUIET)$(RM) $(WITH_FORCE) "$@.xml" 2>/dev/null || true ;

`$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/Binary/XCM'STUBNAME()`-Info.plist: shared/XCM'STUBNAME()`-Info.plist'
`	$(QUIET)$(CLANG) -E -P -x c -Wno-trigraphs shared/XCM'STUBNAME()`-Info.plist -F$(BUILD_ROOT)/$(CONFIGURATION) \'
	-target arm64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	-isysroot $(SDKROOT) \
`	-DPRODUCT_IDENTIFIER\=$(PRODUCT_ORG_IDENTIFIER)XCMBuild.XCM'STUBNAME()` \'
`	-o $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCM'STUBNAME()`-Info.plist.xml ;'
	$(DO_FAIL) ;
	$(QUIET)$(FIX_INFO_PLIST) "$@.xml" >"$@" ;
	$(QUIET)$(SYNC) ;
	$(QUIET)$(WAIT) ;
	$(QUIET)$(RM) $(WITH_FORCE) "$@.xml" 2>/dev/null || true ;

`$(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/XCM'STUBNAME()`-Info.plist: shared/XCM'STUBNAME()`-Info.plist'
`	$(QUIET)$(CLANG) -E -P -x c -Wno-trigraphs shared/XCM'STUBNAME()`-Info.plist -F$(BUILD_ROOT)/$(CONFIGURATION) \'
	-target aarch64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) \
	-isysroot $(SDKROOT) \
`	-DPRODUCT_IDENTIFIER\=$(PRODUCT_ORG_IDENTIFIER)XCMBuild.XCM'STUBNAME()` \'
`	-o $(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/XCM'STUBNAME()`-Info.plist.xml ;'
	$(DO_FAIL) ;
	$(QUIET)$(FIX_INFO_PLIST) "$@.xml" >"$@" ;
	$(QUIET)$(SYNC) ;
	$(QUIET)$(WAIT) ;
	$(QUIET)$(RM) $(WITH_FORCE) "$@.xml" 2>/dev/null || true ;

`$(UNINSTALLED_PRODUCTS_DIR)/XCM'STUBNAME()`: $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/Binary/XCM'STUBNAME()` $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/Binary/XCM'STUBNAME()` $(UNINSTALLED_PRODUCTS_DIR) $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/Binary $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/Binary $(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/Binary $(PROJECT_TEMP_ROOT)/EagerLinkingTBDs/$(CONFIGURATION) $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/XCMBuild'
`	$(QUIET)$(LIPO) -create $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/Binary/XCM'STUBNAME()` \'
`	$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/Binary/XCM'STUBNAME()` -output $@ || DO_FAIL="exit 2" ;'
	$(DO_FAIL) ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(ECHO) "Combined universal $@." ;

`$(UNINSTALLED_PRODUCTS_DIR)/XCM'STUBNAME()`_debug: $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/Binary/XCM'STUBNAME()` $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/Binary/XCM'STUBNAME()` $(UNINSTALLED_PRODUCTS_DIR) $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/Binary $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/Binary $(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/Binary $(PROJECT_TEMP_ROOT)/EagerLinkingTBDs/$(CONFIGURATION) $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/XCMBuild'
`	$(QUIET)$(LIPO) -create $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/Binary/XCM'STUBNAME()` \'
`	$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/Binary/XCM'STUBNAME()` -output $@ || DO_FAIL="exit 2" ;'
	$(DO_FAIL) ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(ECHO) "Combined universal $@. (DEBUG)" ;

`$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCM'STUBNAME()`: $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64'
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
`	$(QUIET)$(ECHO) "XCM'STUBNAME()` Object Sub-Directory Ready (x86_64)" ;'

`$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCM'STUBNAME()`: $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64'
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
`	$(QUIET)$(ECHO) "XCM'STUBNAME()` Object Sub-Directory Ready (arm64)" ;'

`$(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/XCM'STUBNAME()`: $(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64'
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
`	$(QUIET)$(ECHO) "XCM'STUBNAME()` Object Sub-Directory Ready (arch64)" ;'

`$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCM'STUBNAME()`: $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64'
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
`	$(QUIET)$(ECHO) "XCM'STUBNAME()` Object Sub-Directory Ready (x86_64 debug)" ;'

`$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCM'STUBNAME()`: $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64'
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
`	$(QUIET)$(ECHO) "XCM'STUBNAME()` Object Sub-Directory Ready (arm64 debug)" ;'

`$(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/XCM'STUBNAME()`: $(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64'
	$(QUIET)$(MKDIR) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
`	$(QUIET)$(ECHO) "XCM'STUBNAME()` Object Sub-Directory Ready (arch64 debug)" ;'

`$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/Binary/XCM'STUBNAME()`: $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/Binary $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Modules/module.private.modulemap $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCM'STUBNAME()`_vers.o $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCM'STUBNAME()`/main.o $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCM'STUBNAME()`.LinkFileList $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCM'STUBNAME()`-Info.plist |XCMBuild-dynamic-library XCMBuild-XCM'STUBNAME()`-headers'
	$(QUIET)$(ECHO) "Combining objects into command line tool ($@)" || DO_FAIL="exit 2" ;
	$(QUIET)$(CLANG) -Xlinker -reproducible -target x86_64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) -Xlinker -execute \
	-isysroot $(SDKROOT) \
`	-fbuild-session-file\=$(BUILD_ROOT)/XCM'STUBNAME()`_vers.c \'
	-O0 -L$(PROJECT_TEMP_ROOT)/EagerLinkingTBDs/$(CONFIGURATION) -L$(SYMROOT) \
	-F$(SYMROOT) -L$(BUILD_ROOT)/$(CONFIGURATION) \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-F$(PROJECT_TEMP_ROOT)/EagerLinkingTBDs/$(CONFIGURATION) \
	-F$(BUILD_ROOT)/$(CONFIGURATION) \
	-F/$(DYLIB_INSTALL_NAME_BASE) -iframeworkwithsysroot /$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot /System/Library/Frameworks \
	-iframeworkwithsysroot /Library/Frameworks \
	-L/usr/lib -L/usr/lib/System \
`	-filelist "$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCM'STUBNAME()`.LinkFileList" \'
	-Xlinker -no_exported_symbols -Xlinker -rpath -Xlinker $(DYLIB_INSTALL_NAME_BASE)/\*\* \
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
`	-Xlinker -object_path_lto -Xlinker $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCM'STUBNAME()`/XCM'STUBNAME()`/lto.o \'
	-Xlinker -cache_path_lto -Xlinker $(TARGET_TEMP_DIR)/LTOCache/ \
`	-Xlinker -final_output -Xlinker /$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/usr/bin/XCM'STUBNAME()` \'
	-ObjC -weak_framework Foundation,framework -framework XCMBuild,framework -weak-lobjc -weak_framework CoreFoundation,framework \
	-weak-lc -weak-lSystem -weak-lsandbox -Xlinker -no_adhoc_codesign \
`	-sectcreate __TEXT __info_plist $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCM'STUBNAME()`-Info.plist \'
	-o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;


`$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/Binary/XCM'STUBNAME()`: $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/Binary $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Modules/module.private.modulemap $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCM'STUBNAME()`_vers.o $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCM'STUBNAME()`/main.o $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCM'STUBNAME()`.LinkFileList $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCM'STUBNAME()`-Info.plist |XCMBuild-dynamic-library XCMBuild-XCM'STUBNAME()`-headers'
	$(QUIET)$(ECHO) "Combining objects into command line tool ($@)" || DO_FAIL="exit 2" ;
	$(QUIET)$(CLANG) -Xlinker -reproducible -target arm64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) -Xlinker -execute \
	-isysroot $(SDKROOT) \
`	-fbuild-session-file\=$(BUILD_ROOT)/XCM'STUBNAME()`_vers.c \'
	-O0 -L$(PROJECT_TEMP_ROOT)/EagerLinkingTBDs/$(CONFIGURATION) -L$(SYMROOT) \
	-F$(SYMROOT) -L$(BUILD_ROOT)/$(CONFIGURATION) \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-F$(PROJECT_TEMP_ROOT)/EagerLinkingTBDs/$(CONFIGURATION) \
	-F$(BUILD_ROOT)/$(CONFIGURATION) \
	-F/$(DYLIB_INSTALL_NAME_BASE) -iframeworkwithsysroot /$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot /System/Library/Frameworks \
	-iframeworkwithsysroot /Library/Frameworks \
	-L/usr/lib -L/usr/lib/System \
`	-filelist "$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCM'STUBNAME()`.LinkFileList" \'
	-Xlinker -no_exported_symbols -Xlinker -rpath -Xlinker $(DYLIB_INSTALL_NAME_BASE)/\*\* \
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
`	-Xlinker -object_path_lto -Xlinker $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCM'STUBNAME()`/XCM'STUBNAME()`/lto.o \'
	-Xlinker -cache_path_lto -Xlinker $(TARGET_TEMP_DIR)/LTOCache/ \
`	-Xlinker -final_output -Xlinker /$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/usr/bin/XCM'STUBNAME()` \'
	-ObjC -weak_framework Foundation,framework -framework XCMBuild,framework -weak-lobjc -weak_framework CoreFoundation,framework \
	-weak-lc -weak-lSystem -weak-lsandbox -Xlinker -no_adhoc_codesign \
`	-sectcreate __TEXT __info_plist $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCM'STUBNAME()`-Info.plist \'
	-o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

`$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/Binary/XCM'STUBNAME()`: $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/Binary $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Modules/module.private.modulemap $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCM'STUBNAME()`_vers.o $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCM'STUBNAME()`/main.o $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCM'STUBNAME()`.LinkFileList $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCM'STUBNAME()`-Info.plist |XCMBuild-dynamic-library XCMBuild-XCM'STUBNAME()`-headers'
	$(QUIET)$(ECHO) "Combining objects into command line Debug tool ($@)" || DO_FAIL="exit 2" ;
	$(QUIET)$(CLANG) -Xlinker -reproducible -target x86_64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) -Xlinker -execute \
	-isysroot $(SDKROOT) \
`	-fbuild-session-file\=$(BUILD_ROOT)/XCM'STUBNAME()`_vers.c \'
	-O0 -L$(PROJECT_TEMP_ROOT)/EagerLinkingTBDs/$(CONFIGURATION) -L$(SYMROOT) \
	-F$(SYMROOT) -L$(BUILD_ROOT)/$(CONFIGURATION) \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-F$(PROJECT_TEMP_ROOT)/EagerLinkingTBDs/$(CONFIGURATION) \
	-F$(BUILD_ROOT)/$(CONFIGURATION) \
	-F/$(DYLIB_INSTALL_NAME_BASE) -iframeworkwithsysroot /$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot /System/Library/Frameworks \
	-iframeworkwithsysroot /Library/Frameworks \
	-L/usr/lib -L/usr/lib/System \
`	-filelist "$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCM'STUBNAME()`.LinkFileList" \'
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
	-fobjc-link-runtime -flto\=thin -gmodules -greproducible -Xlinker -export_dynamic \
	-Xlinker -weak_reference_mismatches -Xlinker weak \
	-Xlinker -keep_private_externs \
`	-Xlinker -object_path_lto -Xlinker $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCM'STUBNAME()`/XCM'STUBNAME()`/lto.o \'
	-Xlinker -cache_path_lto -Xlinker $(TARGET_TEMP_DIR)/LTOCache/ \
`	-Xlinker -final_output -Xlinker /$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/usr/bin/XCM'STUBNAME()` \'
	-ObjC -weak_framework Foundation,framework -framework XCMBuild,framework -weak-lobjc -weak_framework CoreFoundation,framework \
	-weak-lc -weak-lSystem -weak-lsandbox -Xlinker -no_adhoc_codesign \
`	-sectcreate __TEXT __info_plist $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCM'STUBNAME()`-Info.plist \'
	-o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;


`$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/Binary/XCM'STUBNAME()`: $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/Binary $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Modules/module.private.modulemap $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCM'STUBNAME()`_vers.o $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCM'STUBNAME()`/main.o $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCM'STUBNAME()`.LinkFileList $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCM'STUBNAME()`-Info.plist |XCMBuild-dynamic-library XCMBuild-XCM'STUBNAME()`-headers'
	$(QUIET)$(ECHO) "Combining objects into command line Debug tool ($@)" || DO_FAIL="exit 2" ;
	$(QUIET)$(CLANG) -Xlinker -reproducible -target arm64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) -Xlinker -execute \
	-isysroot $(SDKROOT) \
`	-fbuild-session-file\=$(BUILD_ROOT)/XCM'STUBNAME()`_vers.c \'
	-O0 -L$(PROJECT_TEMP_ROOT)/EagerLinkingTBDs/$(CONFIGURATION) -L$(SYMROOT) \
	-F$(SYMROOT) -L$(BUILD_ROOT)/$(CONFIGURATION) \
	-F/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION) \
	-F$(PROJECT_TEMP_ROOT)/EagerLinkingTBDs/$(CONFIGURATION) \
	-F$(BUILD_ROOT)/$(CONFIGURATION) \
	-F/$(DYLIB_INSTALL_NAME_BASE) -iframeworkwithsysroot /$(DYLIB_INSTALL_NAME_BASE) \
	-iframeworkwithsysroot /System/Library/Frameworks \
	-iframeworkwithsysroot /Library/Frameworks \
	-L/usr/lib -L/usr/lib/System \
`	-filelist "$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCM'STUBNAME()`.LinkFileList" \'
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
`	-Xlinker -object_path_lto -Xlinker $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCM'STUBNAME()`/XCM'STUBNAME()`/lto.o \'
	-Xlinker -cache_path_lto -Xlinker $(TARGET_TEMP_DIR)/LTOCache/ \
`	-Xlinker -final_output -Xlinker /$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/usr/bin/XCM'STUBNAME()` \'
	-ObjC -weak_framework Foundation,framework -framework XCMBuild,framework -weak-lobjc -weak_framework CoreFoundation,framework \
	-weak-lc -weak-lSystem -weak-lsandbox -Xlinker -no_adhoc_codesign \
`	-sectcreate __TEXT __info_plist $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCM'STUBNAME()`-Info.plist \'
	-o $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

`$(TARGET_TEMP_DIR)/build/XCM'STUBNAME()`-order-normal.txt:: shared/Clang/XCM'STUBNAME()`-orderfile-dbg |$(TARGET_TEMP_DIR)/build/'
	$(QUIET)$(CP) "$<" "$@" 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

`$(TARGET_TEMP_DIR)/build/XCM'STUBNAME()`-order-debug.txt:: shared/Clang/XCM'STUBNAME()`-orderfile-dbg |$(TARGET_TEMP_DIR)/build/'
	$(QUIET)$(CP) "$<" "$@" 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

`$(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/usr/bin/XCM'STUBNAME()`: $(UNINSTALLED_PRODUCTS_DIR)/XCM'STUBNAME()` $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/usr/bin $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/usr $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Resources/ToolTestIcon.icns XCMBuild-XCM'STUBNAME()`-headers'
	$(QUIET)$(CP) "$<" "$@" 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(SETICON) $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Resources/ToolTestIcon.icns "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(UNMARK) $@ || DO_FAIL="exit 2" ;
`	$(QUIET)codesign --force -vvvv --sign ${CODE_SIGN_IDENTITY} --prefix=$(PRODUCT_ORG_IDENTIFIER) --entitlements shared/security/entitlements/XCM'STUBNAME()`.entitlements --identifier=$(PRODUCT_ORG_IDENTIFIER)XCMBuild.XCM'STUBNAME()` --preserve-metadata=identifier,requirements,entitlements,flags -o linker-signed,hard --timestamp=none --generate-entitlement-der "$@" ;'
	$(QUIET)codesign --force -vvvv --sign ${CODE_SIGN_IDENTITY} --bundle-version $(FRAMEWORK_VERSION) --prefix=$(PRODUCT_ORG_IDENTIFIER) --identifier=$(PRODUCT_ORG_IDENTIFIER)XCMBuild --preserve-metadata=identifier,requirements,entitlements,flags -o linker-signed,hard --timestamp=none --generate-entitlement-der $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
`	$(QUIET)$(ECHO) "Built with XCM'STUBNAME()`-$(FRAMEWORK_VERSION)." ;'

`$(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/usr/bin/XCM'STUBNAME()`_debug: $(UNINSTALLED_PRODUCTS_DIR)/XCM'STUBNAME()` $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/usr/bin $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/usr XCMBuild-XCM'STUBNAME()`-headers'
	$(QUIET)$(CP) "$<" "$@" 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(UNMARK) $@ || DO_FAIL="exit 2" ;
`	$(QUIET)codesign --force -vvvv --sign ${CODE_SIGN_IDENTITY} --prefix=$(PRODUCT_ORG_IDENTIFIER) --entitlements shared/security/entitlements/XCM'STUBNAME()`.entitlements --identifier=$(PRODUCT_ORG_IDENTIFIER)XCMBuild.XCM'STUBNAME()`.Debug -o hard --timestamp=none --generate-entitlement-der "$@" ;'
	$(QUIET)codesign --force -vvvv --sign ${CODE_SIGN_IDENTITY} --bundle-version $(FRAMEWORK_VERSION) --prefix=$(PRODUCT_ORG_IDENTIFIER) --identifier=$(PRODUCT_ORG_IDENTIFIER)XCMBuild --preserve-metadata=identifier,requirements,entitlements,flags -o linker-signed,hard --timestamp=none --generate-entitlement-der $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
`	$(QUIET)$(ECHO) "Built with XCM'STUBNAME()`-$(FRAMEWORK_VERSION). (DEBUG)" ;'

`XCM'STUBNAME()`-cli:: dist/Library/Frameworks XCMBuild-framework XCMBuild-XCM'STUBNAME()`-headers $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/usr/bin/XCM'STUBNAME()` $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/usr/bin/XCM'STUBNAME()`_debug'

`endif'
