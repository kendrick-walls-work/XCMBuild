//
//  XCMBuildSystem.m
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

//extern const char* XCMTestCommandArgumentsString __attribute__((weak_import));
#include "XCMBuildSystem.h"

@implementation XCMBuildSystem

- (nullable NSString *)pathForAuxiliaryExecutable:(NSString *)executableName
{
	if (executableName != nil) {
			NSArray *AuxiliaryExecutableChoices = [NSArray arrayWithObjects:
													@"Clean", @"Build", @"Test",
													nil];
			if ([AuxiliaryExecutableChoices containsObject:(NSString *)(executableName)]) {
				return [NSBundle.mainBundle pathForAuxiliaryExecutable:
						[NSString stringWithFormat:@"%@/usr/bin/XCM%@",
						 (NSString *)([self bundlePath]),
						 (NSString *)(executableName), nil]];
			} else {
				return [super pathForAuxiliaryExecutable:executableName];
			};
	} else {
		return nil;
	};
}

@end
