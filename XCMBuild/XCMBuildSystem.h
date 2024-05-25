//
//  XCMBuildSystem.h
//  XCMBuild
//
//	Copyright (c) 2023-2024 Mr.Walls
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
#ifndef XCMB_XCMBuild_h
#if defined(__has_include)
#if __has_include(<XCMBuild/XCMBuild.h>)
///Defined when ``XCMBuildSystem`` re-imports `XCMBuild.h`.
#define XCMBuild_h "<XCMBuild/XCMBuild.h> (XCMBuildSystem)"
#import <XCMBuild/XCMBuild.h>
#endif
#endif /* !__has_include */
#ifndef XCMB_XCMBuild_h
///Defined when ``XCMBuildSystem`` includes the `XCMBuild.h` header.
#define XCMB_XCMBuild_h "XCMBuild.h (XCMBuildSystem)"
#import "XCMBuild.h"
#endif /* XCMB_XCMBuild_h (inner) */
#if defined(__clang__) && __clang__
#pragma clang final(XCMB_XCMBuild_h)
#endif /* !__clang__ */
#endif /* XCMB_XCMBuild_h (outer) */

#if defined(TARGET_OS_OSX) && TARGET_OS_OSX || (defined(TARGET_OS_UNIX) && TARGET_OS_UNIX) || defined(TARGET_OS_LINUX) && TARGET_OS_LINUX

@class NSMethodSignature, NSInvocation, NSArray<ObjectType>, NSDictionary<KeyType, ObjectType>, NSString, NSObject, NSBundle;

NS_HEADER_AUDIT_BEGIN(nullability, sendability)
#if !defined(XCMBuildSystem)
XCMB_EXPORT
/// XCMBuildSystem allows building projects via makefiles with the targets `build`, `install`, `clean`, `test`, `uninstall`, etc.
@interface XCMBuildSystem: NSBundle {
}
/// Returns the string describing the object in the debugger.
/// See  `NSObject/description` for details.
/// ``XCMBuildSystem``'s implementation of this method simply prints the name of the class.
///
/// - Returns: The `NSString` that represents the contents of the ``XCMBuildSystem`` class.
+ (NSString *_Null_unspecified)debugDescription;
/// See `NSBundle/pathForAuxiliaryExecutable:` for Details.
///
/// - Parameters:
///   - executableName: The build system `Action`.
///     Namely one of `clean`, `build`, `analyze`, `profile`, `test`, `install`, or `archive`.
///     Optionally prefixed with `un`, `pre-` or `post-`.
///
/// - Returns: The `NSString` containing the full path to the requested `excutable` if available; otherwise `nil`.
- (nullable NSString *)pathForAuxiliaryExecutable:(NSString *_Null_unspecified)executableName NS_REQUIRES_SUPER;
@end
#endif

NS_HEADER_AUDIT_END(nullability, sendability)

#endif /* TARGET_OS_OSX */
///Defined whenever the ``XCMBuildSystem`` is loaded.
#define XCMBuildSystem_h "XCMBuildSystem.h"
#endif /* XCMBuildSystem_h */
