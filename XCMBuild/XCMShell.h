//
//  XCMShell.h
//  XCMShellTask
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

#ifndef XCMShell_h
#ifndef XCMBuild_h
#if defined(__has_include)
#if __has_include(<XCMBuild/XCMBuild.h>)
/*! @parseOnly */
#define XCMBuild_h "<XCMBuild/XCMBuild.h> (XCMShellTask)"
#import <XCMBuild/XCMBuild.h>
#endif
#endif /* !__has_include */
#ifndef XCMBuild_h
/*! @parseOnly */
#define XCMBuild_h "XCMBuild.h (XCMShellTask)"
#import "XCMBuild.h"
#endif /* XCMBuild_h (inner) */
#if defined(__clang__)
#pragma clang final(XCMBuild_h)
#endif /* !__clang__ */
#endif /* XCMBuild_h (outer) */

#if TARGET_OS_OSX

@class NSArray<ObjectType>, NSDictionary<KeyType, ObjectType>, NSTask, NSString, NSObject;

NS_HEADER_AUDIT_BEGIN(nullability, sendability)

//! XCMShellTask allows running a subshell as a task.
@interface XCMShellTask : NSObject

#if defined(__clang__)
#pragma mark *** XCMShellTask ***
#endif /* !__clang__ */

+ (nullable NSString *)runCommand:(NSString *)commandToRun;

@end

NS_HEADER_AUDIT_END(nullability, sendability)

#endif /* !TARGET_OS_OSX */

#define XCMShell_h "XCMShell.h"
#endif /* XCMShell_h */
