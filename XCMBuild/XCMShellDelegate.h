//
//  XCMShellDelegate.h
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
// CC-BY-SA4: https://stackoverflow.com/questions/45196857/run-a-shell-command-on-objective-c-and-simultaneously-get-output?rq=3

#ifndef XCMShellDelegate_h
#ifndef XCMBuild_h
#if defined(__has_include)
#if __has_include(<XCMBuild/XCMBuild.h>)
///Defined when XCMBuild is Linked
#define XCMBuild_h "<XCMBuild/XCMBuild.h> (XCMShellDelegate)"
#import <XCMBuild/XCMBuild.h>
#endif
#endif /* !__has_include */
#ifndef XCMBuild_h
///Defined when XCMBuild.h is imported
#define XCMBuild_h "XCMBuild.h (XCMShellDelegate)"
#import "XCMBuild.h"
#endif /* XCMBuild_h (inner) */
#if defined(__clang__)
#pragma clang final(XCMBuild_h)
#endif /* !__clang__ */
#endif /* XCMBuild_h (outer) */

#if defined(TARGET_OS_OSX) && TARGET_OS_OSX || TARGET_OS_UNIX || TARGET_OS_LINUX

@class NSMethodSignature, NSInvocation, NSArray<ObjectType>, NSDictionary<KeyType, ObjectType>, NSTask, NSString, NSObject, NSPipe;

NS_HEADER_AUDIT_BEGIN(nullability, sendability)

@interface XCMShellDelegate: NSObject {
}
#if defined(__clang__)
#pragma mark *** XCMShellDelegate ***
#endif /* !__clang__ */
@property (nullable, readwrite, retain) NSPipe *outputPipe;
/// Attaches to and captures the `standardOutput` of a given task process. The captured output is printed out asyncronously.
/// TODO: Add usage example here.
/// - Parameter process: An `NSTask` to capture. The given `process` _MUST_ not have been launched or an error will be raised.
-(void)captureStandardOutput:(NSTask *)process;
@end

NS_HEADER_AUDIT_END(nullability, sendability)

#endif /* !TARGET_OS_OSX */
/// Defined whenever the ``XCMShellDelegate`` is loaded.
#define XCMShellDelegate_h "XCMShellDelegate.h"
#endif /* XCMShellDelegate_h */
