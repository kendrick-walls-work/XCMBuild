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
namely regarding lines ?? through ?? of this Header
see https://stackoverflow.com/help/licensing for details

This Modified Code is under dual-licenses APACHE-2 and CC BY-SA 3.0
with regard to the code from https://stackoverflow.com/a/12310154

CC BY-SA3.0 Attribution:
THANKS to the user https://stackoverflow.com/users/478597/kenial
For the solid answer to https://stackoverflow.com/a/12310154
*/

/*! @parseOnly
 Some of the following code was inspired from CC BY-SA (v3) content
 namely regarding lines ?? through ?? of this Header
 see https://stackoverflow.com/help/licensing for details

 This Modified Code is under dual-licenses APACHE-2 and CC BY-SA 3.0
 with regard to the code from https://stackoverflow.com/a/49686965

 CC BY-SA3.0 Attribution:
 THANKS to the user https://stackoverflow.com/users/2060605/vikram-sinha
 For the partial answer to https://stackoverflow.com/a/49686965
*/

// see __has_builtin(__builtin_unpredictable) for sub-calls
// see https://clang.llvm.org/docs/LanguageExtensions.html#builtin-unpredictable

//extern const char* XCMTestCommandArgumentsString __attribute__((weak_import));
#ifndef XCMShell_h
#import "XCMShell.h"
#endif
#ifndef XCMProcesses_h
#import "XCMProcesses.h"
#endif

@implementation XCMShellTask

+ (BOOL)runCommand:(NSString *)commandToRun
{
	if (commandToRun != nil){
#if defined(MAC_OS_X_VERSION_MAX_ALLOWED) && MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_9
		id meActive = beginXCMProcActivity(@"Preparing XCMShell Command");
#endif
		//NSPipe *pipe = [[NSPipe alloc] init];
		//NSFileHandle *file = [pipe fileHandleForReading];
		NSTask *task = [[NSTask alloc] init];
		NSArray *arguments = [NSArray arrayWithObjects:
					 @"-c", [NSString stringWithFormat:@"%@", commandToRun],
					 nil];
#if defined(MAC_OS_X_VERSION_MAX_ALLOWED) && MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_13
		[task setExecutableURL:[[NSURL alloc] initFileURLWithPath:@"/bin/bash" isDirectory:NO]];
#else
		[task setLaunchPath:@"/bin/bash"];
#endif
		[task setArguments:arguments];
		[task setStandardInput:[NSFileHandle fileHandleWithStandardInput]];
		//[task setStandardOutput:pipe];
		XCMShellDelegate *console = [[XCMShellDelegate alloc] init];
		[console captureStandardOutput:task];
		[console captureStandardError:task];
#if defined(MAC_OS_X_VERSION_MAX_ALLOWED) && MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_9
		endXCMProcActivity(meActive);
		id cmdActive = beginXCMProcActivity(@"Running Sub-shell");
#endif
#if defined(TARGET_OS_MAC) && TARGET_OS_MAC
		NSError *bsError;
		BOOL ready = [task launchAndReturnError:&bsError];
#else
		[task launch];
		BOOL ready = (BOOL)([task isRunning]);
#endif
		//[[XCMShellDelegate new] captureStandardOutput:task];
		//NSData *data = [file readDataToEndOfFile];
		if (known_unpredictable([task isRunning]) && ready == YES)
			[task waitUntilExit];
#if defined(MAC_OS_X_VERSION_MAX_ALLOWED) && MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_9
		endXCMProcActivity(cmdActive);
#endif
		[console removeAllCaptures];
		console = nil;
		if (![task isRunning]) {
			int status = [task terminationStatus];

			if (status == 0) {
				return YES;
			} else {
				return NO;
			}
			#if __has_builtin(__builtin_unreachable)
				__builtin_unreachable();
			#else
				return NO;
			#endif
		} else {
			return ready;
		}
#if __has_builtin(__builtin_unreachable)
		__builtin_unreachable();
#else
		return NO;
#endif
	} else { return NO; }
}

@end

//NSString *shell(NSString *args)
