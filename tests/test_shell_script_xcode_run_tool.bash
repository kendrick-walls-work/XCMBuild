#! /bin/bash --posix
#
# reactive-firewall/XCMBuild shellscript Unit Test for PosixRunTool
# ..................................
# Copyright (c) 2023, Mr. Walls
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

ulimit -t 600
PATH="/bin:/sbin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:${PATH}"
#umask 137

LOCK_FILE="/tmp/org.pak.dt.XCMBuild.XCMTest.Unit.runtool.posix.lock"
test -x "$(command -v grep)" || exit 126 ;
test -x "$(command -v xargs)" || exit 126 ;
test -x "$(command -v find)" || exit 126 ;
test -x "$(command -v git)" || exit 126 ;
hash -p ./.github/tool_shlock_helper.sh shlock || exit 255 ;
test -x "$(command -v shlock)" || exit 126 ;
declare -i EXIT_CODE=1 ;

function cleanup() {
	rm -f "${LOCK_FILE}" 2>/dev/null || true ; wait ;
	hash -d shlock 2>/dev/null > /dev/null || true ;
}

if [[ ( $(shlock -f ${LOCK_FILE} -p $$ ) -eq 0 ) ]] ; then
		EXIT_CODE=0
		trap 'cleanup 2>/dev/null || rm -f ${LOCK_FILE} 2>/dev/null > /dev/null || true ; wait ; exit 1 ;' SIGHUP || EXIT_CODE=3
		trap 'cleanup 2>/dev/null || rm -f ${LOCK_FILE} 2>/dev/null > /dev/null || true ; wait ; exit 1 ;' SIGTERM || EXIT_CODE=4
		trap 'cleanup 2>/dev/null || rm -f ${LOCK_FILE} 2>/dev/null > /dev/null || true ; wait ; exit 1 ;' SIGQUIT || EXIT_CODE=5
		#trap 'cleanup 2>/dev/null || rm -f ${LOCK_FILE} 2>/dev/null > /dev/null || true ; wait ; exit 1 ;' SIGSTOP || EXIT_CODE=7
		trap 'cleanup 2>/dev/null || rm -f ${LOCK_FILE} 2>/dev/null > /dev/null || true ; wait ; exit 1 ;' SIGINT || EXIT_CODE=8
		trap 'cleanup 2>/dev/null || rm -f ${LOCK_FILE} 2>/dev/null > /dev/null || true || true ; wait ; exit 1 ;' SIGABRT || EXIT_CODE=9
		trap 'cleanup 2>/dev/null || rm -f ${LOCK_FILE} 2>/dev/null > /dev/null || true ; wait ; exit ${EXIT_CODE} ;' EXIT || EXIT_CODE=1
else
		# shellcheck disable=SC2046
		echo "Test already in progress by "$(head "${LOCK_FILE}") ;
		false ;
		exit 255 ;
fi

# this is how test files are found:

# THIS IS THE ACTUAL TEST
XCMT_UNIT_TEST_ROOT_DIR=$(git rev-parse --show-toplevel 2>/dev/null) ;
if [[ -d ../.git ]] ; then
	XCMT_UNIT_TEST_ROOT_DIR="../" ;
elif [[ -d ./.git ]] ; then
	XCMT_UNIT_TEST_ROOT_DIR=$(pwd) ;
elif [[ ( -d $(git rev-parse --show-toplevel 2>/dev/null) ) ]] ; then
	XCMT_UNIT_TEST_ROOT_DIR=$(git rev-parse --show-toplevel 2>/dev/null) ;
else
	echo "FAIL: missing valid repository or source structure" >&2 ;
	EXIT_CODE=40
fi

if [[ ( ${EXIT_CODE} -ne 0 ) ]] ; then
	echo "SKIP: Can't check ${XCMT_UNIT_TEST_ROOT_DIR}" ;
else
	for XCMT_UNIT_TEST_SCRIPT in $(git ls-files "${XCMT_UNIT_TEST_ROOT_DIR}/bin/xcode_run_tool.bash" 2>/dev/null ) ; do
		if [[ ( ${EXIT_CODE} -ne 0 ) ]] ; then continue ; else
			"${XCMT_UNIT_TEST_SCRIPT}" test -r "${XCMT_UNIT_TEST_SCRIPT}" || EXIT_CODE=1 ;
			"${XCMT_UNIT_TEST_SCRIPT}" test -x "${XCMT_UNIT_TEST_SCRIPT}" || EXIT_CODE=2 ;
			"${XCMT_UNIT_TEST_SCRIPT}" test -d "${XCMT_UNIT_TEST_SCRIPT}" && EXIT_CODE=3 ;
			if [[ ( ${EXIT_CODE} -ne 0 ) ]] ; then
				case "$EXIT_CODE" in
					1|2|3) echo "FAIL: '${XCMT_UNIT_TEST_SCRIPT}' is invalid." >&2 ;;
					*) echo "SKIP: Can't check '${XCMT_UNIT_TEST_SCRIPT}'" ;;
				esac
			fi ;
		fi ;
		if [[ ($(file -b --mime "${XCMT_UNIT_TEST_SCRIPT}" | grep -cF "text/x-shellscript" 2>&1 ;) -ne 1) ]] ; then
			echo "SKIP: ${XCMT_UNIT_TEST_SCRIPT} is not shellscript file. This is unexpected." ;
			if [[ ( ${EXIT_CODE} -le 0 ) ]] ; then EXIT_CODE=126 ; fi ;
		else
			if [[ ($(grep -cF "function" "${XCMT_UNIT_TEST_SCRIPT}" 2>&1 ;) -le 0) ]] ; then
				echo "FAIL: ${XCMT_UNIT_TEST_SCRIPT} is missing the bash function keyword" >&2 ;
				EXIT_CODE=127
			fi
			if [[ ( $(grep -F "function" "${XCMT_UNIT_TEST_SCRIPT}" 2>&1 | grep -coF "function fn_do_xc_cmd" 2>&1) -le 0) ]] ; then
				echo "WARN: ${XCMT_UNIT_TEST_SCRIPT} is missing a valid fn_do_xc_cmd definition beginning with posix style \"function\"" ;
			fi
		fi
	done

	unset XCMT_UNIT_TEST_ROOT_DIR 2>/dev/null || true ;
	unset XCMT_UNIT_TEST_DOC 2>/dev/null || true ;
	unset XCMT_UNIT_TEST_SCRIPT 2>/dev/null || true ;

fi ;

cleanup 2>/dev/null || rm -f "${LOCK_FILE}" 2>/dev/null > /dev/null || true ; wait ;

unset LOCK_FILE 2>/dev/null || true ;

# goodbye
exit ${EXIT_CODE:-255} ;
