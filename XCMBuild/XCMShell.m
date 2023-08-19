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

/*
Some of the following code was inspired from CC BY-SA (v3) content
namely regarding lines 59 through 84 of this Header
see https://stackoverflow.com/help/licensing for details

This Modified Code is under dual-licenses APACHE-2 and CC BY-SA 3.0
with regard to the code from https://stackoverflow.com/a/12310154

CC BY-SA3.0 Attribution:
THANKS to the user https://stackoverflow.com/users/478597/kenial
For the solid answer to https://stackoverflow.com/a/12310154
*/

/*
 Some of the following code was inspired from CC BY-SA (v3) content
 namely regarding lines 76 through 77 of this Header
 see https://stackoverflow.com/help/licensing for details

 This Modified Code is under dual-licenses APACHE-2 and CC BY-SA 3.0
 with regard to the code from https://stackoverflow.com/a/49686965

 CC BY-SA3.0 Attribution:
 THANKS to the user https://stackoverflow.com/users/2060605/vikram-sinha
 For the partial answer to https://stackoverflow.com/a/49686965
*/

#import "XCMShell.h"

@implementation NSTask (XCMShellTask)

+ (nullable NSString *)runCommand:(NSString *)commandToRun
{
	if (commandToRun != nil){
		NSTask *task = [[NSTask alloc] init];
		[task setLaunchPath:@"/bin/bash"];

		NSArray *arguments = [NSArray arrayWithObjects:
								@"-c" ,
								[NSString stringWithFormat:@"%@", commandToRun, nil],
								nil];
#if DEBUG
		NSLog(@"run command:%@", commandToRun);
#else
#endif
		[task setArguments:arguments];

		NSPipe *pipe = [NSPipe pipe];
		[task setStandardOutput:pipe];

		NSFileHandle *file = [pipe fileHandleForReading];

		[task launch];
		NSData *data = [file readDataToEndOfFile];

		if(task.isRunning)
			[task waitUntilExit];

		int status = [task terminationStatus];
		if(status == 0){
			NSString *output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
			return output;
		} else { return nil; }
	} else { return nil; }
}

@end

//NSString *shell(NSString *args)
