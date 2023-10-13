/*!
 * @file XCMTest/XCMTest.h
 * @copyright Copyright (c) 2023 Mr.Walls
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
 * @framework XCMBuild.XCMTest
 * @version 2.1
 *
 * @abstract
 * TODO
 *
 * @discussion
 * Blah blah blah need @"<__XCMTest_Error_PLACEHOLDER__>"; and stuff.
*/

#ifndef XCMTest_h
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
#if defined(__clang__) && __clang__
#pragma clang final(XCMBuild_h)
#endif /* !__clang__ */
#endif /* XCMBuild_h (outer) */

#if defined(TARGET_OS_OSX) && TARGET_OS_OSX || (defined(TARGET_OS_UNIX) && TARGET_OS_UNIX) || (defined(TARGET_OS_LINUX) && TARGET_OS_LINUX)

#if defined(__has_attribute)
#if __has_attribute(used)
#if __has_attribute(weak_import)
#ifndef XCMTestCommandArgumentsString
/// Use this to Makefile Testing cmdline string for XCMTest.
extern NSString * const XCMTestCommandArgumentsString __attribute__((weak_import));
#endif /* !XCMTestCommandArgumentsString */
#else /* !__attribute__ ((weak_import)) */
#ifndef XCMTestCommandArgumentsString
#warning No support for weak import of XCMTest
/// Use this to Makefile Testing cmdline string for XCMTest.
extern NSString * const XCMTestCommandArgumentsString;
#endif /* !XCMTestCommandArgumentsString */
#endif /* END ((weak_import)) */
#endif /* !__attribute__ ((used)) */
#endif /* !__has_attribute */

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
/*! @parseOnly */
#define XCMTest_h "XCMTest.h"

#endif /* !TARGET_OS_OSX */

#endif /* XCMTest_h */
