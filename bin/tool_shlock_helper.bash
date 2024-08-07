#! /bin/bash
#
# reactive-firewall/XCMBuild file-lock Tool
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

declare -ir MINPARAMS=2
declare LOCK_FILE="${LOCK_FILE:-/tmp/GIL.lock}"
declare -i PID_VALUE="${PPID:-$$}"
declare -i SHLOCK_CHECK_ONLY_MODE=1

#declare -i VERSION=20230811

test -x "$(command -v head)" || exit 126 ;
test -x "$(command -v sync)" || exit 126 ;
EXIT_CODE=1 ;

# exit codes: (caveat: not all implemented here)
# x000000 = 0 = locked by ${PID_VALUE} ;
# x000001 = 1 = not-locked by ${PID_VALUE} ; (ie when valid lock file for unknown PID)
# x000010 = 2 = should be locked by ${PID_VALUE} but some generic error occurred ;
# x000011 = 3 = could not resolve to locked nor not-locked by ${PID_VALUE} (i.e. 1+2) ;
# x000100 = 4 = locked by ${PID_VALUE} but looks like ${PID_VALUE} is gone now but still found lock (did you remember to unlock before relocking?)
# x000101 = 5 = not-locked by ${PID_VALUE} but still found lock at ${LOCK_FILE} (i.e. 1+4)
# x000110 = 6 = could not resolve to locked nor not-locked by ${PID_VALUE} but but still found lock at ${LOCK_FILE}
# x000111 = 7 = not-locked by ${PID_VALUE} but but still found lock at ${LOCK_FILE} for unknown PID (including when invalid lock file)

# macOS hints
export XPC_SERVICE_NAME="shlock" ;

if [[ ( $# -ge $MINPARAMS ) ]] ; then
	while [[ ( $# -gt 0 ) ]] ; do  # Until you run out of parameters . . .
		case "${1}" in
			-p|--pid) shift ; export PID_VALUE="${1}" ; SHLOCK_CHECK_ONLY_MODE=0 ;;
			-f|--file) shift ; export LOCK_FILE="${1}" ;;
			-d) : ;;  # not implemented
			*) printf "%b: \"%s\" Argument Unrecognized!\n" "$0" "${1}" 1>&2 ; EXIT_CODE=3 ;;
		esac ;  # Check next set of parameters.
		shift ;
	done

fi ;
if [[ ( $EXIT_CODE -lt $MINPARAMS ) ]] ; then
if [[ ( -e "${LOCK_FILE}" ) ]] ; then  # just check -e and not -r nor -f to run fast and fail on read
	if [[ ( "${PID_VALUE}" -eq $(head -n 1 "${LOCK_FILE}") ) ]] ; then
		EXIT_CODE=0 ;
		# could update with touch -am "${LOCK_FILE}"
	elif [[ ( -r "${LOCK_FILE}" ) ]] ; then  # also can just check -r here instead
		EXIT_CODE=6 ;
		PID_VALUE=$(head -n 1 "${LOCK_FILE}") ;
		if [[ ( -z $( kill -n 0 "${PID_VALUE}" 2>&1 ) ) ]] ; then
			EXIT_CODE=1 ;
		elif [[ ( $SHLOCK_CHECK_ONLY_MODE -gt 0 ) ]] ; then
			EXIT_CODE=5 ;
		fi ;
	else
		printf $"Error: Lock could not be checked\n" >&2 ;
		EXIT_CODE=7 ;
	fi
elif [[ ( -z $( kill -n 0 "${PID_VALUE}" 2>&1 ) ) ]] ; then
	# printf is builtin and often faster than echo but will interpret patterns in variables.
	# See https://www.shellcheck.net/wiki/SC2059 (In POSIX, you can instead ignore this warning.)
	# shellcheck disable=SC2059
	printf "${PID_VALUE}\n" >"${LOCK_FILE}" && :
	sync ; wait ;
	if [[ ( -r "${LOCK_FILE}" ) ]] ; then EXIT_CODE=0 ; elif [[ ( -e "${LOCK_FILE}" ) ]] ; then EXIT_CODE=2 ; else EXIT_CODE=2 ; fi ;
else
	EXIT_CODE=3 ;
	if [[ ( $SHLOCK_CHECK_ONLY_MODE -gt 0 ) ]] ; then
		# printf is builtin and often faster than echo but will interpret patterns in variables.
		# See https://www.shellcheck.net/wiki/SC2059 (In POSIX, you can instead ignore this warning.)
		# shellcheck disable=SC2059
		printf $"Error: lock \"${LOCK_FILE}\" for unknown process is invalid.\n" >&2 ;
	else
		printf $"Error: Refuse to acquire lock for unknown process %s\n" "${PID_VALUE}" >&2 ;
	fi ;
fi
fi ;
exit ${EXIT_CODE:-126} ;
