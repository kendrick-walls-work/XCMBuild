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

#ifndef XCMTest_h
#if defined(__has_include)
#if __has_include(<XCMBuild/XCMTest.h>)
#define XCMTest_h "<XCMBuild/XCMTest.h> (XCMTestTool)"
#import <XCMBuild/XCMTest.h>
#endif
#else /* !__has_include */
#define XCMTest_h "XCMTest.h (XCMTestTool)"
#import "XCMTest.h"
#endif /* XCMTest_h (inner) */
#if defined(__clang__)
#pragma clang final(XCMTest_h)
#endif /* !__clang__ */
#endif /* XCMTest_h (outer) */

#if defined(__has_attribute)
#if __has_attribute(used)
#ifndef _XCMTestCommandArgumentsString
#define _XCMTestCommandArgumentsString "make -f Makefile test"
NSString * const XCMTestCommandArgumentsString __attribute__ ((used)) = @"/usr/bin/command -p make -f Makefile test 2>&1";
#if defined(__clang__)
#pragma clang final(_XCMTestCommandArgumentsString)
#endif /* !__clang__ */
#endif /* hasXCMTestCommandArgumentsString */
#endif /* !__attribute__ ((used)) */
#endif /* !__has_attribute */

int main(int argc, const char * argv[]) {
	int exit_code = 1;
	@autoreleasepool {
		NSString * arguments = [NSString stringWithString:XCMTestCommandArgumentsString];
		NS_VALID_UNTIL_END_OF_SCOPE NSString * console = [XCMShellTask runCommand:arguments];
		if (console != nil){
			exit_code = 0;
		};
		if (exit_code == 0) {
			NSLog(@"%@", console);
		};

		arguments = nil;
		console = nil;
	}
	return exit_code;
}
