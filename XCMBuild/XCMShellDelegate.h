//
//  XCMShellDelegate.h
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
// CC-BY-SA4: https://stackoverflow.com/questions/45196857/run-a-shell-command-on-objective-c-and-simultaneously-get-output?rq=3

#ifndef XCMShellDelegate_h
#ifndef XCMB_XCMBuild_h
#if defined(__has_include)
#if __has_include(<XCMBuild/XCMBuild.h>)
///Defined when ``XCMShellDelegate`` re-imports `XCMBuild.h`.
#define XCMBuild_h "<XCMBuild/XCMBuild.h> (XCMShellDelegate)"
#import <XCMBuild/XCMBuild.h>
#endif
#endif /* !__has_include */
#ifndef XCMB_XCMBuild_h
///Defined when ``XCMShellDelegate`` includes the `XCMBuild.h` header.
#define XCMB_XCMBuild_h "XCMBuild.h (XCMShellDelegate)"
#import "XCMBuild.h"
#endif /* XCMB_XCMBuild_h (inner) */
#if defined(__clang__) && __clang__
#pragma clang final(XCMB_XCMBuild_h)
#endif /* !__clang__ */
#endif /* XCMB_XCMBuild_h (outer) */

#if defined(TARGET_OS_OSX) && TARGET_OS_OSX || (defined(TARGET_OS_UNIX) && TARGET_OS_UNIX) || defined(TARGET_OS_LINUX) && TARGET_OS_LINUX

@class NSMethodSignature, NSInvocation, NSArray<ObjectType>, NSDictionary<KeyType, ObjectType>, NSSet, NSTask, NSPipe, NSString, NSObject;

NS_HEADER_AUDIT_BEGIN(nullability, sendability)

#if !defined(XCMShellDelegate)

XCMB_EXPORT
@interface XCMShellDelegate: NSObject {
}
/// The output capture `NSPipe`.`
@property (nullable, readwrite, retain) NSPipe *outputPipe;
/// The error capture `NSPipe`.`
@property (nullable, readwrite, retain) NSPipe *errorPipe;
/// The output capture handler block.
@property (nullable, readwrite, strong) id<NSObject> outputHandler;
/// The error capture handler block.
@property (nullable, readwrite, strong) id<NSObject> errorHandler;
/// Attaches to and captures the `standardOutput` of a given task process. The captured output is printed out asynchronously.
/// TODO: Add usage example here.
/// - Parameter process: An `NSTask` to capture. The given `process` _MUST_ not have been launched or an error will be raised.
-(void)captureStandardOutput:(NSTask *)process;
/// Attaches to and captures the `standardError` of a given task process. The captured output is printed out asynchronously.
/// TODO: Add usage example here.
/// - Parameter process: An `NSTask` to capture. The given `process` _MUST_ not have been launched or an error will be raised.
-(void)captureStandardError:(NSTask *)process;

/// Removes the ``outputHandler`` from the current ``outputPipe``.
-(void)removeOutputCaptures;
/// Removes the ``errorHandler`` from the current ``errorPipe``.
-(void)removeErrorCaptures;
-(void)removeAllCaptures;

@end
#endif
NS_HEADER_AUDIT_END(nullability, sendability)

#endif /* !TARGET_OS_OSX */

/// Defined whenever the ``XCMShellDelegate`` is loaded.
#define XCMShellDelegate_h "XCMShellDelegate.h"
#endif /* XCMShellDelegate_h */
