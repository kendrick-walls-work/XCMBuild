//
//  main.m
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


#ifndef XCRS_MINARGS
#import "xcrunshell.h"
#endif

int main(int argc, const char * argv[]) {
	int exit_code = 1;
	@autoreleasepool {
#if defined(__has_feature)
#if __has_feature(thread_sanitizer)
		// setup by checking our pid
		int pid = [[NSProcessInfo processInfo] processIdentifier];
		if (pid > 0) {
#endif
#endif

			NS_VALID_UNTIL_END_OF_SCOPE NSString* console = @"Not Implemented Yet.";
			if (argc >= XCRS_MINARGS){
				NSArray *c_argv = [[NSProcessInfo processInfo] arguments];
				NSArray *args = [c_argv subarrayWithRange:NSMakeRange(1, c_argv.count - 1)];
				NSString* arguments = [args componentsJoinedByString:@" "];
				console = [XCMShellTask runCommand:arguments];
				exit_code = 0;
			} else { exit_code = 255; };

			if (exit_code == 0) {
				NSLog(@"%@", console);
			};

			console = nil;
#if defined(__has_feature)
#if __has_feature(thread_sanitizer)
		};
#endif
#endif
	}
	return exit_code;
}
