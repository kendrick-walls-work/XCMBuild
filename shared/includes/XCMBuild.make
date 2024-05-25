#!/usr/bin/env make -f

# reactive-firewall/XCMBuild project Makefile
# ..................................
# Copyright (c) 2023-2024, Mr. Walls
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

$(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/Current/XCMBuild: $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/Current
	$(DO_FAIL) ;

$(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/XCMBuild: $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/Current/XCMBuild
	$(QUIET)$(LINK) Versions/Current/XCMBuild "$@" || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "$@: Done." ;

$(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/XCMBuild: $(UNINSTALLED_PRODUCTS_DIR)/XCMBuild.dylib |XCMBuild-dynamic-library
	$(QUIET)$(CP) "$<" "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "$@: Done." ;

$(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/XCMBuild_debug: $(UNINSTALLED_PRODUCTS_DIR)/XCMBuild_debug.dylib |XCMBuild-dynamic-library-debug
	$(QUIET)$(CP) "$<" "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "$@: Done." ;

$(UNINSTALLED_PRODUCTS_DIR)/XCMBuild.dylib: $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/Binary/XCMBuild.dylib $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/Binary/XCMBuild.dylib $(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/Binary/XCMBuild.dylib $(UNINSTALLED_PRODUCTS_DIR) $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/Binary $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/Binary $(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/Binary $(PROJECT_TEMP_ROOT)/EagerLinkingTBDs/$(CONFIGURATION) $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/
	$(QUIET)$(LIPO) -create $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/Binary/XCMBuild.dylib \
	$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/Binary/XCMBuild.dylib -output $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHMOD) $(INST_FILE_OPTS) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Combined universal $@." ;

$(UNINSTALLED_PRODUCTS_DIR)/XCMBuild_debug.dylib: $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/Binary/XCMBuild.dylib $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/Binary/XCMBuild.dylib $(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/Binary/XCMBuild.dylib $(UNINSTALLED_PRODUCTS_DIR) $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/Binary $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/Binary $(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/Binary $(PROJECT_TEMP_ROOT)/EagerLinkingTBDs/$(CONFIGURATION) $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/
	$(QUIET)$(LIPO) -create $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/Binary/XCMBuild.dylib \
	$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/Binary/XCMBuild.dylib -output $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(CHMOD) $(INST_FILE_OPTS) $@ 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Combined universal $@. (Debug)" ;

$(TARGET_TEMP_DIR)/StaticAnalyzer/XCMBuild/XCMBuild/normal/x86_64/XCMShell.plist: |$(TARGET_TEMP_DIR)/StaticAnalyzer/XCMBuild/XCMBuild/normal/x86_64
	$(QUIET)$(CLANG) -x objective-c -fmessage-length\=0 -fdiagnostics-show-note-include-stack \
	-fmacro-backtrace-limit\=0 -fno-color-diagnostics -fobjc-arc -fobjc-weak -fmodules -gmodules \
	-fmodules-cache-path\=/Volumes/Sandbox/Developer/Xcode/DerivedData/ModuleCache.noindex \
	-fno-autolink -Wno-private-module -fmodules-prune-interval\=7200 -fmodules-prune-after\=3600 \
	-fbuild-session-file\=/Volumes/Sandbox/Developer/Xcode/DerivedData/ModuleCache.noindex/Session.modulevalidation \
	-fmodules-validate-once-per-build-session -Wnon-modular-include-in-framework-module \
	-Werror\=non-modular-include-in-framework-module -fmodule-name\=XCMBuild -Wno-trigraphs -O0 \
	-Wno-missing-field-initializers -Wmissing-prototypes -Wno-return-type -Wdocumentation \
	-Wunreachable-code -Wquoted-include-in-framework-header -Wframework-include-private-from-public \
	-Wno-implicit-atomic-properties -Werror\=deprecated-objc-isa-usage -Wno-objc-interface-ivars \
	-Werror\=objc-root-class -Warc-repeated-use-of-weak -Warc-maybe-repeated-use-of-weak \
	-Wimplicit-retain-self -Wduplicate-method-match -Wno-missing-braces -Wparentheses -Wswitch \
	-Wcompletion-handler -Wno-unused-function -Wno-unused-label -Wno-unused-parameter \
	-Wno-unused-variable -Wunused-value -Wempty-body -Wuninitialized -Wconditional-uninitialized \
	-Wunknown-pragmas -Wno-shadow -Wno-four-char-constants -Wconversion -Wconstant-conversion \
	-Wint-conversion -Wbool-conversion -Wenum-conversion -Wfloat-conversion \
	-Wnon-literal-null-conversion -Wobjc-literal-conversion -Wsign-compare -Wshorten-64-to-32 \
	-Wpointer-sign -Wno-newline-eof -Wno-selector -Wstrict-selector-match -Wundeclared-selector \
	-Wno-deprecated-implementations -Wno-implicit-fallthrough -DDEBUG\=1 -DTARGET_OS_OSX\=1 \
	-DOBJC_OLD_DISPATCH_PROTOTYPES\=0 -isysroot $(SDKROOT) -fobjc-arc-exceptions -fstrict-aliasing \
	-Wprotocol -Wdeprecated-declarations -g -Wno-sign-conversion -Winfinite-recursion -Wcomma \
	-Wblock-capture-autoreleasing -Wstrict-prototypes -Wno-semicolon-before-method-body \
	-Wunguarded-availability -D__clang_analyzer__ -Xclang -analyzer-output\=plist-multi-file \
	-Xclang -analyzer-config -Xclang report-in-main-source-file\=true -Xclang -analyzer-config \
	-Xclang osx.NumberObjectConversion:Pedantic\=true -Xclang -analyzer-checker -Xclang \
	security.insecureAPI.UncheckedReturn -Xclang -analyzer-checker -Xclang security.insecureAPI.getpw \
	-Xclang -analyzer-checker -Xclang security.insecureAPI.gets -Xclang -analyzer-checker \
	-Xclang security.insecureAPI.mkstemp -Xclang -analyzer-checker -Xclang security.insecureAPI.mktemp \
	-Xclang -analyzer-checker -Xclang security.insecureAPI.rand -Xclang -analyzer-checker -Xclang \
	security.insecureAPI.strcpy -Xclang -analyzer-checker -Xclang security.insecureAPI.vfork \
	-iquote $(TARGET_TEMP_DIR)/XCMBuild-generated-files.hmap -I$(TARGET_TEMP_DIR)/XCMBuild-own-target-headers.hmap \
	-I$(TARGET_TEMP_DIR)/XCMBuild-all-non-framework-target-headers.hmap -ivfsoverlay \
	$(TARGET_TEMP_DIR)/all-product-headers.yaml -iquote $(TARGET_TEMP_DIR)/XCMBuild-project-headers.hmap \
	-I/Volumes/Sandbox/Developer/SDK/XCMBuild/build/Debug/include \
	-I$(TARGET_TEMP_DIR)/DerivedSources-normal/x86_64 -I$(TARGET_TEMP_DIR)/DerivedSources/x86_64 \
	-I$(TARGET_TEMP_DIR)/DerivedSources -F/Volumes/Sandbox/Developer/SDK/XCMBuild/build/Debug \
	-greproducible -x objective-c -MMD -MT dependencies -MF \
	$(TARGET_TEMP_DIR)/StaticAnalyzer/XCMBuild/XCMBuild/normal/x86_64/XCMShell.d --analyze \
	/Volumes/Sandbox/Developer/SDK/XCMBuild/XCMBuild/XCMShell.m -o $@

$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/%.d: $(XCMB_DOTD_BUILD_TOOL) $(BUILD_ROOT)/$(CONFIGURATION)/%.framework/Versions/$(FRAMEWORK_VERSION)/Headers/%.h
	$(QUIET)$(XCMB_DOTD_BUILD_TOOL) -o $@


$(TARGET_TEMP_DIR)/build/XCMBuild-order-normal.txt:: shared/Clang/orderfile |$(TARGET_TEMP_DIR)/build/
	$(QUIET)$(CP) "$<" "$@" 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/XCMBuild-order-debug.txt:: shared/Clang/orderfile |$(TARGET_TEMP_DIR)/build/
	$(QUIET)$(CP) "$<" "$@" 2>/dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/Binary/XCMBuild.dylib: $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/Binary |$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCMBuild_vers.o $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCMBuild.LinkFileList $(TARGET_TEMP_DIR)/build/XCMBuild-order-normal.txt
	$(QUIET)$(CLANG) -Xlinker -reproducible -target x86_64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) -dynamiclib \
	-O0 -L$(PROJECT_TEMP_ROOT)/EagerLinkingTBDs/$(CONFIGURATION) -L$(SYMROOT) \
	-F$(SYMROOT) $(CCFLAGS_DARWIN) \
	-fmodules -gmodules -fmodule-name\=XCMBuild \
	-filelist "$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCMBuild.LinkFileList" -Xlinker --no-demangle \
	-install_name /$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/XCMBuild \
	-Xlinker -rpath -Xlinker /$(DYLIB_INSTALL_NAME_BASE)/\*\* -Xlinker -rpath \
	-Xlinker @executable_path/../Frameworks -Xlinker -rpath -Xlinker @loader_path/Frameworks -dead_strip \
	-Xlinker -order_file -Xlinker $(TARGET_TEMP_DIR)/build/XCMBuild-order-normal.txt -Xlinker -object_path_lto \
	-Xlinker $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCMBuild_lto.o -Xlinker -no_deduplicate \
	$(CLANG_FLAGS_ALL) $(CLANG_OBJC_FLAGS) \
	-Xlinker -export_dynamic \
	-Xlinker -weak_reference_mismatches -Xlinker weak \
	-fobjc-link-runtime -weak-lc -weak-lobjc -weak-lSystem -weak_framework CoreFoundation,framework -framework Foundation,framework \
	-Xlinker -keep_private_externs \
	-Xlinker -no_adhoc_codesign -compatibility_version $(DYLIB_COMPATIBILITY_VERSION) \
	-current_version $(DYLIB_CURRENT_VERSION) -Xlinker -dependency_info \
	-Xlinker $(TARGET_TEMP_DIR)/Object-x86_64-normal/x86_64/XCMBuild_dependency_info.dat -o $@ ;
	$(QUIET)$(ECHO) "Compiled Dynamic Libarary ($@)" || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;

$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/Binary/XCMBuild.dylib: $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/Binary |$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCMBuild_vers.o $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCMBuild.LinkFileList $(TARGET_TEMP_DIR)/build/XCMBuild-order-normal.txt
	$(QUIET)$(CLANG) -Xlinker -reproducible -target arm64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) -dynamiclib \
	-O0 -L$(PROJECT_TEMP_ROOT)/EagerLinkingTBDs/$(CONFIGURATION) -L$(SYMROOT) \
	-F$(SYMROOT) $(CCFLAGS_DARWIN) \
	-fmodules -gmodules -fmodule-name\=XCMBuild \
	-filelist "$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCMBuild.LinkFileList" -Xlinker --no-demangle \
	-install_name /$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/XCMBuild \
	-Xlinker -rpath -Xlinker /$(DYLIB_INSTALL_NAME_BASE)/\*\* -Xlinker -rpath \
	-Xlinker @executable_path/../Frameworks -Xlinker -rpath -Xlinker @loader_path/Frameworks -dead_strip \
	-Xlinker -order_file -Xlinker $(TARGET_TEMP_DIR)/build/XCMBuild-order-normal.txt -Xlinker -object_path_lto \
	-Xlinker $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64XCMBuild_lto.o -Xlinker -no_deduplicate \
	$(CLANG_FLAGS_ALL) $(CLANG_OBJC_FLAGS) \
	-Xlinker -export_dynamic \
	-Xlinker -weak_reference_mismatches -Xlinker weak \
	-fobjc-link-runtime -weak-lc -weak-lobjc -weak-lSystem -weak_framework CoreFoundation,framework -framework Foundation,framework \
	-Xlinker -keep_private_externs \
	-Xlinker -no_adhoc_codesign -compatibility_version $(DYLIB_COMPATIBILITY_VERSION) \
	-current_version $(DYLIB_CURRENT_VERSION) -Xlinker -dependency_info \
	-Xlinker $(TARGET_TEMP_DIR)/Object-arm64-normal/arm64/XCMBuild_dependency_info.dat -o $@ ;
	$(QUIET)$(ECHO) "Compiled Dynamic Libarary ($@)" || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;

$(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/Binary/XCMBuild.dylib: $(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/Binary |$(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/XCMBuild_vers.o $(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/XCMBuild.LinkFileList $(TARGET_TEMP_DIR)/build/XCMBuild-order-normal.txt
	$(QUIET)$(CLANG) -Xlinker -reproducible -target aarch64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) -dynamiclib \
	-O0 -L$(PROJECT_TEMP_ROOT)/EagerLinkingTBDs/$(CONFIGURATION) -L$(SYMROOT) \
	-F$(SYMROOT) $(CCFLAGS_DARWIN) \
	-fmodules -gmodules -fmodule-name\=XCMBuild \
	-filelist "$(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/XCMBuild.LinkFileList" -Xlinker --no-demangle \
	-install_name /$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/XCMBuild \
	-Xlinker -rpath -Xlinker /$(DYLIB_INSTALL_NAME_BASE)/\*\* -Xlinker -rpath \
	-Xlinker @executable_path/../Frameworks -Xlinker -rpath -Xlinker @loader_path/Frameworks -dead_strip \
	-Xlinker -order_file -Xlinker $(TARGET_TEMP_DIR)/build/XCMBuild-order-normal.txt -Xlinker -object_path_lto \
	-Xlinker $(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64XCMBuild_lto.o -Xlinker -no_deduplicate \
	$(CLANG_FLAGS_ALL) $(CLANG_OBJC_FLAGS) \
	-Xlinker -export_dynamic \
	-Xlinker -weak_reference_mismatches -Xlinker weak \
	-fobjc-link-runtime -weak-lc -weak-lobjc -weak-lSystem -framework Foundation,framework \
	-Xlinker -keep_private_externs \
	-Xlinker -no_adhoc_codesign -compatibility_version $(DYLIB_COMPATIBILITY_VERSION) \
	-current_version $(DYLIB_CURRENT_VERSION) -Xlinker -dependency_info \
	-Xlinker $(TARGET_TEMP_DIR)/Object-arch64-normal/arch64/XCMBuild_dependency_info.dat -o $@ ;
	$(QUIET)$(ECHO) "Compiled Dynamic Libarary ($@)" || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;

$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCMBuild.LinkFileList:: $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCMBuild_vers.o $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Modules/module.modulemap $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCMShell.o $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCMShellDelegate.o $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCMBuildSystem.o $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCMProcesses.o |$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64 $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/Binary XCMBuild-all-headers
	$(QUIET)$(ECHO) "Generating Linker Map ($@)" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" '$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCMBuild_vers.o' > "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" "$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCMShell.o" >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" "$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCMShellDelegate.o" >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" "$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCMBuildSystem.o" >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" "$(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/XCMProcesses.o" >> "$@" || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCMBuild.LinkFileList:: $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCMBuild_vers.o $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Modules/module.modulemap $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCMShell.o $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCMShellDelegate.o $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCMBuildSystem.o $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCMProcesses.o |$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64 $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/Binary XCMBuild-all-headers
	$(QUIET)$(ECHO) "Generating Linker Map ($@)" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" '$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCMBuild_vers.o' > "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" "$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCMShell.o" >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" "$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCMShellDelegate.o" >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" "$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCMBuildSystem.o" >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" "$(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/XCMProcesses.o" >> "$@" || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/XCMBuild.LinkFileList:: $(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/XCMBuild_vers.o $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Modules/module.modulemap $(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/XCMShell.o $(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/XCMShellDelegate.o $(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/XCMBuildSystem.o $(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/XCMProcesses.o |$(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64 $(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/Binary XCMBuild-all-headers
	$(QUIET)$(ECHO) "Generating Linker Map ($@)" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" '$(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/XCMBuild_vers.o' > "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" "$(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/XCMShell.o" >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" "$(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/XCMShellDelegate.o" >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" "$(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/XCMBuildSystem.o" >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" "$(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/XCMProcesses.o" >> "$@" || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

#debug

$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/Binary/XCMBuild.dylib: $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/Binary |$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCMBuild_vers.o $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCMBuild.LinkFileList $(TARGET_TEMP_DIR)/build/XCMBuild-order-debug.txt
	$(QUIET)$(CLANG) -Xlinker -reproducible -target x86_64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) -dynamiclib \
	-O0 -L$(PROJECT_TEMP_ROOT)/EagerLinkingTBDs/$(CONFIGURATION) -L$(SYMROOT) \
	-F$(SYMROOT) $(CCFLAGS_DARWIN) \
	-fmodules -gmodules -greproducible -fmodule-name\=XCMBuild \
	-filelist "$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCMBuild.LinkFileList" -Xlinker --no-demangle \
	-install_name /$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/XCMBuild \
	-Xlinker -rpath -Xlinker /$(DYLIB_INSTALL_NAME_BASE)/\*\* -Xlinker -rpath \
	-Xlinker @executable_path/../Frameworks -Xlinker -rpath -Xlinker @loader_path/Frameworks -dead_strip \
	-Xlinker -order_file -Xlinker $(TARGET_TEMP_DIR)/build/XCMBuild-order-debug.txt -Xlinker -object_path_lto \
	-Xlinker $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCMBuild_lto.o -Xlinker -no_deduplicate \
	$(CLANG_FLAGS_ALL) $(CLANG_OBJC_FLAGS) \
	-Xlinker -export_dynamic \
	-Xlinker -weak_reference_mismatches -Xlinker weak \
	-fobjc-link-runtime -weak-lc -weak-lobjc -weak-lSystem -weak_framework CoreFoundation,framework -framework Foundation,framework \
	-Xlinker -keep_private_externs \
	-Xlinker -no_adhoc_codesign -compatibility_version $(DYLIB_COMPATIBILITY_VERSION) \
	-current_version $(DYLIB_CURRENT_VERSION) -Xlinker -dependency_info \
	-Xlinker $(TARGET_TEMP_DIR)/Object-x86_64-debug/x86_64/XCMBuild_dependency_info.dat -o $@ ;
	$(QUIET)$(ECHO) "Compiled Dynamic Libarary ($@ Debug)" || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;

$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/Binary/XCMBuild.dylib: $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/Binary |$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCMBuild_vers.o $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCMBuild.LinkFileList $(TARGET_TEMP_DIR)/build/XCMBuild-order-debug.txt
	$(QUIET)$(CLANG) -Xlinker -reproducible -target arm64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) -dynamiclib \
	-O0 -L$(PROJECT_TEMP_ROOT)/EagerLinkingTBDs/$(CONFIGURATION) -L$(SYMROOT) \
	-F$(SYMROOT) $(CCFLAGS_DARWIN) \
	-fmodules -gmodules -greproducible -fmodule-name\=XCMBuild \
	-filelist "$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCMBuild.LinkFileList" -Xlinker --no-demangle \
	-install_name /$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/XCMBuild \
	-Xlinker -rpath -Xlinker /$(DYLIB_INSTALL_NAME_BASE)/\*\* -Xlinker -rpath \
	-Xlinker @executable_path/../Frameworks -Xlinker -rpath -Xlinker @loader_path/Frameworks -dead_strip \
	-Xlinker -order_file -Xlinker $(TARGET_TEMP_DIR)/build/XCMBuild-order-debug.txt -Xlinker -object_path_lto \
	-Xlinker $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64XCMBuild_lto.o -Xlinker -no_deduplicate \
	$(CLANG_FLAGS_ALL) $(CLANG_OBJC_FLAGS) \
	-Xlinker -export_dynamic \
	-Xlinker -weak_reference_mismatches -Xlinker weak \
	-fobjc-link-runtime -weak-lc -weak-lobjc -weak-lSystem -weak_framework CoreFoundation,framework -framework Foundation,framework \
	-Xlinker -keep_private_externs \
	-Xlinker -no_adhoc_codesign -compatibility_version $(DYLIB_COMPATIBILITY_VERSION) \
	-current_version $(DYLIB_CURRENT_VERSION) -Xlinker -dependency_info \
	-Xlinker $(TARGET_TEMP_DIR)/Object-arm64-debug/arm64/XCMBuild_dependency_info.dat -o $@ ;
	$(QUIET)$(ECHO) "Compiled Dynamic Libarary ($@ Debug)" || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;

$(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/Binary/XCMBuild.dylib: $(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/Binary |$(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/XCMBuild_vers.o $(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/XCMBuild.LinkFileList $(TARGET_TEMP_DIR)/build/XCMBuild-order-debug.txt
	$(QUIET)$(CLANG) -Xlinker -reproducible -target aarch64-apple-macos$(MACOSX_DEPLOYMENT_TARGET) -dynamiclib \
	-O0 -L$(PROJECT_TEMP_ROOT)/EagerLinkingTBDs/$(CONFIGURATION) -L$(SYMROOT) \
	-F$(SYMROOT) $(CCFLAGS_DARWIN) \
	-fmodules -gmodules -greproducible -fmodule-name\=XCMBuild \
	-filelist "$(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/XCMBuild.LinkFileList" -Xlinker --no-demangle \
	-install_name /$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/XCMBuild \
	-Xlinker -rpath -Xlinker /$(DYLIB_INSTALL_NAME_BASE)/\*\* -Xlinker -rpath \
	-Xlinker @executable_path/../Frameworks -Xlinker -rpath -Xlinker @loader_path/Frameworks -dead_strip \
	-Xlinker -order_file -Xlinker $(TARGET_TEMP_DIR)/build/XCMBuild-order-debug.txt -Xlinker -object_path_lto \
	-Xlinker $(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64XCMBuild_lto.o -Xlinker -no_deduplicate \
	$(CLANG_FLAGS_ALL) $(CLANG_OBJC_FLAGS) \
	-Xlinker -export_dynamic \
	-Xlinker -weak_reference_mismatches -Xlinker weak \
	-fobjc-link-runtime -weak-lc -weak-lobjc -weak-lSystem -framework Foundation,framework \
	-Xlinker -keep_private_externs \
	-Xlinker -no_adhoc_codesign -compatibility_version $(DYLIB_COMPATIBILITY_VERSION) \
	-current_version $(DYLIB_CURRENT_VERSION) -Xlinker -dependency_info \
	-Xlinker $(TARGET_TEMP_DIR)/Object-arch64-debug/arch64/XCMBuild_dependency_info.dat -o $@ ;
	$(QUIET)$(ECHO) "Compiled Dynamic Libarary ($@ Debug)" || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;

$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCMBuild.LinkFileList:: $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCMBuild_vers.o $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Modules/module.modulemap $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCMShell.o $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCMShellDelegate.o $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCMBuildSystem.o $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCMProcesses.o |$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64 $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/Binary XCMBuild-all-headers
	$(QUIET)$(ECHO) "Generating Linker Map ($@)" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" '$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCMBuild_vers.o' > "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" "$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCMShell.o" >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" "$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCMShellDelegate.o" >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" "$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCMBuildSystem.o" >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" "$(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/XCMProcesses.o" >> "$@" || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCMBuild.LinkFileList:: $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCMBuild_vers.o $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Modules/module.modulemap $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCMShell.o $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCMShellDelegate.o $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCMBuildSystem.o $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCMProcesses.o |$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64 $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/Binary XCMBuild-all-headers
	$(QUIET)$(ECHO) "Generating Linker Map ($@)" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" '$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCMBuild_vers.o' > "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" "$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCMShell.o" >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" "$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCMShellDelegate.o" >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" "$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCMBuildSystem.o" >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" "$(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/XCMProcesses.o" >> "$@" || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

$(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/XCMBuild.LinkFileList:: $(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/XCMBuild_vers.o $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Modules/module.modulemap $(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/XCMShell.o $(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/XCMShellDelegate.o $(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/XCMBuildSystem.o $(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/XCMProcesses.o |$(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64 $(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/Binary XCMBuild-all-headers
	$(QUIET)$(ECHO) "Generating Linker Map ($@)" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" '$(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/XCMBuild_vers.o' > "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" "$(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/XCMShell.o" >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" "$(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/XCMShellDelegate.o" >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" "$(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/XCMBuildSystem.o" >> "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(PRINT) "%s\n" "$(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/XCMProcesses.o" >> "$@" || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;

XCMBuild-framework:: $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/ $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/ $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/ $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/Current XCMBuild-Module-Map XCMBuild-all-headers XCMBuild-vers-hdr XCMBuild-framework-assets XCMBuild-dynamic-library $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/XCMBuild $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/XCMBuild with-shell-tools
	$(QUIET)$(TEST) -f $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/XCMBuild || DO_FAIL="exit 2" ;
	$(QUIET)$(SETICON) $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Resources/Icon.icns $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)codesign --force -vvvv --sign ${CODE_SIGN_IDENTITY} --bundle-version $(FRAMEWORK_VERSION) --prefix=$(PRODUCT_ORG_IDENTIFIER) --identifier=$(PRODUCT_ORG_IDENTIFIER)XCMBuild --preserve-metadata=identifier,requirements,entitlements,flags -o linker-signed,hard --timestamp=none --generate-entitlement-der "$<" || DO_FAIL="exit 2" ;
	$(QUIET)$(WAIT) ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "$@: Done." ;

XCMBuild-Module-Map:: $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Modules $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Modules/module.modulemap
	$(QUIET)$(TEST) -f $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Modules/module.modulemap || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "$@: Configured." ;

$(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Modules/%.modulemap: $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Modules/%.modulemap $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/Current
	$(QUIET)$(TEST) -f "$@" || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "$@: Refreshed." ;

XCMBuild-framework-assets:: $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Resources $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Resources $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Resources/Base.lproj $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Resources/en.lproj $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Resources/LICENSE-2.0.txt $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Resources/en.lproj $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Resources/LICENSE-2.0.txt $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Resources/Icon.icns $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Resources/Info.plist
	$(QUIET)$(TEST) -f $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/Resources/Info.plist || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "$@: Done." ;

XCMBuild-dynamic-library:: XCMBuild-all-headers XCMBuild-vers-hdr $(PROJECT_TEMP_ROOT)/EagerLinkingTBDs/$(CONFIGURATION) $(TARGET_TEMP_DIR)/build/Object-x86_64-normal/x86_64/Binary/XCMBuild.dylib $(TARGET_TEMP_DIR)/build/Object-arm64-normal/arm64/Binary/XCMBuild.dylib $(TARGET_TEMP_DIR)/build/Object-arch64-normal/arch64/Binary/XCMBuild.dylib $(UNINSTALLED_PRODUCTS_DIR)/XCMBuild.dylib
	$(QUIET)$(TEST) -f $(UNINSTALLED_PRODUCTS_DIR)/XCMBuild.dylib || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "$@: Done." ;

XCMBuild-dynamic-library-debug:: XCMBuild-all-headers XCMBuild-vers-hdr $(PROJECT_TEMP_ROOT)/EagerLinkingTBDs/$(CONFIGURATION) $(TARGET_TEMP_DIR)/build/Object-x86_64-debug/x86_64/Binary/XCMBuild.dylib $(TARGET_TEMP_DIR)/build/Object-arm64-debug/arm64/Binary/XCMBuild.dylib $(TARGET_TEMP_DIR)/build/Object-arch64-debug/arch64/Binary/XCMBuild.dylib $(UNINSTALLED_PRODUCTS_DIR)/XCMBuild.dylib
	$(QUIET)$(TEST) -f $(UNINSTALLED_PRODUCTS_DIR)/XCMBuild_debug.dylib || DO_FAIL="exit 2" ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "$@: Done." ;

install-XCMBuild-fmwk:: XCMBuild-framework $(DSTROOT) $(DSTROOT)/$(DYLIB_INSTALL_NAME_BASE) $(DSTROOT)/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework
	$(QUIET)$(UNMARK) "$(DSTROOT)/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/XCMBuild" || DO_FAIL="exit 2" ;
	$(QUIET)codesign --force --sign $(CODE_SIGN_IDENTITY) -vvvvv --prefix=$(PRODUCT_ORG_IDENTIFIER) --entitlements shared/security/entitlements/XCMBuildRelease.entitlements --preserve-metadata=identifier,entitlements,flags --identifier=$(PRODUCT_BUNDLE_IDENTIFIER) -o linker-signed,hard,runtime --timestamp=none --generate-entitlement-der $(DSTROOT)/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework/Versions/$(FRAMEWORK_VERSION)/XCMBuild || true ;
	$(QUIET)$(WAIT) ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "Installed XCMBuild." ;

$(DSTROOT)/$(DYLIB_INSTALL_NAME_BASE)/XCMBuild.framework:: $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework |$(UNINSTALLED_PRODUCTS_DIR)
	$(QUIET)$(CPDIR) "$<" $(UNINSTALLED_PRODUCTS_DIR)/XCMBuild.framework || DO_FAIL="exit 2" ;
	$(QUIET)$(WAIT) ;
	$(DO_FAIL) ;
	$(QUIET)$(RMDIR) "$<" 2>/dev/null >> /dev/null || DO_FAIL="exit 2" ;
	$(QUIET)$(RMDIR) $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework 2>/dev/null >> /dev/null || true ;
	$(QUIET)$(SYNC) ;
	$(QUIET)$(WAIT) ;
	$(DO_FAIL) ;
	$(QUIET)$(LINK) "$@" $(BUILD_ROOT)/$(CONFIGURATION)/XCMBuild.framework || DO_FAIL="exit 2" ;
	$(QUIET)$(WAIT) ;
	$(DO_FAIL) ;
	$(QUIET)$(CPDIR) $(WITH_FORCE) $(UNINSTALLED_PRODUCTS_DIR)/XCMBuild.framework "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(WAIT) ;
	$(DO_FAIL) ;
	$(QUIET)$(UNMARK) "$@" || DO_FAIL="exit 2" ;
	$(QUIET)$(BSMARK) $@ || DO_FAIL="exit 2" ;
	$(QUIET)$(RMDIR) $(UNINSTALLED_PRODUCTS_DIR)/XCMBuild.framework 2>/dev/null >> /dev/null || true ;
	$(QUIET)$(SYNC) ;
	$(QUIET)$(WAIT) ;
	$(DO_FAIL) ;
	$(QUIET)$(ECHO) "$@: Bootstrapped." ;

endif
