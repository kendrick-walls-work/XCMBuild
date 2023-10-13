//
//  XCMProcesses.h
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

#ifndef XCMProcesses_h
#ifndef XCMBuild_h
#if defined(__has_include)
#if __has_include(<XCMBuild/XCMBuild.h>)
///Defined when XCMBuild is Linked
#define XCMBuild_h "<XCMBuild/XCMBuild.h> (XCMProcesses)"
#import <XCMBuild/XCMBuild.h>
#endif
#endif /* !__has_include */
#ifndef XCMBuild_h
///Defined when XCMBuild.h is imported
#define XCMBuild_h "XCMBuild.h (XCMProcesses)"
#import "XCMBuild.h"
#endif /* XCMBuild_h (inner) */
#if defined(__clang__) && __clang__
#pragma clang final(XCMBuild_h)
#endif /* !__clang__ */
#endif /* XCMBuild_h (outer) */

#if defined(TARGET_OS_OSX) && TARGET_OS_OSX || (defined(TARGET_OS_UNIX) && TARGET_OS_UNIX) || defined(TARGET_OS_LINUX) && TARGET_OS_LINUX

#if defined(__has_attribute)
#if __has_attribute(used)
#if __has_attribute(weak_import)
#ifndef XCMProcessesDispatchReasonString
/// Defined when supporting XCMProcesses activity.
extern NSString * const XCMProcessesDispatchReasonString __attribute__((weak_import));
#endif /* !XCMTestCommandArgumentsString */
#else /* !__attribute__ ((weak_import)) */
#ifndef XCMProcessesDispatchReasonString
#warning No support for weak import of XCMProcesses
/// Defined when supporting XCMProcesses activity.
extern NSString * const XCMProcessesDispatchReasonString;
#endif /* !XCMProcessesDispatchReasonString */
#endif /* END ((weak_import)) */
#endif /* !__attribute__ ((used)) */
#endif /* !__has_attribute */

@class NSMethodSignature, NSInvocation, NSArray<ObjectType>, NSDictionary<KeyType, ObjectType>, NSString, NSObject, NSProcessInfo;

#if defined(__has_attribute)
#if __has_attribute(blocks)

#if defined(MAC_OS_X_VERSION_MAX_ALLOWED) && MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_9

/// Convenience function to track ``XCMShellTask``s activity entry points.
/// - Parameter reason: A description of what action is taking place.
extern id beginXCMProcActivity(NSString * const reason) API_AVAILABLE(macos(10.9), ios(7.0), watchos(2.0), tvos(9.0));

/// Convenience function to track ``XCMShellTask``s activity exit points.
/// - Parameter callerProc: the result from the corisponding call to ``beginXCMProcActivity``
extern void endXCMProcActivity(id<NSObject> callerProc) API_AVAILABLE(macos(10.9), ios(7.0), watchos(2.0), tvos(9.0));

#endif
#endif /* !__attribute__ (blocks) */
#endif /* !__has_attribute */

#endif /* !TARGET_OS_OSX */
/// Defined whenever the ``XCMProcesses`` is loaded.
#define XCMProcesses_h "XCMProcesses.h"
#endif /* XCMProcesses_h */
