divert(-1)
define(`FRAMEWORK', `XCMBuild')dnl
define(`FILESTUB', ``XCM'STUBNAME()')dnl
divert(0)dnl
divert(-1)
define(`LQ',`changequote(<,>)`dnl'
changequote`'')
define(`RQ',`changequote(<,>)dnl`
'changequote`'')
define(`STARTBLKCOMM',`/*')
define(`ENDBLKCOMM',`*/')
define(`foreach',`ifelse(eval($#>2),1,
`pushdef(`$1',`$3')$2`'popdef(`$1')dnl
`'ifelse(eval($#>3),1,`$0(`$1',`$2',shift(shift(shift($@))))')')')
define(`MIDBLKCOMM',` * '$1`
')dnl
define(`BLKCOMMSTR', `STARTBLKCOMM`'ENDBLKCOMM')dnl
divert(0)dnl
STARTBLKCOMM()`!'
foreach(`Z',`MIDBLKCOMM(`Z')',`@file FILESTUB()/FILESTUB().h',
`@copyright Copyright (c) 2023-2024 Mr.Walls',`',
`Licensed under the Apache License`, Version 2.0 (the "License");'',
`you may not use this file except in compliance with the License.',
`You may obtain a copy of the License at',
`     http://www.apache.org/licenses/LICENSE-2.0', `',
`Unless required by applicable law or agreed to in writing, software',
`distributed under the License is distributed on an "AS IS" BASIS`,'',
`WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND`, either express or implied.'',
`See the License for the specific language governing permissions and',
`limitations under the License.',`',`@framework FRAMEWORK().FILESTUB()',
`@version 2.3',`',
`@abstract',
`FRAMEWORK() tool to PURPSTUB() a project.')dnl
ENDBLKCOMM()

`// 'syscmd(`date -j +%c%m%d| grep -oE "[0-9]{8}" 2>/dev/null')

// take note to implement __clang_literal_encoding__ checks before clang does.

`#ifndef XCRS_RUNSHELL_MAIN_MARK'
`#def'`ine XCRS_RUNSHELL_MAIN_MARK __INCLUDE_LEVEL__'
`#endif'
`#import "'FILESTUB()`.h"'


`#if defined(__has_attribute)'
`#if __has_attribute(used)'
`#ifndef _'FILESTUB()`CommandArgumentsString'
`#def'`ine _'FILESTUB()`CommandArgumentsString "'EQUIVSTUB()`"'
`XCMB_EXPORT __kindof NSString * const 'FILESTUB()`CommandArgumentsString;'
`NSString * const 'FILESTUB()`CommandArgumentsString __attribute__ ((used)) = @"/usr/bin/command -p 'EQUIVSTUB()`";'
`#if defined(__clang__) && __clang__'
`#pragma clang final(_'FILESTUB()`CommandArgumentsString)'
`#endif 'STARTBLKCOMM()` !__clang__ 'ENDBLKCOMM()
`#endif 'STARTBLKCOMM()` has'FILESTUB()`CommandArgumentsString 'ENDBLKCOMM()
`#endif 'STARTBLKCOMM()` !__attribute__ ((used)) 'ENDBLKCOMM()
`#endif 'STARTBLKCOMM()` !__has_attribute 'ENDBLKCOMM()

`#if __INCLUDE_LEVEL__ < 1'
`int main(int argc, const char * argv[])'` {'
`	int exit_code = 1;'
`	@autoreleasepool {'
`		NSString* arguments = [NSString stringWithString:'FILESTUB()`CommandArgumentsString];'
`		if (known_unpredictable([XCMShellTask runCommand:arguments])){'
`			exit_code = 0;'
`		} else { __builtin_assume(exit_code == 1); };'
`		arguments = nil;'
`	}'
`	return exit_code;'
`}'
`#endif'
dnl
