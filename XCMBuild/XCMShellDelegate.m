/*!
 * @file XCMShellDelegate.m
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
 namely regarding the method idea of `-(void)captureStandardOutput:process`
 see https://stackoverflow.com/help/licensing for details

 This Modified Code is under dual-licenses APACHE-2 and CC BY-SA 3.0
 with regard to the code from https://stackoverflow.com/a/45197345

 CC BY-SA3.0 Attribution:
 THANKS to the user https://stackoverflow.com/users/408390/warren-burton
 For the solid answer to https://stackoverflow.com/a/45197345
 */

/*! @parseOnly
 Some of the following code was inspired from CC BY-SA (v3) content
 namely regarding the generals of how to use `-(void)captureStandardOutput:process`
 while building a task
 see https://stackoverflow.com/help/licensing for details

 This Modified Code is under dual-licenses APACHE-2 and CC BY-SA 3.0
 with regard to the code from https://stackoverflow.com/a/13218209

 CC BY-SA3.0 Attribution:
 THANKS to the user https://stackoverflow.com/users/1187415/martin-r
 For the solid answer to https://stackoverflow.com/a/13218209
 */

// see __has_builtin(__builtin_unpredictable) for sub-calls

//extern const char* XCMTestCommandArgumentsString __attribute__((weak_import));
#include "XCMShellDelegate.h"

@implementation XCMShellDelegate

@synthesize outputPipe;

-(void)captureStandardOutput:(NSTask *)process {
	if (process != nil) {
		[self setOutputPipe:[NSPipe new]];
		[process setStandardOutput:[self outputPipe]];
		//listen for data available
		[[[self outputPipe] fileHandleForReading] waitForDataInBackgroundAndNotify];
		[[NSNotificationCenter defaultCenter] addObserverForName:NSFileHandleDataAvailableNotification
														object:[[self outputPipe] fileHandleForReading]
														queue:nil
														usingBlock:^(NSNotification * _Nonnull note) {

			NSData *output = [[[self outputPipe] fileHandleForReading] availableData];
			NSString * outputString = [[NSString alloc] initWithData:output
														encoding:NSUTF8StringEncoding];

			dispatch_async(dispatch_get_main_queue(), ^{
				// do something with the string chunk that has been received
				if (outputString != nil)
					printf("%s", [outputString cStringUsingEncoding:NSUTF8StringEncoding]);
			});

			//listen again...
			[[[self outputPipe] fileHandleForReading] waitForDataInBackgroundAndNotify];

		}];
	};
}

@end
