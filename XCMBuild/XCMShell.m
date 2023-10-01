/*!
 * @file XCMShell.m
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

/*! @parseOnly
Some of the following code was inspired from CC BY-SA (v3) content
namely regarding lines 56 through 83 of this Header
see https://stackoverflow.com/help/licensing for details

This Modified Code is under dual-licenses APACHE-2 and CC BY-SA 3.0
with regard to the code from https://stackoverflow.com/a/12310154

CC BY-SA3.0 Attribution:
THANKS to the user https://stackoverflow.com/users/478597/kenial
For the solid answer to https://stackoverflow.com/a/12310154
*/

/*! @parseOnly
 Some of the following code was inspired from CC BY-SA (v3) content
 namely regarding lines 77 through 78 of this Header
 see https://stackoverflow.com/help/licensing for details

 This Modified Code is under dual-licenses APACHE-2 and CC BY-SA 3.0
 with regard to the code from https://stackoverflow.com/a/49686965

 CC BY-SA3.0 Attribution:
 THANKS to the user https://stackoverflow.com/users/2060605/vikram-sinha
 For the partial answer to https://stackoverflow.com/a/49686965
*/

// see __has_builtin(__builtin_unpredictable) for sub-calls

//extern const char* XCMTestCommandArgumentsString __attribute__((weak_import));
#include "XCMShell.h"

@implementation XCMShellTask

+ (nullable NSString *)runCommand:(NSString *)commandToRun
{
	if (commandToRun != nil){
		NSPipe *pipe = [[NSPipe alloc] init];
		NSFileHandle *file = [pipe fileHandleForReading];
		NSTask *task = [[NSTask alloc] init];
		NSArray *arguments = [NSArray arrayWithObjects:
					 @"-c", [NSString stringWithFormat:@"%@", commandToRun],
					 nil];
		[task setLaunchPath:@"/bin/bash"];
		[task setArguments:arguments];
		[task setStandardInput:[NSFileHandle fileHandleWithStandardInput]];
		[task setStandardOutput:pipe];

		[task launch];
		NSData *data = [file readDataToEndOfFile];
		if ([task isRunning])
			[task waitUntilExit];

		if (![task isRunning]) {
			int status = [task terminationStatus];
			if (status == 0) {
				NSString *output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
#if defined(TARGET_OS_MAC) && TARGET_OS_MAC
				NSError *theError;
				BOOL success = [file closeAndReturnError:&theError];

				if (success == NO) {
					file = nil;
					output = @"XCMShellTask Crashed!";
				}
#else
				[file closeFile];
#endif
				return output;
			} else {
				return @"XCMShellTask failed.";
			}
			#if __has_builtin(__builtin_unreachable)
				__builtin_unreachable();
			#endif
		} else {
#if defined(TARGET_OS_MAC) && TARGET_OS_MAC
			NSError *theError;
			BOOL success = [file closeAndReturnError:&theError];

			if (success == NO) {
				file = nil;
			}
#else
			[file closeFile];
#endif
		};
		return @"XCMShellTask Crashed!";
	} else { return @"XCRunShell Requires a NON-NULL command!"; }
}

@end

//NSString *shell(NSString *args)
