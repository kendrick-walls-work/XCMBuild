/*!
 * @file XCMTest/XCMTest.m
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
 */

// take note to implement __clang_literal_encoding__ checks before clang does.

#ifndef XCRS_RUNSHELL_MAIN_MARK
#define XCRS_RUNSHELL_MAIN_MARK __INCLUDE_LEVEL__
#endif
#import <XCMBuild/XCMTest.h>


#if defined(__has_attribute)
#if __has_attribute(used)
#ifndef _XCMTestCommandArgumentsString
#define _XCMTestCommandArgumentsString "make -f Makefile test"
NSString * const XCMTestCommandArgumentsString __attribute__ ((used)) = @"/usr/bin/command -p make -f Makefile test";
#if defined(__clang__) && __clang__
#pragma clang final(_XCMTestCommandArgumentsString)
#endif /* !__clang__ */
#endif /* hasXCMTestCommandArgumentsString */
#endif /* !__attribute__ ((used)) */
#endif /* !__has_attribute */

#if __INCLUDE_LEVEL__ < 1
int main(int argc, const char * argv[]) {
	int exit_code = 1;
	@autoreleasepool {
		NSString* arguments = [NSString stringWithString:XCMTestCommandArgumentsString];
		if (known_unpredictable([XCMShellTask runCommand:arguments])){
			exit_code = 0;
		} else { __builtin_assume(exit_code == 1); };
		arguments = nil;
	}
	return exit_code;
}
#endif
