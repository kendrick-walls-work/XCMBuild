# Acknowledgements

Copyright (c) 2014-2024 Mr. Walls

## Overview
### License
[Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0)

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.


## Attributions

>Important: Like most modern software ``XCMBuild`` is _in part_ humbaly built upon the work of those who came before it.
> ``XCMBuild`` includes some portions of code inspired or derived from the following _un-afiliated_ projects, the use, and attribution of which is hereby **acknowledged**.

### Apple OSS

In accordance with [Apple's Open-Source License](https://github.com/apple-oss-distributions/system_cmds/blob/3a6d92c5f871cbd7bd3490551dcd69b471c02a83/APPLE_LICENSE), which is hereby **acknowledged**,
some portions may be used when compiling ``XCMBuild`` as a larger work. Those portions may be subject to Apple's additional terms and must include the following additional notice be preserved where present:

>Quote: From [Oridginal Text](https://github.com/apple-oss-distributions/system_cmds/blob/3a6d92c5f871cbd7bd3490551dcd69b471c02a83/APPLE_LICENSE#L356-L370)
>
>"Portions Copyright (c) 1999 Apple Computer, Inc.  All Rights
>Reserved.  This file contains Original Code and/or Modifications of
>Original Code as defined in and that are subject to the Apple Public
>Source License Version 1.0 (the 'License').  You may not use this file
>except in compliance with the License.  Please obtain a copy of the
>License at http://www.apple.com/publicsource and read it before using
>this file.
>
>The Original Code and all software distributed under the License are
>distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER
>EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
>INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
>FITNESS FOR A PARTICULAR PURPOSE OR NON-INFRINGEMENT.  Please see the
>License for the specific language governing rights and limitations
>under the License."

- see [pb_makefile](https://github.com/apple-oss-distributions/pb_makefiles/tree/666e66b78ebcfd10a28197bf179f503e2a6961a9)

> Warning: While ``XCMBuild`` as a whole (including any modifications to portions subject to the Apple Public
> Source License) is "Licensed under the Apache License, Version 2.0" hereby clarifies the intent of dual licensing,
> is to "distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied"
> (Other terms NOT-Withstanding)

### Auto-Makefile

 [Auto Makefile](https://github.com/repnz/auto-makefile/tree/733e2112e8424cfa511166712145a5b60849342c)

Relevant portions of the code are therefore acknowledged to be released under the [MIT License](https://github.com/repnz/auto-makefile/blob/733e2112e8424cfa511166712145a5b60849342c/LICENSE).
In good faith, effort has been taken to indicate in the code where relevant.


- Which referenced a source of [Advanced Auto Dependency Generation][advanced-auto-dependency-generation]
> "Copyright © 1997-2023 Paul D. Smith · Verbatim copying and distribution is permitted in any medium, provided this notice is preserved."
Paul D. Smith also credits a one _"Tom Tromey <tromey@cygnus.com>"_ as a co-contributer and is likewise highlighted here for their contributions to [the paper][advanced-auto-dependency-generation]

### Bash Bible

[pure-bash-bible](https://github.com/dylanaraps/pure-bash-bible/commit/8c19d0b482b04d8d50fb72b4c5148b41ce605c6d)

Relevant portions of the code are therefore acknowledged to be released under the [MIT License](https://raw.githubusercontent.com/dylanaraps/pure-bash-bible/8c19d0b482b04d8d50fb72b4c5148b41ce605c6d/LICENSE.md).
In good faith effort has been taken to indicate in the code where relevant.

@Comment {
	If you're reading this part, you've gotten to the `markdown` code so ...
	A special thanks to the _un-afiliated_ project:
	[Markdown Guide](https://github.com/mattcone/markdown-guide) by a [Matt Cone](https://github.com/mattcone)
	with code under the [MIT License](https://github.com/mattcone/markdown-guide/blob/92783240a94f29caafbdc31a75b3b97f563cde3a/LICENSE.txt)
	Readers are recommended to check out the project for their own documentation. Y.M.M.V.
	That Content (not included in this project) is granted under [CC-BY-SA v4 Licence](https://creativecommons.org/licenses/by-sa/4.0/legalcode.en)
}

### Snore (Bash Function)

``XCMBuild``'s own implementation of the `snooze` `BASH` `function` is released under [Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0), with the _intent_ of being compattible with
the inspiering idea's own [License][CC-BY-SA-4]

The relevant portions of ``XCMBuild``'s own implementation of the `snooze` `BASH` `function` verbatim without its file header and footer, is therefore acknowledged to be specifically additionally release under the [Same Share-Alike License][CC-BY-SA-4] (as the shell function's sourcecode).
>Hearby Acknowledged: [pure-bash-bible (Above)](https://github.com/dylanaraps/pure-bash-bible/8c19d0b482b04d8d50fb72b4c5148b41ce605c6d#other)
>- Ideas from: https://blog.dhampir.no/content/sleeping-without-a-subprocess-in-bash-and-how-to-sleep-forever
>   - Their work was based on CC-BY-SA4 from: https://stackoverflow.com/help/licensing
>      - Their Source: [Fourum Question](https://unix.stackexchange.com/questions/68236/avoiding-busy-waiting-in-bash-without-the-sleep-command)
>      - Code: From the [Fourum Answer](https://unix.stackexchange.com/a/407383)
>      - Author hereby attributed as: [bolt](https://unix.stackexchange.com/users/263036/bolt)
>   - Their Relevant Code was attributed to: solving the [Fourum Question](https://unix.stackexchange.com/questions/68236/avoiding-busy-waiting-in-bash-without-the-sleep-command)
>   - Full License details can be found here: [Fourum License][CC-BY-SA-4]

- ``XCMBuild``'s own implementation is modified and not to be construed as endorced NOR affiliated by the oridginals (this disclaimer is the primarry intent of applying the [Apache License, Version 2.0][apache-license] to the file as a whole)
In good faith, effort has been taken to indicate in the code where relevant.


### Non-Blocking sub-shell output idea ( ``XCMShellDelegate`` )
``XCMShellDelegate/captureStandardError(_:)``'s implementation was directly inspired from
[CC BY-SA (v3)][CC-BY-SA-3] content namely regarding the method idea.
see https://stackoverflow.com/help/licensing for details

This Modified Code is under dual-licenses APACHE-2 and CC BY-SA 3.0
with regard to the code from https://stackoverflow.com/a/45197345

CC BY-SA3.0 Attribution and Awknowlegement:
THANKS to the user https://stackoverflow.com/users/408390/warren-burton
For the solid answer to https://stackoverflow.com/a/45197345

### Non-Blocking sub-shell output idea ( _Usage_ )
Some of ``XCMShellDelegate`` was inspired from CC BY-SA (v3) content
namely regarding the generals of how to use `-(void)captureStandardOutput:process`
while building a task
see https://stackoverflow.com/help/licensing for details

This Modified Code is under dual-licenses APACHE-2 and CC BY-SA 3.0
with regard to the code from https://stackoverflow.com/a/13218209

CC BY-SA3.0 Attribution and Awknowlegement:
THANKS to the user https://stackoverflow.com/users/1187415/martin-r
For the solid answer to https://stackoverflow.com/a/13218209


Portions of ``XCMBuild`` may utilize the following copyrighted material, the use of which is hereby acknowledged:




[Apache License, Version 2.0]: <https://www.apache.org/licenses/LICENSE-2.0> "Apache License, Version 2.0"
[advanced-auto-dependency-generation]: <https://web.archive.org/web/20231008034019/https://make.mad-scientist.net/papers/advanced-auto-dependency-generation/#traditional> "Advanced Auto Dependency Generation"
[CC-BY-SA-4]: <https://creativecommons.org/licenses/by-sa/4.0/> "CC by Share Alike v4.0"
[CC-BY-SA-3]: <https://creativecommons.org/licenses/by-sa/3.0/> "CC by Share Alike v3.0"
