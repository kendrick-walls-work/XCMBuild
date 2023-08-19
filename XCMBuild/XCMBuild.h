//
//  XCMBuild.h
//  XCMBuild

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

#ifndef NSLog
#import <Foundation/NSObjCRuntime.h>
#endif


#ifndef NSTask_h
// #import <Foundation/Foundation.h>
#import <Foundation/NSObject.h>
#import <Foundation/NSData.h>
#import <Foundation/NSString.h>
#import <Foundation/NSArray.h>
#import <Foundation/NSProcessInfo.h>
#import <Foundation/NSFileHandle.h>
//#import <Foundation/NSProcessInfo.h>
#import <Foundation/NSTask.h>
#define NSTask_h "NSTask.h"
#endif /* NSObjCRuntime_h */


#if defined(FOUNDATION_EXPORT)

//! Project version number for XCMBuild.
FOUNDATION_EXPORT double XCMBuildVersionNumber;

//! Project version string for XCMBuild.
FOUNDATION_EXPORT const unsigned char XCMBuildVersionString[];

#else
extern double XCMBuildVersionNumber;
extern const unsigned char XCMBuildVersionString[];
#endif
// In this header, you should import all the public headers of your framework using statements like #import <XCMBuild/PublicHeader.h>

#ifndef XCMShell_h
#import "XCMShell.h"
#endif
