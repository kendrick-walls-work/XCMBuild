/*!
 * @file XCMBuildSystem.m
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
 */

//extern const char* XCMTestCommandArgumentsString __attribute__((weak_import));
#include "XCMBuildSystem.h"

#ifndef XCMB_FWD_INVOKE_ENABLED
#if defined(__has_include)
#if __has_include(<Foundation/NSInvocation.h>)
/// Defined when the ``NSObject/forwardInvocation:(_:invocation:)`` is implemented.
#define XCMB_FWD_INVOKE_ENABLED YES
#import <Foundation/NSInvocation.h>
#else
#define XCMB_FWD_INVOKE_ENABLED NO
#endif /* !NSInvocation */
#endif /* !__has_include */
#endif /* !XCMB_FWD_INVOKE_ENABLED */

@implementation XCMBuildSystem

#if defined(XCMB_FWD_INVOKE_ENABLED) && XCMB_FWD_INVOKE_ENABLED
- (void)forwardInvocation:(NSInvocation *)invocation
{
	SEL aSelector = [invocation selector];
	NSBundle *friend = [NSBundle mainBundle];
	if ([friend respondsToSelector:aSelector])
		[invocation invokeWithTarget:friend];
	else
		[super forwardInvocation:invocation];
}
#endif

+ (NSString *)debugDescription
{
	//return [(NSBundle *)([XCMBuildSystem superclass]) debugDescription];
	return (NSConstantString *)@"<XCMBuild/XCMBuildSystem>";
}

- (nullable NSString *)pathForAuxiliaryExecutable:(NSString *)executableName
{
	if (executableName != nil) {
			NSArray *AuxiliaryExecutableChoices = [NSArray arrayWithObjects:
													@"Clean", @"Build", @"Test",
													nil];
			if ([AuxiliaryExecutableChoices containsObject:(NSString *)executableName]) {
				return [[NSBundle mainBundle] pathForAuxiliaryExecutable:
						[NSString stringWithFormat:@"%@/usr/bin/XCM%@",
						 (NSString *)[self bundlePath],
						 (NSString *)executableName]];
			} else {
				AuxiliaryExecutableChoices = nil;
				return [super pathForAuxiliaryExecutable:(NSString *)executableName];
			};
	} else {
		return nil;
	};
}

@end
