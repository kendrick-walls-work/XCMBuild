#! /bin/bash

# reactive-firewall/XCMCopy Tool
# ..................................
# Copyright (c) 2017-2023, Mr. Walls
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

#	usage:
#		$0 Cmd [args ...]
#

# shellcheck disable=SC2155
function fn_do_xc_cmd() {
	# setup
	local SUB_TOOL_RESULT=0 ;
	local OLDUMASK=$(umask) ;
	# be sure to have $(xcode-select -p)/usr/bin added to dev-user's PATH
	local PATH=${PATH:-"/bin:/sbin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin"} ;
	local LANG=en_US.${STRINGS_FILE_OUTPUT_ENCODING:-"UTF-8"}
	# shellcheck disable=SC2155,SC2046
	local __CF_USER_TEXT_ENCODING=$(printf "%s" $(printf "%s\n" "${__CF_USER_TEXT_ENCODING:-0x0}" | cut -d : -f 1)":0x08000100:0x0");
	local ACTION=${ACTION:-"run"}
	cd "$(pwd)" 2>/dev/null || : ; # initialize OLDPWD = PWD
	local RETN_DIR=$(printf "%s" "${OLDPWD}") ;
	# shellcheck disable=SC2046
	local PROJECT_DIR="${PROJECT_DIR:-${SRCROOT:-$(pwd)}}"
	# shellcheck disable=SC2046
	if [[ ( -d .git ) ]] ; then PROJECT_DIR="${PROJECT_DIR:-$(git rev-parse --show-toplevel 2>/dev/null)}" ; fi
	# shellcheck disable=SC2086
	local PROJECT_NAME="${PROJECT_NAME:-$(basename ${PROJECT_DIR})}" ;
	local REF_PWD="${PROJECT_DIR:-${SRCROOT:-$(pwd)}}"
	cd "${REF_PWD}" || ( printf "%s\n" "$0:${LINENO:-0}: warning: failed to recognize build environment." >&2 && SUB_TOOL_RESULT=1 ) ;
	test -d ./.git || ( printf "%s\n" "$0:${LINENO:-0}: error: failed to validate repository status. This tool only works with git repos using a makefile for actions." >&2 && exit 126 ) ;
	if [[ ( -r "./codecov_env" ) ]] ; then
		# shellcheck disable=SC1091
		source ./codecov_env 2>/dev/null || : ;
	fi ;
	cd "${OLDPWD}" 2>/dev/null || : ;
	cd "$(pwd)" 2>/dev/null || : ; # RE-initialize OLDPWD = PWD
	local ACTION=${ACTION:-"run"}
	local TASK="${1:-${ACTION}}"
	# SYMROOT=$(xcodebuild -showBuildSettings -project "${PROJECT_DIR}"/"${PROJECT_NAME}.xcodeproj" | grep -F "SYMROOT" | cut -d\= -f 2- | cut -d\  -f2-)
	umask 0027
	# announce to IDE what is being run (also handy for CI/CD workflows)
	{ printf "\n%s\n" "${ACTION} target ${TARGET_NAME:-unknown} of project ${PROJECT_NAME:-unknown} with configuration ${CONFIGURATION:-default}" || SUB_TOOL_RESULT=1 ;
	printf "\n%s\n" "ExternalRunToolExecution ${TASK} (in target '${TARGET_NAME:-unknown}' from project '${PROJECT_NAME:-unknown}')" ;
	printf "%s\n" "Start ${TASK}\n" ;} ;
	# shellcheck disable=SC2145
	( xcrun --sdk "${SDKROOT:-macosx}" --run "${@:1:$#}" ) || false ;	# do the work
	SUB_TOOL_RESULT=$?
	printf "\n%s\n\n\n" "End ${TASK}" ;
	# revert umask
	umask "$OLDUMASK" ;
	# unwind and return to old path
	# shellcheck disable=SC2046,SC2086,SC2164
	test $(pwd) -ef ${OLDPWD} || cd "${OLDPWD}" 2>/dev/null ;
	# return to start path (if needed)
	# shellcheck disable=SC2046,SC2086,SC2164
	test $(pwd) -ef ${RETN_DIR} || cd "${RETN_DIR}" 2>/dev/null ;
	# cleanup
	unset RETN_DIR 2>/dev/null ;
	unset PROJECT_DIR 2>/dev/null ;
	unset PROJECT_NAME 2>/dev/null ;
	unset REF_PWD 2>/dev/null ;
	unset __CF_USER_TEXT_ENCODING 2>/dev/null ;
	unset OLDUMASK 2>/dev/null ;
	unset TASK 2>/dev/null ;
	unset ACTION 2>/dev/null ;
	# report back
	return ${SUB_TOOL_RESULT:-126} ;
}

export -f fn_do_xc_cmd ;

if [[ "${0}" == *xcode_run_tool* ]] ; then
	EXIT_CODE=0 ;
	# shellcheck disable=SC2086
	export SCRIPTS_FOLDER_PATH="${SCRIPTS_FOLDER_PATH:-$(dirname ${0})}" ;
	# force if / test behavior to work for caller
	# shellcheck disable=SC2068
	( ( fn_do_xc_cmd ${@:1:$#}) && true) || EXIT_CODE=$? ; false ; # no quotes to force re-spliting
	wait ; ( sync || true ) 2>/dev/null;
	exit ${EXIT_CODE:-127};
fi ;  # else import as source
