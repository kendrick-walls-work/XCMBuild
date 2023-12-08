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
PATH=${PATH:-"/bin:/sbin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin"} ;
umask 0117

test -x "$(command -v xcrun)" || exit 126 ;
test -x "$(command -v head)" || exit 126 ;
test -x "$(command -v sync)" || exit 126 ;
test -x "$(command -v grep)" || exit 126 ;
test -x "$(command -v curl)" || exit 126 ;
test -x "$(command -v find)" || exit 126 ;
test -x "$(command -v git)" || exit 126 ;
test -x "$(command -v curl)" || exit 126 ;
test -x "$(command -v dirname)" || exit 126 ;
export LANG=en_US.${STRINGS_FILE_OUTPUT_ENCODING:-"UTF-8"}
# shellcheck disable=SC2155,SC2046
export __CF_USER_TEXT_ENCODING=$(printf "%s" $(printf "%s\n" "${__CF_USER_TEXT_ENCODING:-0x0}" | cut -d : -f 1)":0x08000100:0x0");
# shellcheck disable=SC2086
export PROJECT_DIR="${PROJECT_DIR:-${SRCROOT:-$(pwd)}}"
# shellcheck disable=SC2086
export SHELL="${SHELL:-$(xcrun --sdk ${SDKROOT:-macosx} --find bash)}" ;
# shellcheck disable=SC2086
export GIT="${GIT:-$(xcrun --sdk ${SDKROOT:-macosx} --find git)}" ;
# shellcheck disable=SC2086
export GIT_DIR="${PROJECT_DIR:-$(${GIT} rev-parse --show-toplevel 2>/dev/null)}" ;
EXIT_CODE=0 ;
#cd ${LOCSYMROOT:-${1:-./}} ;
cd "${GIT_DIR}" || EXIT_CODE=66 ;
if [[ ! ( -d "./.git" ) ]] ; then
	printf "%s\n" "${FUNCNAME:-$0}:${BASH_LINENO:-0}: ERROR: in path: Please run this tool from ${GIT_DIR}" >&2 ;
	EXIT_CODE=66 ;
fi ;
# shellcheck disable=SC2086
export MKDIR="${MKDIR:-$(xcrun --sdk ${SDKROOT:-macosx} --find mkdir)}" ;
# shellcheck disable=SC2086
export MAKE="${MAKE:-$(xcrun --sdk ${SDKROOT:-macosx} --find make)}" ;

if [[ ( $(uname -s 2>/dev/null) == "Darwin" ) ]] ; then
	export NCPU="${NCPU:-$(sysctl -n hw.ncpu 2>/dev/null)}"
else
	export NCPU="${NCPU:-$(grep -c 'processor' /proc/cpuinfo 2>/dev/null)}"
fi

export
# shellcheck disable=SC2086
export TR="${TR:-$(xcrun --sdk ${SDKROOT:-macosx} --find tr)}" ;
ACTION="${ACTION:-${TARGET_NAME:-XCRunShellExternalTool}}" ;
# shellcheck disable=SC2086
if [[ ( ${BASH_VERSINFO[0]} -ge 4 ) ]] ; then
	export ACTION=${ACTION,,}
elif [[ ( -x "$(command -v ${TR})" ) ]] ; then
	# Developer Comment: only really care about 'est' 'aceln' and 'efilopr' technicly but best-effort heruristic
	# of extra letters helps improve readability, if only a little
	# shellcheck disable=SC2155,SC2046
	export ACTION=$( printf "%s" ${ACTION} | $TR 'ABCDEFGHIJKLMNÑOPQRSTUÜVWXYZ-' 'abcdefghijklmnñopqrstuüvwxyz ')
else
	export ACTION="${ACTION:-NoOp}"
fi ;
if [[ $EXIT_CODE -eq 0 ]] ; then
	printf "\n%s\n" "${ACTION} target ${TARGET_NAME:-unknown} of project ${PROJECT_NAME:-unknown} with configuration ${CONFIGURATION:-default}" || EXIT_CODE=1
	printf "\n%s\n" "ExternalBuildToolExecution ${0} (in target '${TARGET_NAME:-unknown}' from project '${PROJECT_NAME:-unknown}')"
	case "${ACTION}" in
		test) printf "Start %b\n" "$0" ;
			if [[ ( -f "./Makefile" ) ]] ; then
				${MAKE:-make} -j1 clean ; wait ;
				${MAKE:-make} test || EXIT_CODE=2 ;
				if [[ $EXIT_CODE -gt 0 ]] ; then
					printf "%s\n" "Makefile:test: ERROR: Testing ('make test') failed." >&2 ;
				fi ;
				wait ; ${MAKE:-make} -j1 clean 2>/dev/null || : ;
				printf "End %b\n" "$0" ;
			else
				printf "%s\n" "Makefile:open: ERROR: Opening 'Makefile' failed." >&2 ;
				printf "Stop %b\n" "$0" ;
				EXIT_CODE=126
			fi ;
			: ;;
		clean|profile) : ;;
		*) printf "%b:%i: note: Tool not configured for %s!\n" "$0" "${LINENO:-0}" "${ACTION:-NULL}" >&2 || EXIT_CODE=126 ;;
	esac ;
fi ;
exit ${EXIT_CODE:-255} ;
