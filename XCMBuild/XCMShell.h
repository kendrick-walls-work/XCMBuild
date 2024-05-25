//
//  XCMShell.h
//  XCMShellTask
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

#ifndef XCMShell_h
#ifndef XCMB_XCMBuild_h
#if defined(__has_include)
#if __has_include(<XCMBuild/XCMBuild.h>)
///Defined when ``XCMShellTask`` re-imports `XCMBuild.h`.
#define XCMBuild_h "<XCMBuild/XCMBuild.h> (XCMShellTask)"
#import <XCMBuild/XCMBuild.h>
#endif
#endif /* !__has_include */
#ifndef XCMB_XCMBuild_h
///Defined when ``XCMShellTask`` includes the `XCMBuild.h` header.
#define XCMB_XCMBuild_h "XCMBuild.h (XCMShellTask)"
#import "XCMBuild.h"
#endif /* XCMB_XCMBuild_h (inner) */
#if defined(__clang__) && __clang__
#pragma clang final(XCMB_XCMBuild_h)
#endif /* !__clang__ */
#endif /* XCMB_XCMBuild_h (outer) */

#if defined(TARGET_OS_OSX) && TARGET_OS_OSX || (defined(TARGET_OS_UNIX) && TARGET_OS_UNIX) || defined(TARGET_OS_LINUX) && TARGET_OS_LINUX

@class NSMethodSignature, NSInvocation, NSArray<ObjectType>, NSDictionary<KeyType, ObjectType>, NSString, NSObject;

NS_HEADER_AUDIT_BEGIN(nullability, sendability)

#if !defined(XCMShellTask)
XCMB_EXPORT
/// Trivial delegate class for `NSTask`s to implement conviance constructors.
/// ``XCMShellTask`` allows running a subshell as a task, thus simplifing the overhead of trivial invocations of `NSTask`.
@interface XCMShellTask: NSObject {
}
/// At the core of the ``XCMShellTask`` is the ability to spawn subtasks to use various system tools like `make`
///
///**Usage:**
///```objectivec
///// set the commandTextToRun ...
///NSString * commandTextToRun = @"echo Hello World;";
///// ... and run the command and collect the output
///BOOL console = [XCMShellTask runCommand:commandTextToRun];
///```
///
/// - Parameters:
///   - commandToRun: The shell command text to perform as an `NSString`.
/// - Returns: The `exit code` of the resulting `task` as an `BOOL`.
+ (BOOL)runCommand:(NSString *)commandToRun;
@end
#endif

NS_HEADER_AUDIT_END(nullability, sendability)

#endif /* !TARGET_OS_OSX */
/// Defined whenever the ``XCMShellTask`` is loaded.
#define XCMShell_h "XCMShell.h"
#endif /* XCMShell_h */
