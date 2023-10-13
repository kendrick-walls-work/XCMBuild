//
//  Compat.h
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

///>important
///> The `Compat.h` file contains code that is under the LLVM APACHE Licence, As described here:
///> https://www.llvm.org/docs/DeveloperPolicy.html#new-llvm-project-license-framework
///> and is hearby Awknowleged.
/// See https://clang.llvm.org/docs/LanguageExtensions.html#builtin-unpredictable
///
#if defined(__clang__) && __clang__
#pragma mark - Compatibility
#endif /* !__clang__ */

#ifndef Compat_h
#define Compat_h

#if defined(__clang__) && __clang__
#ifndef __has_builtin
#warning Something is unusual. Compiler Gods Help You.
#endif /* !CONFUSED MACRO */
#else
/// BELOW FROM https://clang.llvm.org/docs/LanguageExtensions.html#feature-checking-macros
#ifndef __has_builtin         // Optional of course.
#define __has_builtin(x) 0  // Compatibility with non-clang compilers.
#endif
// ABOVE FROM https://clang.llvm.org/docs/LanguageExtensions.html#feature-checking-macros
#endif /* !__clang__ */

#if defined(__clang__) && __clang__
#ifndef __has_feature
#error Something is missing. Compiler/Target unsupported.
#endif /* !PANIC MACRO */
#else
/// BELOW FROM https://clang.llvm.org/docs/LanguageExtensions.html#feature-checking-macros
#ifndef __has_feature         // Optional of course.
#define __has_feature(x) 0  // Compatibility with non-clang compilers.
#endif
#ifndef __has_extension
#define __has_extension __has_feature // Compatibility with pre-3.0 compilers.
#endif
// ABOVE FROM https://clang.llvm.org/docs/LanguageExtensions.html#feature-checking-macros
#endif /* !__clang__ */

/// BELOW FROM https://clang.llvm.org/docs/LanguageExtensions.html#has-attribute
#ifndef __has_attribute         // Optional of course.
#define __has_attribute(x) 0  // Compatibility with non-clang compilers.
#endif
// ABOVE FROM https://clang.llvm.org/docs/LanguageExtensions.html#has-attribute

#if defined(__clang__) && __clang__
#pragma mark - XCMBuild Specific
#else /* just in case */
#define NO_ANSI_KEYWORDS 1
#endif /* !__clang__ */

#if !defined(known_unpredictable)
#if __has_builtin(__builtin_unpredictable)
#define known_unpredictable(A) __builtin_unpredictable(A)
#elif !(__has_builtin(__builtin_unpredictable))
// combine the args to perform a type of menomic
#define __XCMB_JOINED__(A,B) A##B
// mark each use with counter to ensure some seperation
#define __XCMB_unpredictable_IMPL__(A,L) ({ __typeof__(A) __XCMB_JOINED__(__a,L) = (A); __XCMB_JOINED__(__a,L); })
#define known_unpredictable(A) __XCMB_unpredictable_IMPL__(A,__COUNTER__)
#endif /* !__builtin_unpredictable */
#endif /* known_unpredictable */

#if defined(__has_include)
#if defined(__clang__) && __clang__
#pragma mark - Imports
#endif /* !__clang__ */
#if __has_include(<stdio.h>)
#import <stdio.h>
#if __has_include(<stdlib.h>)
#import <stdlib.h>
#endif /* !__has_include(<stdlib.h>) */
#endif /* !__has_include(<stdio.h>) */

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

#endif /* Compat_h */
