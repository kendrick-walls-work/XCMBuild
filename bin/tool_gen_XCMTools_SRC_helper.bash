#! /bin/bash
#
# reactive-firewall/XCMBuild custom m4 glue Tool
# ..................................
# Copyright (c) 2023-2024, Mr. Walls
# ..................................
# Licensed under APACHE-2 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# ..........................................
# http://www.apache.org/licenses/LICENSE-2.0
# ..........................................
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Disclaimer of Warranties.
# A. YOU EXPRESSLY ACKNOWLEDGE AND AGREE THAT, TO THE EXTENT PERMITTED BY
#    APPLICABLE LAW, USE OF THIS SHELL SCRIPT AND ANY SERVICES PERFORMED
#    BY OR ACCESSED THROUGH THIS SHELL SCRIPT IS AT YOUR SOLE RISK AND
#    THAT THE ENTIRE RISK AS TO SATISFACTORY QUALITY, PERFORMANCE, ACCURACY AND
#    EFFORT IS WITH YOU.
#
# B. TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, THIS SHELL SCRIPT
#    AND SERVICES ARE PROVIDED "AS IS" AND "AS AVAILABLE", WITH ALL FAULTS AND
#    WITHOUT WARRANTY OF ANY KIND, AND THE AUTHOR OF THIS SHELL SCRIPT'S LICENSORS
#    (COLLECTIVELY REFERRED TO AS "THE AUTHOR" FOR THE PURPOSES OF THIS DISCLAIMER)
#    HEREBY DISCLAIM ALL WARRANTIES AND CONDITIONS WITH RESPECT TO THIS SHELL SCRIPT
#    SOFTWARE AND SERVICES, EITHER EXPRESS, IMPLIED OR STATUTORY, INCLUDING, BUT
#    NOT LIMITED TO, THE IMPLIED WARRANTIES AND/OR CONDITIONS OF
#    MERCHANTABILITY, SATISFACTORY QUALITY, FITNESS FOR A PARTICULAR PURPOSE,
#    ACCURACY, QUIET ENJOYMENT, AND NON-INFRINGEMENT OF THIRD PARTY RIGHTS.
#
# C. THE AUTHOR DOES NOT WARRANT AGAINST INTERFERENCE WITH YOUR ENJOYMENT OF THE
#    THE AUTHOR's SOFTWARE AND SERVICES, THAT THE FUNCTIONS CONTAINED IN, OR
#    SERVICES PERFORMED OR PROVIDED BY, THIS SHELL SCRIPT WILL MEET YOUR
#    REQUIREMENTS, THAT THE OPERATION OF THIS SHELL SCRIPT OR SERVICES WILL
#    BE UNINTERRUPTED OR ERROR-FREE, THAT ANY SERVICES WILL CONTINUE TO BE MADE
#    AVAILABLE, THAT THIS SHELL SCRIPT OR SERVICES WILL BE COMPATIBLE OR
#    WORK WITH ANY THIRD PARTY SOFTWARE, APPLICATIONS OR THIRD PARTY SERVICES,
#    OR THAT DEFECTS IN THIS SHELL SCRIPT OR SERVICES WILL BE CORRECTED.
#    INSTALLATION OF THIS THE AUTHOR SOFTWARE MAY AFFECT THE USABILITY OF THIRD
#    PARTY SOFTWARE, APPLICATIONS OR THIRD PARTY SERVICES.
#
# D. YOU FURTHER ACKNOWLEDGE THAT THIS SHELL SCRIPT AND SERVICES ARE NOT
#    INTENDED OR SUITABLE FOR USE IN SITUATIONS OR ENVIRONMENTS WHERE THE FAILURE
#    OR TIME DELAYS OF, OR ERRORS OR INACCURACIES IN, THE CONTENT, DATA OR
#    INFORMATION PROVIDED BY THIS SHELL SCRIPT OR SERVICES COULD LEAD TO
#    DEATH, PERSONAL INJURY, OR SEVERE PHYSICAL OR ENVIRONMENTAL DAMAGE,
#    INCLUDING WITHOUT LIMITATION THE OPERATION OF NUCLEAR FACILITIES, AIRCRAFT
#    NAVIGATION OR COMMUNICATION SYSTEMS, AIR TRAFFIC CONTROL, LIFE SUPPORT OR
#    WEAPONS SYSTEMS.
#
# E. NO ORAL OR WRITTEN INFORMATION OR ADVICE GIVEN BY THE AUTHOR
#    SHALL CREATE A WARRANTY. SHOULD THIS SHELL SCRIPT OR SERVICES PROVE DEFECTIVE,
#    YOU ASSUME THE ENTIRE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION.
#
#    Limitation of Liability.
# F. TO THE EXTENT NOT PROHIBITED BY APPLICABLE LAW, IN NO EVENT SHALL THE AUTHOR
#    BE LIABLE FOR PERSONAL INJURY, OR ANY INCIDENTAL, SPECIAL, INDIRECT OR
#    CONSEQUENTIAL DAMAGES WHATSOEVER, INCLUDING, WITHOUT LIMITATION, DAMAGES
#    FOR LOSS OF PROFITS, CORRUPTION OR LOSS OF DATA, FAILURE TO TRANSMIT OR
#    RECEIVE ANY DATA OR INFORMATION, BUSINESS INTERRUPTION OR ANY OTHER
#    COMMERCIAL DAMAGES OR LOSSES, ARISING OUT OF OR RELATED TO YOUR USE OR
#    INABILITY TO USE THIS SHELL SCRIPT OR SERVICES OR ANY THIRD PARTY
#    SOFTWARE OR APPLICATIONS IN CONJUNCTION WITH THIS SHELL SCRIPT OR
#    SERVICES, HOWEVER CAUSED, REGARDLESS OF THE THEORY OF LIABILITY (CONTRACT,
#    TORT OR OTHERWISE) AND EVEN IF THE AUTHOR HAS BEEN ADVISED OF THE
#    POSSIBILITY OF SUCH DAMAGES. SOME JURISDICTIONS DO NOT ALLOW THE EXCLUSION
#    OR LIMITATION OF LIABILITY FOR PERSONAL INJURY, OR OF INCIDENTAL OR
#    CONSEQUENTIAL DAMAGES, SO THIS LIMITATION MAY NOT APPLY TO YOU. In no event
#    shall THE AUTHOR's total liability to you for all damages (other than as may
#    be required by applicable law in cases involving personal injury) exceed
#    the amount of five dollars ($5.00). The foregoing limitations will apply
#    even if the above stated remedy fails of its essential purpose.
################################################################################
PATH=${PATH:-"/bin:/sbin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin"} ;
umask 0112

test -x "$(command -v head)" || exit 126 ;
test -x "$(command -v sync)" || exit 126 ;
test -x "$(command -v grep)" || exit 126 ;
test -x "$(command -v cat)" || exit 126 ;
test -x "$(command -v curl)" || exit 126 ;
test -x "$(command -v find)" || exit 126 ;
test -x "$(command -v git)" || exit 126 ;
test -x "$(command -v wc)" || exit 126 ;
test -x "$(command -v dirname)" || exit 126 ;
test -x "$(command -v mkdir)" || exit 126 ;
test -x "$(command -v m4)" || exit 126 ;
test -x "$(command -v tee)" || exit 126 ;
export LANG=en_US.${STRINGS_FILE_OUTPUT_ENCODING:-"UTF-8"} ;
# shellcheck disable=SC2155,SC2046
export __CF_USER_TEXT_ENCODING=$( printf "%s" $( printf "%s\n" "${__CF_USER_TEXT_ENCODING:-0x0}" | cut -d : -f 1 ):0x08000100:0x0 ) ;
export SHELL=${SHELL:-$(xcrun --sdk macosx --find bash)} ;
# shellcheck disable=SC2086
export SCRIPTS_FOLDER_PATH="${SCRIPTS_FOLDER_PATH:-$(dirname ${0})}" ;
hash -p "${SCRIPTS_FOLDER_PATH%%/}/tool_shlock_helper.bash" shlock || test -x "$(command -v shlock)" || exit 255 ;
test -x "$(command -v shlock)" || exit 126 ;
declare LOCK_FILE="${TMPDIR:-/tmp}/org.pak.dt.XCMBuild.XCMGenSourceM4.lock" ;
declare -i PID_VALUE="${PPID:-$$}" ;
declare -i EXIT_CODE=1 ;
declare -i XCMB_MACRO_VERBOSE=${XCMB_MACRO_VERBOSE:-1} ;

function cleanup() {
	rm -f "${LOCK_FILE}" 2>/dev/null || true ; wait ;
	hash -d shlock 2>/dev/null > /dev/null || : ;
}
#declare -i VERSION=20231031

export XPC_SERVICE_NAME="XCMGenSourceM4" ;

if [[ ( $(shlock -f "${LOCK_FILE}" -p ${PID_VALUE:-$$} ) -eq 0 ) ]] ; then
	EXIT_CODE=0
	trap 'cleanup ; wait ; exit 3 ;' SIGHUP || EXIT_CODE=3
	trap 'cleanup ; wait ; exit 4 ;' SIGTERM || EXIT_CODE=4
	trap 'cleanup ; wait ; exit 5 ;' SIGQUIT || EXIT_CODE=5
	# SC2173 - https://github.com/koalaman/shellcheck/wiki/SC2173
	# trap 'rm -f ${LOCK_FILE} 2>/dev/null || true ; wait ; exit 1 ;' SIGSTOP || EXIT_CODE=7
	trap 'cleanup ; wait ; exit 7 ;' SIGXCPU || EXIT_CODE=7
	trap 'cleanup ; wait ; exit 8 ;' SIGINT || EXIT_CODE=8
	trap 'cleanup ; wait ; exit 9 ;' SIGABRT || EXIT_CODE=9
	trap 'cleanup ; wait ; exit ${EXIT_CODE:-1} ;' EXIT || EXIT_CODE=1
else
	printf "FAIL\n" >&2 ;
	false ;
	EXIT_CODE=127 ;
fi ;

if [[ ${VERBOSE_PBXCP:-NO} == *NO ]] && [[ (${XCMB_MACRO_VERBOSE:-0} -lt 1) ]] ; then
	: ;
else
	export VERBOSE_PBXCP=YES;
fi ;

function wrappedM4() {
	local JUNK="${1}" ;
	local JUNK_OUT="${2}" ;
	local JUNK_ARGS=( "${@:3:$#}" ) ;
	if [[ ( -e "${JUNK}" ) ]] ; then
	if [[ ( -f "${JUNK}") ]] ; then
	{ if [[ (${XCMB_MACRO_VERBOSE:-0} -ge 1) ]] ; then printf "%s\n" "${FUNCNAME:-$0}:${BASH_LINENO:-0}: note: Generate ${JUNK_OUT} source" || : ; fi ;
		{ { cat <"${JUNK}" |m4 "${JUNK_ARGS[@]}" || false ;} | tee "${JUNK_OUT}" > /dev/null 2>/dev/null ;} || false ;
			if [[ ${COMPILER_INDEX_STORE_ENABLE:-NO} != *NO ]] ; then wait ; sync ; fi ;
		xattr -sw com.apple.xcode.CreatedByBuildSystem true "${JUNK_OUT}" 2>/dev/null || false ;
		touch -am "${JUNK_OUT}" ; wait ;} || false ;
	if [[ ${COMPILER_INDEX_STORE_ENABLE:-NO} != *NO ]] ; then wait ; sync ; fi ;
	else
	return ;
	fi ;
	fi ;
	unset JUNK 2>/dev/null || : ;
	unset JUNK_OUT 2>/dev/null || : ;
	unset JUNK_ARGS 2>/dev/null || : ;
	true ;
}

export -f wrappedM4 ;

# shellcheck disable=SC2086
export SRCROOT="${SRCROOT:-$(git rev-parse --show-toplevel 2>/dev/null)}" ;
if [[ ( $EXIT_CODE -eq 0 ) ]] ; then
	declare -i INUM=0;
	for NAMESTUB in "Clean" "Analyze" "Archive" "Install" "DocBuild" ; do
		INUM=$(( INUM+1 ));
		{ if [[ (${XCMB_MACRO_VERBOSE:-0} -ge 1) ]] ; then printf "%s\n" "${FUNCNAME:-$0}:${BASH_LINENO:-0}: note: result is ${INUM} " ; fi ;}
		P_VAR=$(head -n ${INUM} "${SRCROOT}/shared/XCM_STUB_DESC.list" | tail -n 1 );
		EQ_VAR=$(head -n ${INUM} "${SRCROOT}/shared/XCM_STUB_EQUIV.list" | tail -n 1 );
		if [[ ( -d "${SRCROOT}/XCMBuild/XCM${NAMESTUB}" ) ]] ; then : ; else
			{ if [[ (${XCMB_MACRO_VERBOSE:-0} -ge 1) ]] ; then printf "%s\n" "${FUNCNAME:-$0}:${BASH_LINENO:-0}: note: Generate ${SRCROOT}/XCMBuild/XCM${NAMESTUB}/ directory" ; fi ;
			mkdir "${SRCROOT}/XCMBuild/XCM${NAMESTUB}" >/dev/null ;} || : ;
		fi ;
		{ wrappedM4 "${SRCROOT}/XCMBuild/XCM_STUBNAME_/XCM_STUBNAME_.h.m4" "${SRCROOT}/XCMBuild/XCM${NAMESTUB}/XCM${NAMESTUB}.h" -DSTUBNAME="${NAMESTUB}" -DPURPSTUB="${P_VAR}" -DEQUIVSTUB="${EQ_VAR}" ;
		wait ;} || : ;
		{ wrappedM4 "${SRCROOT}/XCMBuild/XCM_STUBNAME_/main.m.m4" "${SRCROOT}/XCMBuild/XCM${NAMESTUB}/main.m" -DSTUBNAME="${NAMESTUB}" -DPURPSTUB="${P_VAR}" -DEQUIVSTUB="${EQ_VAR}" ;
		wait ;} || : ;
		{ wrappedM4 "${SRCROOT}/shared/includes/XCM_STUBNAME_.make.m4" "${SRCROOT}/shared/includes/XCM${NAMESTUB}.make" -DSTUBNAME="${NAMESTUB}" ;
		wait ;} || : ;
		{ wrappedM4 "${SRCROOT}/shared/XCM_STUBNAME_-Info.plist.m4" "${SRCROOT}/shared/XCM${NAMESTUB}-Info.plist" -DSTUBNAME="${NAMESTUB}" ;
		wait ;} || : ;
		{ wrappedM4 "${SRCROOT}/shared/security/entitlements/XCM_STUBNAME_.entitlements.m4" "${SRCROOT}/shared/security/entitlements/XCM${NAMESTUB}.entitlements" -DSTUBNAME="${NAMESTUB}" ;
		wait ;} || : ;
		if [[ (${XCMB_MACRO_VERBOSE:-0} -ge 1) ]] ; then printf "%s\n" "Success: $0:${BASH_LINE_NO:-156}: note: Generated 5 sources with STUB=${NAMESTUB}" ; fi ;
		wait ;
	done;
	unset INUM 2>/dev/null || true ;
	wait ; sync ;
fi ;

unset XPC_SERVICE_NAME 2>/dev/null >/dev/null || : ;
{ cleanup || rm -f "${LOCK_FILE}" 2>/dev/null > /dev/null ;} || true ; wait ;
unset LOCK_FILE 2>/dev/null >/dev/null || : ;
# goodbye
exit "${EXIT_CODE:-255}" ;
