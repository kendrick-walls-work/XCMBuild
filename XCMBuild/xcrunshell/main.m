//
//  main.m
//  xcrunshell
//
//	Copyright (c) 2023-2024 Mr.Walls
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

#ifndef XCRS_RUNSHELL_MAIN_MARK
#define XCRS_RUNSHELL_MAIN_MARK __INCLUDE_LEVEL__
#endif
#import "xcrunshell.h"

#if defined(__has_attribute)
#if __has_attribute(used)
#ifndef XCMB_IFS
#define _XCMB_IFS " "
NSString * const XCMB_IFS __attribute__ ((used)) = @" ";
#if defined(__clang__) && __clang__
#pragma clang final(_XCMB_IFS)
#endif /* !__clang__ */
#endif /* hasXCMB_IFS */
#endif /* !__attribute__ ((used)) */
#endif /* !__has_attribute */

#if __INCLUDE_LEVEL__ < 1
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
			if (argc >= XCRS_MINARGS){
				NSArray *c_argv = [[NSProcessInfo processInfo] arguments];
				NSArray *args = [c_argv subarrayWithRange:NSMakeRange(1, c_argv.count - 1)];
				NSString* arguments = [args componentsJoinedByString:XCMB_IFS];
				if (known_unpredictable([XCMShellTask runCommand:arguments])) {
					exit_code = (int)(0);
				} else { exit_code = (int)(2); };
			} else { exit_code = (int)(255); };
#if defined(__has_feature)
#if __has_feature(thread_sanitizer)
		}; /* if !(pid>0) */
#endif
#endif
	} /* end autoreleasepool */
	return exit_code;
}
#endif
