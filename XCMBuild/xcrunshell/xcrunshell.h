/*!
 * @file xcrunshell/xcrunshell.h
 * @copyright Copyright (c) 2023-2024 Mr.Walls
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * @framework XCMBuild
 * @version 2.1
 *
 * @abstract
 * TODO
 *
 */


#ifndef XCMBuild_h
#if defined(__has_include)
#if __has_include(<XCMBuild/XCMBuild.h>)
/*! @parseOnly */
#define XCMBuild_h "<XCMBuild/XCMBuild.h> (XCRunShell)"
#import <XCMBuild/XCMBuild.h>
#endif
#endif /* !__has_include */
#ifndef XCMBuild_h
/*! @parseOnly */
#define XCMBuild_h "XCMBuild.h (XCRunShell)"
#import "XCMBuild.h"
#endif /* XCMBuild_h (inner) */
#if defined(__clang__) && __clang__
#pragma clang final(XCMBuild_h)
#endif /* !__clang__ */
#endif /* XCMBuild_h (outer) */

#ifndef _XCRS_MINARGS
#define _XCRS_MINARGS
/// Minimum arguments expected.
const int XCRS_MINARGS = 1;
#endif

#ifndef _XCMB_IFS
/// Internal Feild Seporator for xcrunshell.
XCMB_IMPORT NSString *_Null_unspecified const XCMB_IFS XCMHELPER_NEEDED;
#endif /* !XCMB_IFS */

#ifndef XCMShellDelegate_h
#if defined(__has_include)
#if __has_include(<XCMBuild/XCMShellDelegate.h>)
#define XCMShellDelegate_h "<XCMBuild/XCMShellDelegate.h> (XCRunShell)"
#import <XCMBuild/XCMShellDelegate.h>
#endif
#endif /* !__has_include */
#ifndef XCMShellDelegate_h
#define XCMShellDelegate_h "XCMShellDelegate.h (XCRunShell)"
#import "XCMShellDelegate.h"
#endif /* XCMShellDelegate_h (inner) */
#if defined(__clang__) && __clang__
#pragma clang final(XCMShellDelegate_h)
#endif /* !__clang__ */
#endif /* XCMShellDelegate_h (outer) */

#ifndef XCMShell_h
#if defined(__has_include)
#if __has_include(<XCMBuild/XCMShell.h>)
#define XCMShell_h "<XCMBuild/XCMShell.h> (XCRunShell)"
#import <XCMBuild/XCMShell.h>
#endif
#endif /* !__has_include */
#ifndef XCMShell_h
#define XCMShell_h "XCMShell.h (XCRunShell)"
#import "XCMShell.h"
#endif /* XCMShell_h (inner) */
#if defined(__clang__) && __clang__
#pragma clang final(XCMShell_h)
#endif /* !__clang__ */
#endif /* XCMShell_h (outer) */

XCMB_IMPORT
/// Parse comandline arguments for the given command.
/// - Parameters:
///   - argsv: the NSArray of  non-zero index arguments from `[[NSProcessInfo processInfo] arguments]
NSString *_Nullable parseArguments(NSArray *_Nullable argsv);

#if defined(XCRS_RUNSHELL_MAIN_MARK)
#if XCRS_RUNSHELL_MAIN_MARK < __INCLUDE_LEVEL__ && XCRS_RUNSHELL_MAIN_MARK < 1 && __INCLUDE_LEVEL__ <= 2

/// Used to handle the testing of a project built with the `XCMBuild` system. Namely runs the equivalent of `make test`
///
/// - Returns: `0` (exit-code of zero) if the test reported back without errors. Otherwise Returns a value greater than `0` in the case
/// - Parameters:
///   - argc: main argument count input. Ignored here.
///   - argv: main arguments from input. Ignored here.
int main(int argc, const char * argv[]);
#endif
#endif
