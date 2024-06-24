/*!
 * @file XCMBuildSystem.m
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
 */

#ifndef XCMBuildSystem_h
#import "XCMBuildSystem.h"
#endif

#if !defined(XCMBuildSystemBundleIDString)
XCMB_EXPORT __kindof NSString *_Nonnull const XCMBuildSystemBundleIDString;
#if (defined(DEBUG) && DEBUG)
NSString *_Nonnull const XCMBuildSystemBundleIDString __attribute__ ((used)) = @"org.adhoc.dt.XCMBuild";
#else
NSConstantString *_Nonnull const XCMBuildSystemBundleIDString __attribute__ ((used)) = (NSConstantString *)(@"org.pak.dt.XCMBuild");
#endif
#endif /* !XCMBuildSystemBundleIDString */

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

+ (__kindof NSBundle *)bundleForClass:(Class)aClass
{
	if (aClass != nil)
	{
		if ([aClass isKindOfClass:[XCMBuildSystem class]]) {
			return (XCMBuildSystem *)[XCMBuildSystem bundleWithIdentifier:XCMBuildSystemBundleIDString];
		}
		else if ([[[NSBundle bundleForClass:aClass] bundleIdentifier] isEqualToString:XCMBuildSystemBundleIDString])
		{
			return (XCMBuildSystem *)[XCMBuildSystem bundleWithIdentifier:XCMBuildSystemBundleIDString];
		} else return [NSBundle bundleForClass:aClass];
	} else return [NSBundle bundleForClass:aClass];
}

+ (nullable __kindof NSBundle *)bundleWithIdentifier:(NSString *)identifier
{
	if ((identifier != nil) && ([identifier isEqualToString:XCMBuildSystemBundleIDString]))
	{
		XCMBuildSystem *_new_bundle = (XCMBuildSystem *)[NSBundle bundleWithIdentifier:XCMBuildSystemBundleIDString];
		return (XCMBuildSystem *)_new_bundle;
	} else return [NSBundle bundleWithIdentifier:identifier];
}

+ (NSString *)debugDescription
{
	//return [(NSBundle *)([XCMBuildSystem superclass]) debugDescription];
	return (NSConstantString *)@"<XCMBuild/XCMBuildSystem>";
}

- (nullable instancetype)initWithPath:(NSString *)path
{
	self = [super initWithPath:path];
	if ([[self bundleIdentifier] isEqualToString:XCMBuildSystemBundleIDString]) return self;
	else return nil;
}

+ (nullable NSString *)pathForAuxiliaryExecutable:(NSString *)executableName
{
	NSString *_my_path = [(XCMBuildSystem *)[XCMBuildSystem bundleWithIdentifier:XCMBuildSystemBundleIDString] bundlePath];
	if ((executableName != nil) && (_my_path != nil)) {
			NSArray *AuxiliaryExecutableChoices = [NSArray arrayWithObjects:
												   @"Analyze", @"Archive", @"Clean", @"DocBuild", @"Install", @"Build", @"Test",
													nil];
			if ([AuxiliaryExecutableChoices containsObject:(NSString *)executableName]) {
				return [NSString stringWithFormat:@"%@/Versions/Current/usr/bin/XCM%@",
						 (NSString *)_my_path,
						 (NSString *)executableName];
			} else {
				AuxiliaryExecutableChoices = nil;
				return [[XCMBuildSystem bundleWithIdentifier:XCMBuildSystemBundleIDString] pathForAuxiliaryExecutable:(NSString *)executableName];
			};
	} else {
		return nil;
	};
}

@end
