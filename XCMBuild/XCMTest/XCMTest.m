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

// take note to implement __clang_literal_encoding__ checks before clang does.

#import <XCMBuild/XCMTest.h>

#ifndef _XCMTestCommandArgumentsString
#define _XCMTestCommandArgumentsString "make test"
/*!
 * @const XCMTestCommandArgumentsString
 *
 * @abstract Use this to Makefile Testing cmdline string for XCMTest.
*/
NSString * const XCMTestCommandArgumentsString __attribute__ ((used)) = @"/usr/bin/command -p make test";
#if defined(__clang__)
#pragma clang final(_XCMTestCommandArgumentsString)
#endif /* !__clang__ */
#endif /* hasXCMTestCommandArgumentsString */

/*!
 * @function main
 *
 * @abstract
 * TODO
 *
 * @discussion
 * Used to handle the testing of a project built with the ``XCMBuild`` system. Namely runs the equivilant of `make test`
 *
 * @returns `0` (exit-code of zero) if the test reported back without errors. Otherwise Returns a value greater than `0` in the case
 * of any errors.
*/
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
