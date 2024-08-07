# ``XCMBuild``

@Metadata {
	@DocumentationExtension(mergeBehavior: append)
	@PageImage(purpose: icon, source: Icon.png)
}

@Comment {
	### License

	Copyright (c) 2014-2024 Mr. Walls

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

	[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.
}

## Overview

The ``XCMBuild/XCMBuildSystem`` harnesses the flexibility of a `Makefile` based workflow into a simple build system.


## Layout

### Scripts

##### `usr/bin/`

Various scripts are available for expanding shellscript run-phases of a build system.

>flatten: Used to flatten nested filesystem artifacts in the build directories.
>###### Usage:
>```console
>flatten [FILE|DIR] ...
>```
>###### Instead of:
>- `-R`
>- `--depth`
>- `globbing of */**`

>pruneFile: Used to purge filesystem artifacts from the build directories.
>###### Usage:
>```console
>pruneFile [FILE|DIR] ...
>```
>###### Instead of:
>```console
>rm [options] [FILE]
>```
>```console
>unlink [options] [FILE]
>```
>```console
>rmdir [options] [DIR]
>```

>snooze: Used to more efficiently wait a for a given duration than bash's default `sleep`.
> _see <doc:Acknowledgements> for `LICENSE` of snooze._
>###### Usage:
>```console
>pruneFile [FILE|DIR] ...
>```
>###### Instead of:
>```console
>rm [options] [FILE]
>```
>```console
>unlink [options] [FILE]
>```
>```console
>rmdir [options] [DIR]
>```

### Binaries

- `xcrunshell`
- `XCMTest`

## Topics

<!--@START_MENU_TOKEN@-->Structure<!--@END_MENU_TOKEN@-->

- ``XCMTestCommandArgumentsString``
