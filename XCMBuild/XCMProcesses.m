//
//  XCMProcesses.h
//  XCMBuild
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


#include "XCMProcesses.h"

#ifndef XCMProcesses_h
#if !defined(XCMB_OS_ACTIVITY_ENABLED)
#if defined(__has_include)
#if __has_include(<os/activity.h>)
#define XCMB_OS_ACTIVITY_ENABLED YES
#import <os/activity.h>
#else /* !os/activity */
#define XCMB_OS_ACTIVITY_ENABLED NO
#error Failed to link OS activity features
#endif /* !XCMB_OS_ACTIVITY_ENABLED (inner) */
#endif /* !__has_include */
#elif defined(XCMB_OS_ACTIVITY_ENABLED) && XCMB_OS_ACTIVITY_ENABLED
XCMB_IMPORT void os_activity_scope_enter(os_activity_t activity, os_activity_scope_state_t state);
XCMB_IMPORT void os_activity_scope_leave(os_activity_scope_state_t state);
#endif /* !XCMB_OS_ACTIVITY_ENABLED (outer) */

#if !defined(NSActivityOptions)
#if defined(__has_include)
#if __has_include(<Foundation/NSProcessInfo.h>)
#import <Foundation/NSProcessInfo.h>
#else /* !Foundation/ProcessInfo (inner) */
#error Failed to link NSActivityOptions features
#endif /* !Foundation/ProcessInfo (outer) */
#endif /* !__has_include */
#endif/* !ProcessInfo */

#if defined(__has_attribute)
#if __has_attribute(used)
#pragma mark - XCMProcessesDispatch Constants
#ifndef _XCMProcessesDispatchReasonString
#define _XCMProcessesDispatchReasonString "XCMProcesses Control Active"
NSString * const XCMProcessesDispatchReasonString __attribute__ ((used)) = @"XCMProcesses Control Active";
#if defined(__clang__) && __clang__
#pragma clang final(_XCMProcessesDispatchReasonString)
#endif /* !__clang__ */
#if defined(XCMB_OS_ACTIVITY_ENABLED) && XCMB_OS_ACTIVITY_ENABLED
#endif /* hasXCMProcessesDispatchReasonString */
#ifndef XCMProcessesSTART
#define XCMProcessesSTART "XCRunShell Spawning"
#if defined(__clang__) && __clang__
#pragma clang final(XCMProcessesSTART)
#endif /* !__clang__ */
#endif /* !XCMProcessesDispatchActivityStartString */
#ifndef XCMProcessesEND
#define XCMProcessesEND "XCRunShell De-spawning"
#if defined(__clang__) && __clang__
#pragma clang final(XCMProcessesEND)
#endif /* !__clang__ */
#endif /* !XCMProcessesDispatchActivityEndString */
#endif /* !XCMB_OS_ACTIVITY_ENABLED */
#endif /* !__attribute__ ((used)) */
#endif /* !__has_attribute */

#if defined(__clang__) && __clang__
#pragma mark - XCMProcessesDispatch Functions
#endif

#if defined(__has_attribute)
#if __has_attribute(blocks)

#if defined(MAC_OS_X_VERSION_MAX_ALLOWED) && MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_9

id beginXCMProcActivity(NSString * const reason) {
	__block id callerProc;
#if defined(MAC_OS_X_VERSION_MAX_ALLOWED) && MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_VERSION_13_0
	__block NSActivityOptions options = NSActivityAutomaticTerminationDisabled | NSActivityTrackingEnabled;
#elif defined(MAC_OS_X_VERSION_MAX_ALLOWED) && MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_VERSION_10_9
	__block NSActivityOptions options = NSActivityAutomaticTerminationDisabled;
#else
#error Building for Intel with Mac OS X Deployment Target < 10.8 is invalid.
#endif
	[[NSProcessInfo processInfo] performActivityWithOptions:NSActivityLatencyCritical reason:XCMProcessesDispatchReasonString usingBlock:^ {
#if defined(XCMB_OS_ACTIVITY_ENABLED) && XCMB_OS_ACTIVITY_ENABLED
		struct os_activity_scope_state_s state;
		os_activity_t activity = os_activity_create(XCMProcessesSTART, OS_ACTIVITY_NONE, OS_ACTIVITY_FLAG_DETACHED);
		os_activity_scope_enter(activity, &state);
		callerProc = [[NSProcessInfo processInfo] beginActivityWithOptions:options reason:reason];
		os_activity_scope_leave(&state);
		os_activity_scope(activity);
#else
		callerProc = [[NSProcessInfo processInfo] beginActivityWithOptions:options reason:reason];
#endif
	}];
	return callerProc;
}

void endXCMProcActivity(id<NSObject> callerProc) {
	[[NSProcessInfo processInfo] performActivityWithOptions:NSActivityLatencyCritical reason:XCMProcessesDispatchReasonString usingBlock:^ {
#if defined(XCMB_OS_ACTIVITY_ENABLED) && XCMB_OS_ACTIVITY_ENABLED
		struct os_activity_scope_state_s state;
		os_activity_t activity = os_activity_create(XCMProcessesEND, OS_ACTIVITY_CURRENT, OS_ACTIVITY_FLAG_IF_NONE_PRESENT);
		os_activity_scope_enter(activity, &state);
		[[NSProcessInfo processInfo] endActivity:callerProc];
		os_activity_scope_leave(&state);
		os_activity_scope(activity);
#else
		[[NSProcessInfo processInfo] endActivity:callerProc];
#endif
	}];
}
#endif
#else /* !__attribute__ (blocks) */

id beginXCMProcActivity(NSString * const reason) {
#if defined(MAC_OS_X_VERSION_MAX_ALLOWED) && MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_9
	NSActivityOptions options = NSActivityAutomaticTerminationDisabled;
#else
#error Building for Intel with Mac OS X Deployment Target < 10.8 is invalid.
#endif
	return [[NSProcessInfo processInfo] beginActivityWithOptions:options reason:reason];
}

void endXCMProcActivity(id<NSObject> callerProc) {
#if defined(MAC_OS_X_VERSION_MAX_ALLOWED) && MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_9
	[[NSProcessInfo processInfo] endActivity:callerProc];
#endif
}

#endif
#endif /* !__has_attribute */
/// Defined whenever the ``XCMProcesses`` is loaded.
#define XCMProcesses_h "XCMProcesses.h"
#endif /* !XCMProcesses_h */
