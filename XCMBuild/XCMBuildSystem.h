//
//  XCMBuildSystem.h
//  XCMBuild
//
//	Copyright (c) 2023 Mr.Walls
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.

#ifndef XCMBuildSystem_h
#ifndef XCMBuild_h
#if defined(__has_include)
#if __has_include(<XCMBuild/XCMBuild.h>)
/*! @parseOnly */
#define XCMBuild_h "<XCMBuild/XCMBuild.h> (XCMBuildSystem)"
#import <XCMBuild/XCMBuild.h>
#endif
#endif /* !__has_include */
#ifndef XCMBuild_h
/*! @parseOnly */
#define XCMBuild_h "XCMBuild.h (XCMBuildSystem)"
#import "XCMBuild.h"
#endif /* XCMBuild_h (inner) */
#if defined(__clang__)
#pragma clang final(XCMBuild_h)
#endif /* !__clang__ */
#endif /* XCMBuild_h (outer) */

#if TARGET_OS_OSX

@class NSBundle, NSString;

NS_HEADER_AUDIT_BEGIN(nullability, sendability)

//! XCMBuildSystem allows building projects via makefiles with the targets "build" "install" "clean" "test" "uninstall"
@interface XCMBuildSystem : NSBundle

#if defined(__clang__)
#pragma mark *** XCMBuildSystem ***
#endif /* !__clang__ */

- (nullable NSString *)pathForAuxiliaryExecutable:(NSString *)executableName NS_REQUIRES_SUPER;

@end

NS_HEADER_AUDIT_END(nullability, sendability)

#endif /* TARGET_OS_OSX */
#define XCMBuildSystem_h "XCMBuildSystem.h"
#endif /* XCMBuildSystem_h */
