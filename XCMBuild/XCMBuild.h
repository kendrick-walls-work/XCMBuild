/*!
 * @file XCMBuild.h
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
 * @framework XCMBuild
 * @version 2.1
 * @abstract TODO
 * @discussion
 * It is worth noting: `XCM` (including `XCMBuild`) the unsafe ``TARGET_OS_WIN32`` (and all Windows and/or 32-bit architechtures)
 * for all compat versions 2+ due to the expectation of `64-bit *nix` runtimes.
 *
*/

#if defined(__is_target_environment)
#if __is_target_environment(simulator)
#if defined(__clang_tapi__) && __clang_tapi__
///Defined whenever ``XCMBuild`` is imported.
#define XCMB_XCMBuild_h "XCMBuild.tbd"
#error UNSUPPORTED BUILD
#endif /* !__clang_tapi__ */
#endif /* !simulator */
#endif

#ifndef XCMB_XCMBuild_h
#if defined(__clang__)
#pragma mark *** XCMBuildHeader ***
#endif /* !__clang__ */
///Defined whenever ``XCMBuild`` is imported.
#define XCMB_XCMBuild_h "XCMBuild.h"

#if defined(__has_include)
#if __has_include(<objc/objc.h>)
#import <objc/objc.h>
#if __has_include(<objc/NSObject.h>)
#import <objc/NSObject.h>
#endif /* !__has_include(<objc/NSObject.h>) */
#if __has_include(<objc/Object.h>)
#import <objc/Object.h>
#endif /* !__has_include(<objc/Object.h>) */
#if __has_include(<objc/NSObjCRuntime.h>)
#import <objc/NSObjCRuntime.h>
#endif /* !__has_include(<objc/NSObjCRuntime.h>) */
#endif /* !__has_include(<objc/objc.h>) */
#endif /* !__has_include_ObjC */

#if defined(__has_include)
#if __has_include(<stdio.h>)
#import <stdio.h>
#if __has_include(<stdlib.h>)
#import <stdlib.h>
#endif /* !__has_include(<stdlib.h>) */
#endif /* !__has_include(<stdio.h>) */
#endif /* !__has_include_C */

#if defined(__has_include)
#if __has_include(<CoreFoundation/CoreFoundation.h>)
#import <CoreFoundation/CoreFoundation.h>
#endif /* !__has_include(<CoreFoundation/CoreFoundation.h>) */
#endif /* !__has_include_Core */

#ifndef NSLog
#if defined(__has_include)
#if __has_include(<Foundation/NSObjCRuntime.h>)
#import <Foundation/NSObjCRuntime.h>
#endif /* !__has_include(<Foundation/NSObjCRuntime.h>) */
#endif /* !__has_include_Foundation_ObjC */
#endif /* !NSLog */

#ifdef TARGET_OS_WIN32
#if TARGET_OS_WIN32
#warning UNSUPPORTED BUILD
#endif
///Important: ``XCMBuild`` is explicidly incompatible with the target ``TARGET_OS_WIN32``.
///
///It is worth noting: `XCM` (including ``XCMBuild``) are incompatible with the unsafe ``TARGET_OS_WIN32`` (and all
/// Windows and/or 32-bit architechtures) for all compat versions 2+ due to the expectation of `64-bit *nix` runtimes.
#undef TARGET_OS_WIN32
#endif

#if defined(__clang__)
#pragma mark *** XCMBuild ***
#endif /* !__clang__ */

#ifndef NSTask_h
// #import <Foundation/Foundation.h>
#import <Foundation/NSObject.h>
#import <Foundation/NSData.h>
#import <Foundation/NSString.h>
#import <Foundation/NSArray.h>
#import <Foundation/NSProcessInfo.h>
#import <Foundation/NSFileHandle.h>
#import <Foundation/NSTask.h>
/// Defined whenever `<Foundation/NStask.h>` is imported.
#define NSTask_h "NSTask.h"
#endif /* NSTask_h */

/** After NSObjeect  **/

#ifndef XCMB_NSDebug_h
#if defined(__has_include)
#if __has_include(<Foundation/NSDebug.h>)
#import <Foundation/NSDebug.h>
#endif /* !__has_include(<Foundation/NSDebug.h>) */
#endif /* !__has_include_Foundation_Debug */
/// Defined whenever `<Foundation/NSDebug.h>` is imported.
#define XCMB_NSDebug_h (int)(1)
#endif /* XCMB_NSDebug_h*/

#ifndef NSNSBundle_h
// #import <Foundation/Foundation.h>
#import <Foundation/NSDictionary.h>
#import <Foundation/NSSet.h>
#import <Foundation/NSProgress.h>
#import <Foundation/NSNotification.h>
#import <Foundation/NSBundle.h>
/// Defined whenever `<Foundation/NSBundle.h>` is imported.
#define NSBundle_h "NSBundle.h"
#endif /* NSBundle_h */

#if defined(FOUNDATION_EXPORT)
/// Project version number for ``XCMBuild``.
FOUNDATION_EXPORT double XCMBuildVersionNumber;

/// Project version string for ``XCMBuild``.
FOUNDATION_EXPORT const unsigned char XCMBuildVersionString[];
#else
__BEGIN_DECLS
extern double XCMBuildVersionNumber;
extern const unsigned char XCMBuildVersionString[];
__END_DECLS
#endif /* end DECLS */

#ifndef NSPipe_h
#if defined(__has_include)
#if __has_include(<Foundation/NSRange.h>)
#import <Foundation/NSRange.h>
#endif /* !__has_include(<Foundation/NSRange.h>) */
#if __has_include(<Foundation/NSException.h>)
#import <Foundation/NSException.h>
#endif /* !__has_include(<Foundation/NSException.h>) */
#if __has_include(<Foundation/NSNotification.h>)
#import <Foundation/NSNotification.h>
#endif /* !__has_include(<Foundation/NSNotification.h>) */
#if __has_include(<Foundation/NSRunLoop.h>)
#import <Foundation/NSRunLoop.h>
#endif /* !__has_include(<Foundation/NSRunLoop.h>) */
#if __has_include(<Foundation/NSPipe.h>)
#import <Foundation/NSPipe.h>
#endif /* !__has_include(<Foundation/NSPipe.h>) */
#endif /* !__has_include_Foundation_Pipe */
/// Defined whenever `<Foundation/NSPipe.h>` is imported.
#define NSPipe_h "NSPipe.h"
#endif
// In this header, you should import all the public headers of your framework using statements like #import <XCMBuild/PublicHeader.h>
#if defined(__clang__)
#pragma mark *** XCMBuild Framework ***
#endif /* !__clang__ */
// To avoid problem with non-clang compilers not having this macro.
#if defined(__has_include)

#if __has_include(<XCMBuild/XCMShellDelegate.h>)
#ifndef XCMB_XCMShellDelegate_h
/// Defined whenever `<XCMBuild/XCMShellDelegate.h>` is imported from the umbrella header.
#define XCMB_XCMShellDelegate_h "<XCMBuild/XCMShellDelegate.h> (XCMBuild Core)"
#import <XCMBuild/XCMShellDelegate.h>
#endif /* !XCMB_XCMShellDelegate_h */
#endif

#if __has_include(<XCMBuild/XCMShell.h>)
#ifndef XCMB_XCMShell_h
/// Defined whenever `<XCMBuild/XCMShell.h>` is imported from the umbrella header.
#define XCMB_XCMShell_h "<XCMBuild/XCMShell.h> (XCMBuild Core)"
#import <XCMBuild/XCMShell.h>
#endif /* !XCMB_XCMShell_h */
#endif

#if __has_include(<XCMBuild/XCMBuildSystem>)
#ifndef XCMB_XCMBuildSystem_h
/// Defined whenever `<XCMBuild/XCMBuildSystem.h>` is imported from the umbrella header.
#define XCMB_XCMBuildSystem_h "<XCMBuild/XCMBuildSystem.h> (XCMBuild Core)"
#import <XCMBuild/XCMBuildSystem.h>
#endif /* !XCMB_XCMBuildSystem_h */
#endif

#if __has_include(<XCMBuild/XCMTest.h>)
#ifndef XCMB_XCMTest_h
/// Defined whenever `<XCMBuild/XCMTest.h>` is imported from the umbrella header.
#define XCMB_XCMTest_h "<XCMBuild/XCMTest.h> (XCMBuild Core)"
#import <XCMBuild/XCMTest.h>
#endif /* !XCMB_XCMTest_h */
#endif

#else /* !__has_include */

#ifndef XCMB_XCMShellDelegate_h
/// Defined whenever `<XCMBuild/XCMShellDelegate.h>` is included.
#define XCMB_XCMShellDelegate_h "XCMShellDelegate.h"
#import "XCMShellDelegate.h"
#endif /* !XCMB_XCMShellDelegate_h */

#ifndef XCMB_XCMShell_h
/// Defined whenever `<XCMBuild/XCMShell.h>` is included.
#define XCMB_XCMShell_h "XCMShell.h"
#import "XCMShell.h"
#endif /* !XCMB_XCMShell_h */

#ifndef XCMB_XCMBuildSystem_h
/// Defined whenever `<XCMBuild/XCMBuildSystem.h>` is included.
#define XCMB_XCMBuildSystem_h "XCMBuildSystem.h"
#import "XCMBuildSystem.h"
#endif /* !XCMB_XCMBuildSystem_h */

#ifndef XCMB_XCMTest_h
/// Defined whenever `<XCMBuild/XCMB_XCMTest_h.h>` is included.
#define XCMB_XCMTest_h "XCMTest.h"
#import "XCMTest.h"
#endif /* !XCMB_XCMTest_h */

#endif /* END UMBRELLA include */
#endif /* !XCMB_XCMBuild_h */

/*!
 * @abstract This list provides a summary of the guidelines for improving specific aspects of a dynamic library:
 * Ease of use
 * @TODO: Reduce the number of symbols a library exports.
 * @TODO: Provide unique names to public interfaces.
 * Ease of maintenance
 * @TODO: Export accessor functions to variables. Don’t export variables.
 * @TODO: Implement public interfaces as wrappers to internal, private interfaces.
 * Performance
 * @TODO: Minimize the number of references to symbols in dependent libraries. Use `dlsym(RTLD_GLOBAL, <symbol_name>)` to obtain the address of symbols exported by dependent libraries when they are needed.
 * @TODO: Minimize the number of dependent libraries. Consider loading libraries with `dlopen` when absolutely necessary. Remember to close the library with `dlclose` when done.
 * @TODO: Implement public interfaces as wrappers to internal, private interfaces.
 * Compatibility
 * @TODO: Export symbols as weakly linked symbols.
 * @TODO: Encode a library’s major version number in its filename.
*/
