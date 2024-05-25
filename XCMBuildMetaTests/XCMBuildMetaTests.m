//
//  XCMBuildMetaTests.h
//  XCMBuildMetaTests
//
//	Copyright (c) 2024 Mr.Walls
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

#import <XCMBuild/XCMBuild.h>
#import <XCTest/XCTest.h>

#if (defined(DEBUG) && DEBUG)
#define _XCMB_META_TEST_TARGED_BID (@"org.adhoc.dt.XCMBuild")
#else
#define _XCMB_META_TEST_TARGED_BID (NSConstantString *)(@"org.pak.dt.XCMBuild")
#endif

@interface XCMBuildMetaTests : XCTestCase

@end

@implementation XCMBuildMetaTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testSanityCheck {
	XCTAssertNoThrow(([XCMShellTask runCommand:@"/usr/bin/true"]), @"SANITY TEST FAILED!");
}

- (void)testMakeTest {
	XCTAssertTrue(([XCMShellTask runCommand:@"/usr/bin/make -C ~/SDK/XCMBuild/ test"]), @"Make test rturned non-zero.");
	// This is an example of a functional test case.
	// Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testExpectedFailure {
	XCMBuildSystem *_test_case_bundle = (XCMBuildSystem *)[XCMBuildSystem bundleWithIdentifier:_XCMB_META_TEST_TARGED_BID];
	XCTAssertNotNil(_test_case_bundle);
	XCTAssertNotNil([_test_case_bundle bundlePath], @"No path for %@", _test_case_bundle);
	XCTAssertNil(([_test_case_bundle pathForAuxiliaryExecutable:@"command"]), @"False Positive.");
}

- (void)testHasToolsByPath {
	XCMBuildSystem *_test_case_bundle = (XCMBuildSystem *)[XCMBuildSystem bundleWithIdentifier:_XCMB_META_TEST_TARGED_BID];
	XCTAssertNotNil(_test_case_bundle);
	XCTAssertNotNil([_test_case_bundle bundlePath], @"No path for %@", _test_case_bundle);
	XCTAssertEqualObjects(([_test_case_bundle class]), ([XCMBuildSystem class]), @"Wrong class for %@", _test_case_bundle);
	for (NSString *test_choice in @[ @"Clean", @"Test" ] ) {
		XCTAssertNotNil(([_test_case_bundle pathForAuxiliaryExecutable:test_choice]), @"Missing Tool (%@) by Path.", test_choice);
	}
}

@end
