#!/usr/bin/env make -f

# reactive-firewall/XCMBuild Repo Version settings Makefile
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

ifeq "$(MACOSX_DEPLOYMENT_TARGET)" ""
	MACOSX_DEPLOYMENT_TARGET=11.0
endif

ifeq "$(INFOPLIST_KEY_LSMinimumSystemVersion)" ""
	INFOPLIST_KEY_LSMinimumSystemVersion=$(MACOSX_DEPLOYMENT_TARGET)
endif

ifeq "$(INFOPLIST_KEY_CFBundleDisplayName)" ""
	INFOPLIST_KEY_CFBundleDisplayName=XCMBuild
endif

ifeq "$(INFOPLIST_KEY_CFBundleName)" ""
	INFOPLIST_KEY_CFBundleName=XCMBuild
endif

ifeq "$(INFOPLIST_KEY_NSPrincipalClass)" ""
	INFOPLIST_KEY_NSPrincipalClass=XCMBuildSystem
endif

ifeq "$(PRODUCT_BUNDLE_PACKAGE_TYPE)" ""
	PRODUCT_BUNDLE_PACKAGE_TYPE=FMWK
endif

ifeq "$(PRODUCT_BUNDLE_IDENTIFIER)" ""
	ifeq "$(CONFIGURATION)" "Debug"
		PRODUCT_BUNDLE_IDENTIFIER=org.adhoc.dt.$(INFOPLIST_KEY_CFBundleDisplayName)
	else
		ifeq "$(CONFIGURATION)" "Release"
			PRODUCT_BUNDLE_IDENTIFIER=org.pak.dt.$(INFOPLIST_KEY_CFBundleDisplayName)
		else
			PRODUCT_BUNDLE_IDENTIFIER=org.adhoc.dt.$(INFOPLIST_KEY_CFBundleDisplayName)
		endif
	endif
endif

ifeq "$(INFOPLIST_KEY_NSHumanReadableCopyright)" ""
	INFOPLIST_KEY_NSHumanReadableCopyright="Copyright (c) 2014-2024 $(PRODUCT_BUNDLE_IDENTIFIER) - Mr. Walls"
endif

ifeq "$(PROJECT_VERSION_MAJOR)" ""
	PROJECT_VERSION_MAJOR=2
endif
ifeq "$(PROJECT_VERSION_MINOR)" ""
	PROJECT_VERSION_MINOR=3
endif
ifeq "$(PROJECT_VERSION_BUILD)" ""
	ifeq "$(CONFIGURATION)" "Debug"
		PROJECT_VERSION_BUILD=1
	else
		ifeq "$(CONFIGURATION)" "Release"
			PROJECT_VERSION_BUILD=3
		else
			PROJECT_VERSION_BUILD=2
		endif
	endif
endif

ifeq "$(CURRENT_PROJECT_VERSION)" ""
	CURRENT_PROJECT_VERSION=$(PROJECT_VERSION_MAJOR).$(PROJECT_VERSION_MINOR)
endif

ifeq "$(DYLIB_COMPATIBILITY_VERSION)" ""
	DYLIB_COMPATIBILITY_VERSION=$(PROJECT_VERSION_MAJOR)
endif

ifeq "$(DYLIB_CURRENT_VERSION)" ""
	DYLIB_CURRENT_VERSION=$(PROJECT_VERSION_MAJOR).$(PROJECT_VERSION_MINOR)
endif

ifeq "$(FRAMEWORK_VERSION)" ""
	FRAMEWORK_VERSION=$(PROJECT_VERSION_MAJOR).$(PROJECT_VERSION_MINOR).$(PROJECT_VERSION_BUILD)
endif

ifeq "$(MARKETING_VERSION)" ""
	MARKETING_VERSION=$(FRAMEWORK_VERSION)
endif

ifeq "$(MODULE_VERSION)" ""
	MODULE_VERSION=$(DYLIB_COMPATIBILITY_VERSION)
endif

ifeq "$(PROJECT_VERSION_DATE)" ""
	PROJECT_VERSION_DATE=`$(COMMAND) date -j +%c%m%d_%H%M%S | grep -oE "[0-9]{8}[_]{1}[0-9]{6}" 2>/dev/null`;
endif

.PHONY: all test clean
