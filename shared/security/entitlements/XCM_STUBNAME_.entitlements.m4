divert(-1)
define(`FRAMEWORK', `XCMBuild')dnl
define(`FILESTUB', ``XCM'STUBNAME()')dnl
divert(0)dnl
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<!--
FILESTUB()`.entitlements'
FRAMEWORK()

Copyright (c) 2024 Mr.Walls

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

-->
<plist version="1.0">
<dict>
	<key>com.apple.security.application-groups</key>
	<string>org.pak.dt</string>
	<key>com.apple.security.cs.disable-library-validation</key>
	<true/>
</dict>
</plist>
