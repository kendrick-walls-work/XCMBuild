//
//  XCMProcesses.h
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

#ifndef XCMProcesses_h
#import <XCMBuild/XCMBuild.h>

#if defined(__has_attribute)
#if __has_attribute(blocks)

#if defined(TARGET_OS_OSX) && TARGET_OS_OSX || (defined(TARGET_OS_UNIX) && TARGET_OS_UNIX) || (defined(TARGET_OS_LINUX) && TARGET_OS_LINUX)

#ifndef NSObject
#if defined(__has_include)
#if __has_include(<Foundation/NSObject.h>)
#import <Foundation/NSObject.h>
#else /* !Foundation/NSObject (inner) */
#error Failed to link NSObject features
#endif /* !Foundation/NSObject (outer) */
#endif /* !__has_include */
#endif/* !NSObject */

#ifndef NSString
#if defined(__has_include)
#if __has_include(<Foundation/NSString.h>)
#import <Foundation/NSString.h>
#else /* !Foundation/NSString (inner) */
#error Failed to link NSString features
#endif /* !Foundation/NSString (outer) */
#endif /* !__has_include */
#endif/* !NSString */

#if !defined(XCMProcessesDispatchReasonString)
/// Defined when supporting XCMProcesses activity.
XCMB_IMPORT NSString * const XCMProcessesDispatchReasonString XCMHELPER_NEEDED;
#endif /* !XCMTestCommandArgumentsString */

/// Convenience function to track ``XCMShellTask``s activity entry points.
/// - Parameter reason: A description of what action is taking place.
XCMB_EXPORT id beginXCMProcActivity(NSString * const reason) API_AVAILABLE(macos(10.9), ios(7.0), watchos(2.0), tvos(9.0));

/// Convenience function to track ``XCMShellTask``s activity exit points.
/// - Parameter callerProc: the result from the corisponding call to ``beginXCMProcActivity``
XCMB_EXPORT void endXCMProcActivity(id<NSObject> callerProc) API_AVAILABLE(macos(10.9), ios(7.0), watchos(2.0), tvos(9.0));

#endif /* !TARGET_OS_OSX */

#endif /* !__has_blocks */
#endif/* !__has_attribute */

// continue logic in include from .m

#endif /* XCMProcesses_h */
