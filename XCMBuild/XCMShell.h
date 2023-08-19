//
//  XCMShell.h
//  xcrunshell
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

#ifndef NSTask_h
#import <XCMBuild.h>
#else

#ifndef XCMShell_h

#if TARGET_OS_OSX

NS_ASSUME_NONNULL_BEGIN

@interface NSTask (XCMShellTask)

+ (nullable NSString *)runCommand:(NSString *)commandToRun;
@end

NS_ASSUME_NONNULL_END


#endif /* TARGET_OS_OSX */
#define XCMShell_h
#endif /* XCMShell_h */

#endif
