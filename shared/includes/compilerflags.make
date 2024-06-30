#!/usr/bin/env make -f

# reactive-firewall/XCMBuild Repo Makefile
# ..................................
# Copyright (c) 2012-2024, Mr. Walls
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

ifdef COMMAND
	ifeq "$(CLANG)" ""
		CLANG=$(COMMAND) clang
		ifeq "$(CPP)" ""
			# what about clang -c ?
			CPP=$(CLANG) -cc1
		endif
		ifeq "$(GCC)" ""
			GCC=$(CLANG) -rtlib=libgcc -fgnu-keywords
		endif
		ifeq "$(GPP)" ""
			GPP=$(CPP) -rtlib=libgcc -fgnu-keywords
		endif
	endif

	ifeq "$(SDKROOT)" ""
		ifeq "$(SDK_NAME)" ""
			SDK_NAME=macosx
		endif
		ifeq "$(XCRUN)" ""
			XCRUN=$(COMMAND) xcrun
		endif
		SDKROOT=`$(XCRUN) --sdk $(SDK_NAME) --show-sdk-path 2>/dev/null ;`
	endif

	ifeq "$(CPP)" ""
		# what about clang -c ?
		CPP=$(COMMAND) cpp
	endif

	ifeq "$(GCC)" ""
		GCC=$(COMMAND) gcc
	endif

	ifeq "$(GPP)" ""
		GPP=$(COMMAND) g++
	endif

	ifeq "$(IBTOOL)" ""
		IBTOOL=$(COMMAND) ibtool --errors --warnings --notices --output-format human-readable-text --compile
	endif

	ifeq "$(JAVAC)" ""
		JAVAC=$(COMMAND) javac
	endif

	ifeq "$(JAVADOC)" ""
		JAVADOC=$(COMMAND) javadoc
	endif

	ifeq "$(JARZIP)" ""
		JARZIP=$(COMMAND) jar
	endif
else
	ifeq "$(JAVAC)" ""
		JAVAC=/usr/bin/javac
	endif
	ifeq "$(JAVADOC)" ""
		JAVADOC=/usr/bin/javadoc
	endif
	ifeq "$(JARZIP)" ""
		JARZIP=/usr/bin/jar
	endif

	ifeq "$(SDKROOT)" ""
		ifeq "$(SDK_NAME)" ""
			SDK_NAME=macosx
		endif
		SDKROOT=macosx
	endif

endif

ifndef PLIST_ENV_DEF
	PLIST_ENV_DEF=-DMACOSX_DEPLOYMENT_TARGET\=$(MACOSX_DEPLOYMENT_TARGET) -DINFOPLIST_KEY_LSMinimumSystemVersion\=$(INFOPLIST_KEY_LSMinimumSystemVersion) -DINFOPLIST_KEY_CFBundleDisplayName\="$(INFOPLIST_KEY_CFBundleDisplayName)" -DPRODUCT_BUNDLE_PACKAGE_TYPE\="$(PRODUCT_BUNDLE_PACKAGE_TYPE)" -DPRODUCT_BUNDLE_IDENTIFIER\=$(PRODUCT_BUNDLE_IDENTIFIER) -DINFOPLIST_KEY_CFBundleName\="$(INFOPLIST_KEY_CFBundleName)" -DINFOPLIST_KEY_NSHumanReadableCopyright\=$(INFOPLIST_KEY_NSHumanReadableCopyright) -DCURRENT_PROJECT_VERSION\=$(CURRENT_PROJECT_VERSION) -DDYLIB_COMPATIBILITY_VERSION\=$(DYLIB_COMPATIBILITY_VERSION) -DFRAMEWORK_VERSION\=$(FRAMEWORK_VERSION) -DMARKETING_VERSION\=$(MARKETING_VERSION) -DMODULE_VERSION\=$(MODULE_VERSION) -DINFOPLIST_KEY_NSPrincipalClass\=$(INFOPLIST_KEY_NSPrincipalClass)
endif

# check _NATIVE_OBJC_EXCEPTIONS

ifeq "$(CLANG_ENABLE_OBJC_ARC)" "YES"
	ifeq "$(CLANG_ENABLE_OBJC_ARC_EXCEPTIONS)" "NO"
		CLANG_OBJC_ARC_FLAGS:=-fobjc-arc
	else
		ifeq "$(CLANG_ENABLE_OBJC_ARC_EXCEPTIONS)" ""
			CLANG_ENABLE_OBJC_ARC_EXCEPTIONS=YES
		endif
		CLANG_OBJC_ARC_FLAGS:=-fobjc-arc -fobjc-arc-exceptions
	endif
endif

ifndef CLANG_ENABLE_OBJC_BLOCKS
	CLANG_ENABLE_OBJC_BLOCKS:=YES
endif

ifndef CLANG_ENABLE_OBJC_WEAK
	CLANG_ENABLE_OBJC_WEAK:=YES
endif

ifeq "$(CLANG_ENABLE_OBJC_BLOCKS)" "YES"
	ifeq "$(CLANG_OBJC_BLOCKS_FLAGS)" ""
		CLANG_OBJC_BLOCKS_FLAGS:=-fblocks -fasm-blocks
	endif
endif

ifeq "$(CLANG_ENABLE_OBJC_WEAK)" "YES"
	CLANG_OBJC_WEAK_FLAGS:=-fobjc-weak -fcommon
	# -Xlinker -commons -Xlinker use_dylibs
	# -Xlinker -weak_reference_mismatches -Xlinker weak
else
	ifeq "$(CLANG_ENABLE_OBJC_WEAK)" ""
		CLANG_ENABLE_OBJC_WEAK=NO
	endif
	# this might only work for ld
	CLANG_OBJC_WEAK_FLAGS:=-fno-common -Xlinker -no_weak_imports
	# -Xlinker -weak_reference_mismatches -Xlinker error
endif

ifeq "$(CCFLAGS_ALL)" ""
	CCFLAGS_ALL=-fexceptions -fstrict-aliasing -fvisibility\=default
endif

ifeq "$(CLANG_FLAGS_ALL)" ""
	CLANG_FLAGS_ALL=-fmessage-length\=0 -std\=c17 $(CCFLAGS_ALL)
endif

ifeq "$(GCCFLAGS_ALL)" ""
	GCCFLAGS_ALL=-fmessage-length\=0 -std\=gnu17 $(CCFLAGS_ALL)
endif

ifeq "$(CCFLAGS_DARWIN)" ""
	CCFLAGS_DARWIN=-mmacosx-version-min\=$(MACOSX_DEPLOYMENT_TARGET)
	GCCFLAGS_DARWIN_OLD=-fasm-blocks -mone-byte-bool -fconstant-cfstrings -isysroot $(SDKROOT) -mmacosx-version-min\=$(MACOSX_DEPLOYMENT_TARGET)
endif

ifeq "$(CLANG_OBJC_FLAGS)" ""
	CLANG_OBJC_FLAGS=-isysroot $(SDKROOT) -fconstant-cfstrings $(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-exceptions $(CLANG_OBJC_WEAK_FLAGS)
endif

ifeq "$(GCCFLAGS_GNUSTEP)" ""
	GCCFLAGS_GNUSTEP=-fobjc-gc -fcse-follow-jumps -fconstant-string-class\=NSConstantString -fPIC -DGNUSTEP -D_NATIVE_OBJC_EXCEPTIONS -D MAC_OS_X_VERSION_MIN_ALLOWED\=100600 -static
endif

ifeq "$(GCCOPTS_OLD_LGV)" ""
	GCCOPTS_OLD_LGV=-O0 -fpeel-loops -fearly-inlining -finline-limit\=100 -fcse-follow-jumps -fexpensive-optimizations -funroll-loops -fvariable-expansion-in-unroller -fstrict-aliasing -mtune\=native
endif

ifeq "$(GCCOPTS)" ""
	GCCOPTS=-O0 -fstack-protector -fstack-protector-strong -finline-hint-functions -fstrict-enums -funroll-loops -fstrict-aliasing -mtune=native
endif

ifeq "$(GCCWARNS)" ""
	GCCWARNS=-Wreturn-type -Wunused-variable -Wno-trigraphs
endif

ifeq "$(GCCWARNS_MAC)" ""
	GCCWARNS_MAC=-Wshorten-64-to-32
endif

ifeq "$(LLDFLAGS_ALL)" ""
	LLDFLAGS_ALL=-fexceptions -fobjc-exceptions $(CLANG_OBJC_ARC_FLAGS) $(CLANG_OBJC_BLOCKS_FLAGS) -fobjc-exceptions -Lbuild/$(CONFIGURATION) -Fbuild/$(CONFIGURATION) -lobjc
endif

ifeq "$(LLDFLAGS_DARWIN)" ""
	LLDFLAGS_DARWIN=-isysroot $(SDKROOT) -mmacosx-version-min\=$(MACOSX_DEPLOYMENT_TARGET)
	OLD_LLDFLAGS_DARWIN=-execute -fasm-blocks -no_dead_strip_inits_and_terms -isysroot $(OSX_SDK_ROOT_PATH) -mmacosx-version-min\=$(MACOSX_DEPLOYMENT_TARGET)
endif

ifeq "$(LLDFLAGS_GNUSTEP)" ""
	LLDFLAGS_GNUSTEP=-fPIC
endif

ifeq "$(LLDOPTS)" ""
	LLDOPTS=-O0 -fpeel-loops -fwhole-program -fstrict-aliasing
endif

.PHONY: all test clean


# might add somthing like this the way xcodebuild does
#	<key>DTCompiler</key>
#	<string>com.apple.compilers.llvm.clang.1_0</string>
#	<key>DTPlatformBuild</key>
#	<string></string>
#	<key>DTPlatformName</key>
#	<string>macosx</string>
#	<key>DTPlatformVersion</key>
#	<string>$(xcrun --sdk macosx --show-sdk-version)</string>
#	<key>DTSDKBuild</key>
#	<string>$(xcrun --sdk macosx --show-sdk-build-version)</string>
#	<key>DTSDKName</key>
#	<string>$(SDK_NAME)</string>
#	<key>DTXcode</key>
#	<string>$(system_profiler -xml SPDeveloperToolsDataType | grep -A1 -F "spdevtools_version" | grep -E "(?:<string>).+\s*.+(?:</string>)" | grep -oE "\d+.\d+.\d+\s" | tr -d '. ' )</string>
#	<key>DTXcodeBuild</key>
#	<string>$(system_profiler -xml SPDeveloperToolsDataType | grep -A1 -F "spdevtools_version" | grep -E "(?:<string>).+\s*.+(?:</string>)" | grep -oE "\(.+\)" | tr -d '()')</string>
