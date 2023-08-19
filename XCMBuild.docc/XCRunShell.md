# ``XCRunShell``

A tool similar to `xcrun` (xcode) and `command` (posix) that is used to run commands in a
`bash`-like fashion with little to no refactoring needed to leverage convience features like path
resolution and environment abstraction.
see

## Overview

<!--@START_MENU_TOKEN@-->Text<!--@END_MENU_TOKEN@-->

## Topics

<!--@START_MENU_TOKEN@-->Structure<!--@END_MENU_TOKEN@-->

- In order to remain portable to MacOS in addition to `*nix` style OSes the on-disk structure is
intended to follow Apple's Framework structure https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPFrameworks/Concepts/FrameworkAnatomy.html

### <!--@START_MENU_TOKEN@-->Group<!--@END_MENU_TOKEN@-->

- <!--@START_MENU_TOKEN@-->``pruneFile``<!--@END_MENU_TOKEN@-->

- <!--@START_MENU_TOKEN@-->``flatten``<!--@END_MENU_TOKEN@-->

- <!--@START_MENU_TOKEN@-->``runtests``<!--@END_MENU_TOKEN@-->


## <!--@START_MENU_TOKEN@-->License<!--@END_MENU_TOKEN@-->

Copyright (c) 2014-2023 Mr. Walls

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
