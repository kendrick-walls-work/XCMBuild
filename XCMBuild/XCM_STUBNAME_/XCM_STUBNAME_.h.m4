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

`#ifndef' FILESTUB()_h
`#ifndef' FRAMEWORK()_h
`#if defined'(__has_include)
`#if' __has_include(<FRAMEWORK()/FRAMEWORK().h>)
STARTBLKCOMM()`! @parseOnly 'ENDBLKCOMM()
`#define 'FRAMEWORK()`_h "<'FRAMEWORK()`/'FRAMEWORK()`.h> ('FILESTUB()`)"'
`#import <'FRAMEWORK()`/'FRAMEWORK()`.h>'
`#endif'
`#endif 'STARTBLKCOMM()` !__has_include 'ENDBLKCOMM()
`#ifndef 'FRAMEWORK()`_h'
STARTBLKCOMM()`! @parseOnly 'ENDBLKCOMM()
`#define 'FRAMEWORK()`_h "'FRAMEWORK()`.h ('FILESTUB()`)"'
`#import "'FRAMEWORK()`.h"'
`#endif 'STARTBLKCOMM()` 'FRAMEWORK()_h` (inner) 'ENDBLKCOMM()
`#if defined(__clang__) && __clang__'
`#pragma clang final('FRAMEWORK()`_h)'
`#endif 'STARTBLKCOMM()` !__clang__ 'ENDBLKCOMM()
`#endif 'STARTBLKCOMM()` 'FRAMEWORK()`_h (outer) 'ENDBLKCOMM()

`#if defined(TARGET_OS_OSX) && TARGET_OS_OSX || (defined(TARGET_OS_UNIX) && TARGET_OS_UNIX) || (defined(TARGET_OS_LINUX) && TARGET_OS_LINUX)'

`#ifndef 'FILESTUB()`CommandArgumentsString'
/// Use this as the LQ()EQUIVSTUB()`'LQ() cmdline string for LQ()LQ()FILESTUB()`'LQ()`'LQ().
`XCMB_IMPORT NSString * const 'FILESTUB()`CommandArgumentsString XCMHELPER_NEEDED;'
`#endif 'STARTBLKCOMM()` 'FILESTUB()`CommandArgumentsString 'ENDBLKCOMM()
`#if' defined(XCRS_RUNSHELL_MAIN_MARK)
`#if XCRS_RUNSHELL_MAIN_MARK < __INCLUDE_LEVEL__ && XCRS_RUNSHELL_MAIN_MARK < 1 && __INCLUDE_LEVEL__ <= 2'

/// Used to PURPSTUB() a project built with the LQ()LQ()FRAMEWORK()`'LQ()`'LQ() system. Namely runs the equivalent of LQ()EQUIVSTUB()`'LQ().
///
/// - Returns: LQ()0LQ() (exit-code of zero) if the clean reported back without errors. Otherwise Returns a value greater than LQ()0LQ() in any case with errors.
/// - Parameters:
///   - argc: main argument count input. Ignored here.
///   - argv: main arguments from input. Ignored here.
`int main(int argc, const char * argv[]);'
`#endif'
`#endif'
STARTBLKCOMM()`! @parseOnly 'ENDBLKCOMM()
`#define 'FILESTUB()`_h "'FILESTUB()`.h"'

`#endif 'STARTBLKCOMM()` !TARGET_OS_OSX 'ENDBLKCOMM()

`#endif 'STARTBLKCOMM()` 'FILESTUB()`_h 'ENDBLKCOMM()
dnl
