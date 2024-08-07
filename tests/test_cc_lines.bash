#! /bin/bash
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
PATH="/bin:/sbin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin"
umask 137

LOCK_FILE="${TMPDIR:-/tmp}/org.pak.dt.test-cc-script.lock"
EXIT_CODE=1

test -x "$(command -v grep)" || exit 126 ;
test -x "$(command -v curl)" || exit 126 ;
test -x "$(command -v find)" || exit 126 ;
test -x "$(command -v git)" || exit 126 ;
test -x "$(command -v head)" || exit 126 ;
hash -p ./.github/tool_shlock_helper.sh shlock || exit 255 ;
test -x "$(command -v shlock)" || exit 126 ;
EXIT_CODE=1

function cleanup() {
	rm -f "${LOCK_FILE}" 2>/dev/null || true ; wait ;
	hash -d shlock 2>/dev/null > /dev/null || true ;
}

if [[ ( $(shlock -f "${LOCK_FILE}" -p $$ ) -eq 0 ) ]] ; then
		EXIT_CODE=0 ; #  only can succeed AFTER initial lock
		trap 'cleanup ; wait ; exit 1 ;' SIGHUP || EXIT_CODE=3
		trap 'cleanup ; wait ; exit 1 ;' SIGTERM || EXIT_CODE=4
		trap 'cleanup ; wait ; exit 1 ;' SIGQUIT || EXIT_CODE=5
		# SC2173 - https://github.com/koalaman/shellcheck/wiki/SC2173
		# trap 'rm -f ${LOCK_FILE} 2>/dev/null || true ; wait ; exit 1 ;' SIGSTOP || EXIT_CODE=7
		trap 'cleanup ; wait ; exit 1 ;' SIGINT || EXIT_CODE=8
		trap 'cleanup ; wait ; exit 1 ;' SIGABRT || EXIT_CODE=9
		trap 'cleanup ; wait ; exit ${EXIT_CODE} ;' EXIT || EXIT_CODE=1
else
		# shellcheck disable=SC2046
		printf "\t%s\n" "Check for Copyright lines already in progress by "$(head "${LOCK_FILE}") ;
		false ;
		exit 126 ;
fi

# this is how test files are found:

# THIS IS THE ACTUAL TEST
_TEST_ROOT_DIR="./" ;
if [[ -d ./.git ]] ; then
	_TEST_ROOT_DIR="./" ;
elif [[ -d ./tests ]] ; then
	_TEST_ROOT_DIR="./" ;
else
	printf "\t%s\n" "FAIL: missing valid folder or file" >&2 ;
	EXIT_CODE=1
fi

_TEST_YEAR=$(date -j "+%C%y" 2>/dev/null ;)

for _TEST_DOC in $(find "${_TEST_ROOT_DIR}" \( -iname '*.py' -o -iname '*.h' -o -ipath './bin/*' -o -iname '*.txt' -o -iname '*.md' \) -a -print0 | xargs -0 -L1 -I{} git ls-files "{}" 2>/dev/null; wait ;) ; do
	if [[ ($(grep -cF 'Disclaimer' "${_TEST_DOC}" 2>&1 ;) -ne 0) ]] ; then
		printf "\t%s\n" "SKIP: ${_TEST_DOC} is disclaimed." ;
		if [[ ( ${EXIT_CODE} -le 0 ) ]] ; then EXIT_CODE=126 ; fi ;
	else
		if [[ ($(grep -cF "Copyright" "${_TEST_DOC}" 2>&1 ;) -le 0) ]] ; then
			printf "\t%s\n" "FAIL: ${_TEST_DOC} is missing a copyright line" >&2 ;
			EXIT_CODE=127
		fi
		if [[ ( $(grep -F "Copyright" "${_TEST_DOC}" 2>&1 | grep -coF "Copyright (c)" 2>&1) -le 0) ]] ; then
			printf "\t%s\n" "SKIP: ${_TEST_DOC} is missing a valid copyright line beginning with \"Copyright (c)\"" ;
		fi
		if [[ ( $(grep -F "Copyright (c)" "${_TEST_DOC}" 2>&1 | grep -oE "\d+(-\d+)?" 2>&1 | grep -oE "\d{3,}$" | sort -n | tail -n1) -lt ${_TEST_YEAR}) ]] ; then
			printf "\t%s\n" "WARN: ${_TEST_DOC} is out of date without a current copyright (year)" >&2 ;
		fi
	fi
done

if [[ ( ${EXIT_CODE} -ne 0 ) ]] ; then
	case "$EXIT_CODE" in
		0|126) true && EXIT_CODE=0 ;;
		127) false ;;
		*) printf "\t%s\n" "SKIP: Unclassified issue." ;;
	esac
fi


unset _TEST_ROOT_DIR 2>/dev/null || true ;
unset _TEST_DOC 2>/dev/null || true ;
unset _TEST_YEAR 2>/dev/null || true ;

cleanup 2>/dev/null || rm -f "${LOCK_FILE}" 2>/dev/null > /dev/null || true ; wait ;

# goodbye
exit ${EXIT_CODE:-255} ;
